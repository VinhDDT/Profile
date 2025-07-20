/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import jakarta.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class FileUploader {

    public static String uploadImage(Part part, String uploadDir ) throws IOException, jakarta.servlet.ServletException {
        
        // Lấy tên file
        String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

        // Tạo thư mục nếu chưa tồn tại
        Path path = Paths.get(uploadDir);
        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }

        // Ghi file vào thư mục
        part.write(uploadDir + "/" + fileName);

        // Trả về tên file (có thể dùng lưu vào DB)
        return fileName;
    }
}
