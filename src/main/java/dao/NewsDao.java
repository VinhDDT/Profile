/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.News;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class NewsDao {

    private Connection conn;

    public NewsDao() {
        conn = db.ConnectData.getConnection();
    }

    //author: KhoaDDCE181988 - Use in: ViewNews,..
    public List<News> getAll() {
        List<News> newsList = new ArrayList<>();
        String query = "SELECT * FROM News Where IsPublished = 1"; // Truy vấn để lấy tất cả dữ liệu từ bảng Cart

        try ( PreparedStatement stmt = conn.prepareStatement(query);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setTitle(rs.getString("Title"));
                news.setSummary(rs.getString("Summary"));
                news.setImageURL(rs.getString("ImageURL"));
                news.setDatePosted(rs.getTimestamp("DatePosted"));
                news.setIsPublished(rs.getBoolean("IsPublished"));
                news.setUserId(rs.getInt("UserID"));
                news.setBuildingID(rs.getInt("BuildingID"));
                news.setContent(rs.getString("Content"));
                news.setViewcount(rs.getLong("Viewcount"));
                newsList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log hoặc ném ra ngoại lệ
        }

        return newsList; // Trả về danh sách cart
    }

    //author: KhoaDDCE181988 - Use in: ViewNewsDashboard,..
    public List<News> getAllNewsDashboard() {
        List<News> newsList = new ArrayList<>();
        String query = "SELECT * FROM News"; // Truy vấn để lấy tất cả dữ liệu từ bảng Cart

        try ( PreparedStatement stmt = conn.prepareStatement(query);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setTitle(rs.getString("Title"));
                news.setSummary(rs.getString("Summary"));
                news.setImageURL(rs.getString("ImageURL"));
                news.setDatePosted(rs.getTimestamp("DatePosted"));
                news.setIsPublished(rs.getBoolean("IsPublished"));
                news.setUserId(rs.getInt("UserID"));
                news.setBuildingID(rs.getInt("BuildingID"));
                news.setContent(rs.getString("Content"));
                news.setViewcount(rs.getLong("Viewcount"));
                newsList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log hoặc ném ra ngoại lệ
        }

        return newsList; // Trả về danh sách cart
    }

    //author: KhoaDDCE181988 - Use in: ViewNewsDetail,..
    public News getNewsById(int id) {
        News news = null;
        try {
            String sql = "SELECT * FROM news WHERE newsID = ?";
            PreparedStatement psNews = conn.prepareStatement(sql);
            psNews.setInt(1, id);
            ResultSet rs = psNews.executeQuery();

            if (rs.next()) {
                news = new News();
                news.setNewsID(rs.getInt("newsID"));
                news.setTitle(rs.getString("Title"));
                news.setSummary(rs.getString("Summary"));
                news.setImageURL(rs.getString("ImageURL"));
                news.setDatePosted(rs.getTimestamp("DatePosted"));
                news.setIsPublished(rs.getBoolean("IsPublished"));
                news.setUserId(rs.getInt("UserId"));
                news.setBuildingID(rs.getInt("BuildingID"));
                news.setViewcount(rs.getLong("Viewcount"));
                news.setContent(rs.getString("Content"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return news;
    }

    //author: KhoaDDCE181988 - Use in: DeleteNewsDashboard,..
    public void deleteNews(int id) throws SQLException {
        String sql = "DELETE FROM News WHERE newsID = ?";
        try ( Connection conn = db.ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    //author: KhoaDDCE181988 - Use in: EditNewsDashboard,..
    public int editNewsDashboard(int id, News newInfo) {
        int count = 0;

        try {
            String sql = "UPDATE News SET title=?, summary=?, imageURL=?, isPublished=?, userId=?, buildingID=?, content=? WHERE newsID=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, newInfo.getTitle());
            ps.setString(2, newInfo.getSummary());
            ps.setString(3, newInfo.getImageURL());
            ps.setBoolean(4, newInfo.isIsPublished());
            ps.setInt(5, newInfo.getUserId());
            ps.setInt(6, newInfo.getBuildingID());
            ps.setString(7, newInfo.getContent());
            ps.setInt(8, id);

            count = ps.executeUpdate();
            return count;
        } catch (SQLException ex) {
            Logger.getLogger(NewsDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    //author: KhoaDDCE181988 - Use in: addNewsDashboard,..
    public int addNewsDashboard(News news) {
        int count = 0;

        try {
            String sql = "insert into News (Title, Summary, ImageURL, DatePosted, IsPublished, UserId, BuildingID, [Content]) values(?,?,?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, news.getTitle());
            pst.setString(2, news.getSummary());
            pst.setString(3, news.getImageURL());
            Timestamp currentTimestamp = Timestamp.valueOf(LocalDateTime.now());
            pst.setTimestamp(4, currentTimestamp);
            pst.setBoolean(5, news.isIsPublished());
            pst.setInt(6, news.getUserId());
            pst.setInt(7, news.getBuildingID());
            pst.setString(8, news.getContent());
            count = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(NewsDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    //author: KhoaDDCE181988 - Use in: ViewNews,..
    public void increaseViewCount(int newsId) {
        String sql = "UPDATE News SET ViewCount = ViewCount + 1 WHERE NewsID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newsId);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(); // hoặc log nếu dùng Logger
        }
    }

}
