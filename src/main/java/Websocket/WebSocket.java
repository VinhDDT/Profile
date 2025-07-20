package Websocket;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import dao.CustomerDao;
import dao.MessageDao;
import dao.UserDao;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.CloseReason;
import jakarta.websocket.EndpointConfig;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import jakarta.websocket.Session;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Customers;
import org.json.JSONArray;
import org.json.JSONObject;

@ServerEndpoint(value = "/notification", configurator = HttpSessionConfigurator.class)

public class WebSocket {

//    private static final Set<Session> anonymousSessions = Collections.synchronizedSet(new HashSet< Session>());
//    private static final Map<Integer, Session> userSessions = Collections.synchronizedMap(new HashMap<Integer, Session>());
    private static final Map<Integer, Session> customerSessions = Collections.synchronizedMap(new HashMap<Integer, Session>());
    private static final Map<Integer, Session> receptionistSessions = Collections.synchronizedMap(new HashMap<Integer, Session>());

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        HttpSession httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());

        if (httpSession != null) {
            String customerIdStr = (String) httpSession.getAttribute("customerId");
            String receptionistStr = (String) httpSession.getAttribute("reception");

            if (customerIdStr != null) {
                try {
                    System.out.println("✅ Kết nối WebSocket của customerId: " + customerIdStr);

                    int customerId = Integer.parseInt(customerIdStr);
                    session.getUserProperties().put("customerId", customerId); // lưu thêm userId
                    customerSessions.put(customerId, session);
                    CustomerDao customerDao = new CustomerDao();
                    customerDao.UpdateCustomerOnl(customerId, 1);
                    System.out.println("➡️ Đã lưu session cho customerId: " + customerId);
                } catch (NumberFormatException e) {
                    System.out.println("⚠️ customerId không hợp lệ: " + customerIdStr);
                }
            } else if (receptionistStr != null) {
                try {
                    System.out.println("✅ Kết nối WebSocket của receptionistStr: " + receptionistStr);

                    int receptionistId = Integer.parseInt(receptionistStr);
                    session.getUserProperties().put("reception", receptionistId); // lưu thêm userId
                    receptionistSessions.put(receptionistId, session);
                    UserDao userDao = new UserDao();
                    userDao.UpdateStatusOnl(receptionistId, 1);
                    System.out.println("➡️ Đã lưu session cho receptionistId: " + receptionistId);
                } catch (NumberFormatException e) {
                    System.out.println("⚠️ receptionistId không hợp lệ: " + receptionistStr);
                }
            } else {
                System.out.println("❌ Không tìm thấy customerId hay receptionistId trong HttpSession.");
            }
        } else {
            System.out.println("❌ Không có HttpSession - người dùng chưa đăng nhập.");
        }

    }

    @OnClose
    public void onClose(Session session, CloseReason reason) {
        Integer receptionistId = (Integer) session.getUserProperties().get("reception");
        Integer customerId = (Integer) session.getUserProperties().get("customerId");

        if (receptionistId != null) {
            // Cập nhật trạng thái offline
            UserDao userDao = new UserDao();
            userDao.UpdateStatusOnl(receptionistId, 0);
            System.out.println("➡️ Đã cập nhật trạng thái offline cho receptionistId: " + receptionistId);

            // Xoá session khỏi danh sách đang online
            receptionistSessions.remove(receptionistId);
            System.out.println("❌ Đã xóa session của receptionistId: " + receptionistId);
        } else if (customerId != null) {
            CustomerDao customerDao = new CustomerDao();
            customerDao.UpdateCustomerOnl(customerId, 0);
            receptionistSessions.remove(customerId);
            System.out.println("❌ Đã xóa session của customerId: " + customerId);
        } else {
            System.out.println("⚠️ Không tìm thấy 'reception' hoặc 'customerId' trong userProperties.");
        }
    }

    @OnMessage
    public void onMessage(String messageJson, Session session) {
        System.out.println("💬 Nhận được JSON từ client: " + messageJson);

        Integer receptionistIdOnl = (Integer) session.getUserProperties().get("reception");
        Integer customerIdOnl = (Integer) session.getUserProperties().get("customerId");
        int customerId = 0;
        MessageDao messageDao = new MessageDao();
        List<Customers> recentCustomers = messageDao.getRecentSenders();

        // biến list thành chuổi 
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new JsonSerializer<LocalDateTime>() {
                    @Override
                    public JsonElement serialize(LocalDateTime src, java.lang.reflect.Type typeOfSrc, JsonSerializationContext context) {
                        return new JsonPrimitive(src.toString());
                    }
                })
                .registerTypeAdapter(LocalDateTime.class, new JsonDeserializer<LocalDateTime>() {
                    @Override
                    public LocalDateTime deserialize(JsonElement json, java.lang.reflect.Type typeOfT, JsonDeserializationContext context) {
                        return LocalDateTime.parse(json.getAsString());
                    }
                })
                .create();
        String jsonList = gson.toJson(recentCustomers);
        System.out.println("📋 recentCustomers.size = " + recentCustomers.size());

// Gói lại trong JSON có type để client biết đây là danh sách
        String recentListJson = new JSONObject()
                .put("type", "recentSenders")
                .put("data", new JSONArray(jsonList))
                .toString();
        
        if(receptionistIdOnl!=null){
        if (session.isOpen()) {
            try {
                
                session.getBasicRemote().sendText(recentListJson);
            } catch (IOException ex) {
                Logger.getLogger(WebSocket.class.getName()).log(Level.SEVERE, null, ex);
            }}
}
        for (Session s : receptionistSessions.values()) {
            if (s.isOpen()) {
                try {
                    s.getBasicRemote().sendText(recentListJson);

                } catch (IOException ex) {
                    Logger.getLogger(WebSocket.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        try {

            System.out.println("📦 Danh sách toàn bộ userSessions:");
            for (Map.Entry<Integer, Session> entry : receptionistSessions.entrySet()) {
                System.out.println("🔑 userId: " + entry.getKey() + " → sessionId: " + entry.getValue().getId());
            }
// biến chuỗi thành đối tượng
            JSONObject json = new JSONObject(messageJson);
            if (json.getString("customerId") != null) {
                customerId = json.getInt("customerId");
            }
            String senderType = json.getString("senderType");
            String messageContent = json.getString("message");

            System.out.println("📨 [" + senderType + "] gửi: " + messageContent);

            UserDao userdao = new UserDao();

            int checkReception = userdao.checkIsOnl();
            Session targetSession = customerSessions.get(customerId);
            if (targetSession != null && targetSession.isOpen()) {
                targetSession.getBasicRemote().sendText(messageJson);
            }
            if (checkReception != 0 || receptionistIdOnl != 0) {
                System.out.println("checkReception" + checkReception);
                messageDao.saveMessageStaffOn(customerId, checkReception, senderType, messageContent);
                Session staffSession = receptionistSessions.get(checkReception);
                if (staffSession != null && staffSession.isOpen()) {
                    staffSession.getBasicRemote().sendText(messageJson);
                }
            } else if (checkReception == 0) {
                messageDao.saveMessageStaffOff(customerId, senderType, messageContent);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //     @OnMessage
    //    public void onMessage(String messageJson, Session session) {
    //        try {
    //            // Phân tích chuỗi JSON
    //            JSONObject json = new JSONObject(messageJson);
    //            if (json.getString("customerId") != null) {
    //                int id = json.getInt("customerId");
    //            }
    //            String senderType = json.getString("senderType"); 
    //            String messageContent = json.getString("message");
    //
    ////            String receiverType = json.optString("receiverType", "staff"); // mặc định gửi cho staff
    //            System.out.println("📨 [" + senderType + "] gửi: " + messageContent);
    //
    //            // Gửi lại cho bên kia
    //                for (Session s : session.getOpenSessions()) {
    //                    if (s.isOpen() && s != session) {
    //                        s.getBasicRemote().sendText(messageJson);
    //                    }
    //                }
    //            // Gửi lại cho bên kia 
    //                for (Session s : session.getOpenSessions()) {
    //                    if (s.isOpen()) {
    //                        Integer uid = (Integer) s.getUserProperties().get("reception");
    //                        if (uid != null && uid == 2) {
    //                            s.getBasicRemote().sendText(messageJson);
    //                        }
    //                    }
    //                } 
    //            UserDao userdao = new UserDao();
    //            int checkReception = userdao.checkIsOnl();
    //            if (checkReception != 0) {
    //
    //            }
    //
    //        } catch (Exception e) {
    //            e.printStackTrace();
    //        }
    //    }
    //    
    //    public static void sendNotificationTo(int userId, String message) {
    //        Session session = userSessions.get(userId);
    //        if (session != null && session.isOpen()) {
    //            try {
    //                session.getBasicRemote().sendText(message);
    //            } catch (IOException e) {
    //                e.printStackTrace();
    //            }
    //        }
    //    }
    //    public static void sendNotificationTo(int userId, String message, String userType) {
    //    Session session = null;
    //
    //    if ("customer".equals(userType)) {
    //        session = customerSessions.get(userId);
    //    } else if ("reception".equals(userType)) {
    //        session = receptionistSessions.get(userId);
    //    }
    //
    //    if (session != null && session.isOpen()) {
    //        try {
    //            session.getBasicRemote().sendText(message);
    //        } catch (IOException e) {
    //            e.printStackTrace();
    //        }
    //    }
    //}

    public static void sendNotificationToAll(String message) {

//        System.out.println("👥 Tổng kết nối: " + userSessions.size());
//        for (Map.Entry<Integer, Session> entry : userSessions.entrySet()) {
//            try {
//                Integer userId = entry.getKey();
//                Session session = entry.getValue();
//                session.getBasicRemote().sendText(message);
//                System.out.println("➡️ Đang gửi tới userId: " + userId);
//                if (session != null && session.isOpen()) {
//                    try {
//                        session.getBasicRemote().sendText(message);
//                        System.out.println("✅ Gửi thành công tới userId: " + userId);
//                    } catch (IOException e) {
//                        System.out.println("❌ Lỗi khi gửi tới userId: " + userId);
//                        e.printStackTrace();
//                    }
//                } else {
//                    System.out.println("⚠️ Session null hoặc đóng cho userId: " + userId);
//                }
//            } catch (IOException ex) {
//                Logger.getLogger(WebSocket.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
    }
//    
//  @OnClose
//    public void onClose(Session session, CloseReason reason
//    ) {
//        Integer userIdToRemove = null;
//
//        // Duyệt qua tất cả các entry để tìm userId có session trùng
//        for (Map.Entry<Integer, Session> entry : userSessions.entrySet()) {
//            if (entry.getValue().equals(session)) {
//                userIdToRemove = entry.getKey();
//                break;
//            }
//        }
//
//        // Nếu tìm thấy thì xóa
//        if (userIdToRemove != null) {
//            userSessions.remove(userIdToRemove);
//            System.out.println("User " + userIdToRemove + " disconnected.");
//        } else {
//            System.out.println("A session disconnected but no matching user found.");
//        }
//    }

}
