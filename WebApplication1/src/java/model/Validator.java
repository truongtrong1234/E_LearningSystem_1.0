package model;

public class Validator {

    public String validateUser(User user) {
        StringBuilder sb = new StringBuilder();

        // Check password
        String pw = user.getPassword();
        if (pw.length() < 12)
            sb.append("❌ Password: <12 ký tự.<br>");
        else sb.append("✅ Password: Đủ 12 ký tự.<br>");

        if (!pw.matches(".*[A-Z].*"))
            sb.append("❌ Password: Không có chữ hoa.<br>");
        else sb.append("✅ Password: Có chữ hoa.<br>");

        if (!pw.matches(".*[!@#$%^&*(),.?\":{}|<>].*"))
            sb.append("❌ Password: Không có ký tự đặc biệt.<br>");
        else sb.append("✅ Password: Có ký tự đặc biệt.<br>");

        if (!pw.matches(".*[0-9].*"))
            sb.append("❌ Password: Không có chữ số.<br>");
        else sb.append("✅ Password: Có chữ số.<br><br>");

        // Full name
        String name = user.getFullname();
        if (!name.matches("^[a-zA-Z\\sÀ-ỹ]+$"))
            sb.append("❌ FullName: Có số hoặc ký tự đặc biệt.<br>");
        else sb.append("✅ FullName: Hợp lệ.<br>");

        if (name.length() < 2 || name.length() > 50)
            sb.append("❌ FullName: Độ dài không hợp lệ.<br>");
        else sb.append("✅ FullName: Độ dài hợp lệ.<br><br>");

        // ID
        String id = user.getId();
        if (!id.matches("^[A-Z]{2}.*"))
            sb.append("❌ ID: Không có 2 chữ đầu đại diện tên.<br>");
        else sb.append("✅ ID: Có 2 chữ đầu hợp lệ.<br>");

        if (id.length() < 6 || id.length() > 9)
            sb.append("❌ ID: Độ dài không hợp lệ.<br>");
        else sb.append("✅ ID: Độ dài hợp lệ.<br>");

        if (id.contains(" ") || id.matches(".*[^A-Za-z0-9].*"))
            sb.append("❌ ID: Có ký tự đặc biệt hoặc dấu cách.<br>");
        else sb.append("✅ ID: Không chứa ký tự đặc biệt hoặc dấu cách.<br><br>");

        // Email
        String email = user.getEmail();
        if (!email.contains("@"))
            sb.append("❌ Email: Thiếu @.<br>");
        else sb.append("✅ Email: Có @.<br>");

        if (!email.matches(".*\\.com$|.*\\.vn$"))
            sb.append("❌ Email: Không có .com hoặc .vn.<br>");
        else sb.append("✅ Email: Có .com hoặc .vn.<br>");

        if (!email.matches(".*@.+\\..+"))
            sb.append("❌ Email: Domain không hợp lệ.<br>");
        else sb.append("✅ Email: Domain hợp lệ.<br>");

        return sb.toString();
    }
}
