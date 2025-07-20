/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Cloudinary;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class CloudinaryUtil {

    private static final Cloudinary cloudinary;

    static {
        Map<String, String> config = new HashMap<>();
        config.put("cloud_name", "dmkdqxqx6");
        config.put("api_key", "813724666765833");
        config.put("api_secret", "rE6HgCAE0wMLSB1naRnhhU2wAmk");

        cloudinary = new Cloudinary(config);
    }

    public static String upload(byte[] fileData) throws Exception {
        Map uploadResult = cloudinary.uploader().upload(fileData, ObjectUtils.asMap("resource_type", "auto"));
        return uploadResult.get("secure_url").toString();
    }

    public static String upload(String imageUrl) throws Exception {
        Map uploadResult = cloudinary.uploader().upload(imageUrl, ObjectUtils.asMap("resource_type", "auto"));
        return uploadResult.get("secure_url").toString();
    }
}
