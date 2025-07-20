/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Websocket;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.HandshakeResponse;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpointConfig;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class HttpSessionConfigurator extends ServerEndpointConfig.Configurator {

    @Override
    public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
        HttpSession httpSession = (HttpSession) request.getHttpSession(); 

    if (httpSession != null) {
        String userId = (String) httpSession.getAttribute("customerId");
        config.getUserProperties().put(HttpSession.class.getName(), httpSession); // lưu session lại
//        config.getUserProperties().put("customerId", userId); // có thể không cần dòng này nếu bạn lấy session trực tiếp sau
    }
    }

}
