package util;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.Map;
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 50,       // 50MB
    maxRequestSize = 1024 * 1024 * 100    // 100MB
)
public class CloudinaryUtil {
    private static Cloudinary cloudinary;

    static {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "djpjnepbg",       
            "api_key", "678226971344114",
            "api_secret", "HsRHJYbg1OJ8jSFEc96hp9hk1Vs",
            "secure", true
        ));
    }
    public static String uploadImage(Part filePart) throws Exception {
        InputStream input = filePart.getInputStream();
        byte[] bytes = input.readAllBytes();
        Map result = cloudinary.uploader().upload(
                bytes,
                ObjectUtils.asMap(
                        "resource_type", "image", 
                        "type", "upload"
                )
        );
         String url = (String) result.get("secure_url");
        return url;
    }

    
     public static String uploadFile(Part filePart, String resource_type) throws Exception {
        InputStream input = filePart.getInputStream();
        byte[] bytes = input.readAllBytes();
        Map result = cloudinary.uploader().upload(
                bytes,
                ObjectUtils.asMap(
                        "resource_type", resource_type, 
                        "type", "upload"
                )
        );
        String url = (String) result.get("secure_url");
        return url;
    }
}
