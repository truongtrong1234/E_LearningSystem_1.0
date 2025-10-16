package dao;

import java.sql.*;
import model.Account;
import dao.DBContext;
import model.GoogleAccount;

public class AccountDAO extends DBContext {

    // ✅ Lấy tài khoản theo email
    public Account findByEmail(String email) {
        String sql = "SELECT * FROM Accounts WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setAccountId(rs.getInt("AccountID"));
                a.setEmail(rs.getString("email"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPicture(rs.getString("picture"));
                a.setRole(rs.getString("role"));
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Thêm tài khoản mới
    public boolean insert(Account a) {
        String sql = "INSERT INTO Accounts (email, password, name, picture, role) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, a.getEmail());
            ps.setString(2, a.getPassword());
            ps.setString(3, a.getName());
            ps.setString(4, a.getPicture());
            ps.setString(5, a.getRole());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    a.setAccountId(rs.getInt(1));
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Cập nhật thông tin
    public boolean update(Account a) {
        String sql = "UPDATE Accounts SET password=?, name=?, picture=?, role=? WHERE email=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, a.getPassword());
            ps.setString(2, a.getName());
            ps.setString(3, a.getPicture());
            ps.setString(4, a.getRole());
            ps.setString(5, a.getEmail());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Đăng nhập
    public Account login(String email, String password) {
        String sql = "SELECT * FROM Accounts WHERE email=? AND password=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setAccountId(rs.getInt("AccountID"));
                a.setEmail(rs.getString("email"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPicture(rs.getString("picture"));
                a.setRole(rs.getString("role"));
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Account insertOrUpdateFromGoogle(GoogleAccount googleUser) {
    if (googleUser == null || googleUser.getEmail() == null) {
        return null;
    }

    try {
        Account account = findByEmail(googleUser.getEmail());

        if (account == null) {
            // 🟢 Nếu email chưa có → tự động insert vào DB
            account = new Account();
            account.setEmail(googleUser.getEmail());
            account.setName(googleUser.getName());
            account.setPicture(googleUser.getPicture());
            account.setRole("learner"); // mặc định là learner

            String sql = "INSERT INTO Accounts(email, name, picture, role) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, account.getEmail());
            ps.setString(2, account.getName());
            ps.setString(3, account.getPicture());
            ps.setString(4, account.getRole());
            int rows = ps.executeUpdate();

            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    account.setAccountId(rs.getInt(1));
                }
            }

            System.out.println("✅ Đã tạo tài khoản mới từ Google: " + account.getEmail());
        } else {
            // 🟡 Nếu đã có → cập nhật lại thông tin Google
            account.setName(googleUser.getName());
            account.setPicture(googleUser.getPicture());

            String sql = "UPDATE Accounts SET name=?, picture=? WHERE email=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, account.getName());
            ps.setString(2, account.getPicture());
            ps.setString(3, account.getEmail());
            ps.executeUpdate();

            System.out.println("🔁 Cập nhật thông tin tài khoản Google: " + account.getEmail());
        }

        return account;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}

    public static void main(String[] args) {
           AccountDAO dao = new AccountDAO();

        // 🟢 1️⃣ Test thêm tài khoản mới
        Account newAcc = new Account();
        newAcc.setEmail("testuser@example.com");
        newAcc.setPassword("123456");
        newAcc.setName("Test User");
        newAcc.setPicture("https://example.com/avatar.jpg");
        newAcc.setRole("learner");

        boolean inserted = dao.insert(newAcc);
        if (inserted) {
            System.out.println("✅ Insert thành công! ID mới: " + newAcc.getAccountId());
        } else {
            System.out.println("❌ Insert thất bại!");
        }

        // 🟡 2️⃣ Test đăng nhập
        Account loginAcc = dao.login("testuser@example.com", "123456");
        if (loginAcc != null) {
            System.out.println("✅ Login thành công!");
            System.out.println("Tên người dùng: " + loginAcc.getName());
            System.out.println("Vai trò: " + loginAcc.getRole());
        } else {
            System.out.println("❌ Login thất bại (sai email hoặc password).");
        }

        // 🔵 3️⃣ Test cập nhật thông tin
        if (loginAcc != null) {
            loginAcc.setName("User Updated");
            loginAcc.setPicture("https://example.com/new-avatar.jpg");
            boolean updated = dao.update(loginAcc);
            if (updated) {
                System.out.println("✅ Cập nhật thành công!");
            } else {
                System.out.println("❌ Cập nhật thất bại!");
            }
        }

        // 🔴 4️⃣ Test Google login update (chỉ update nếu email tồn tại)
        Account googleAcc = new Account();
        googleAcc.setEmail("testuser@example.com"); // email đã tồn tại
        googleAcc.setName("Google Updated User");
        googleAcc.setPicture("https://example.com/google-avatar.jpg");

    }
}
