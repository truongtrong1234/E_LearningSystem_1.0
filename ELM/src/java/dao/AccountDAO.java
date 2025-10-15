/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.Account;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.GoogleAccount;

public class AccountDAO extends DBContext{
    public Account insertOrUpdateFromGoogle(GoogleAccount googleUser) {
    if (googleUser == null || googleUser.getEmail() == null) {
        return null;
    }

    try {
        // 1. Kiểm tra email đã tồn tại chưa
        Account account = findByEmail(googleUser.getEmail());
        if (account == null) {
            // 2. Nếu chưa có, tạo mới
            account = new Account();
            account.setEmail(googleUser.getEmail());
            account.setName(googleUser.getName());
            account.setPicture(googleUser.getPicture());
            account.setRole("learner"); // default role

            String sql = "INSERT INTO Accounts(email, name, picture, role) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, account.getEmail());
            ps.setString(2, account.getName());
            ps.setString(3, account.getPicture());
            ps.setString(4, account.getRole());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                // Lấy id auto-generated
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    account.setAccountId(rs.getInt(1));
                }
            }
        } else {
            // 3. Nếu đã có → cập nhật thông tin mới
            account.setName(googleUser.getName());
            account.setPicture(googleUser.getPicture());

            String sql = "UPDATE Accounts SET name=?, picture=? WHERE email=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, account.getName());
            ps.setString(2, account.getPicture());
            ps.setString(3, account.getEmail());
            ps.executeUpdate();
        }

        // 4. Trả về account sau khi insert/update
        return account;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}

    // ===== 1. Find account by email =====
    public Account findByEmail(String email) {
        String sql = "SELECT * FROM Accounts WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToAccount(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ===== 2. Insert local account =====
    public boolean insertAccount(Account acc) {
        String sql = "INSERT INTO Accounts(email, password, name, first_name, family_name, role, provider) "
                   + "VALUES (?, ?, ?, ?, ?, ?, 'local')";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, acc.getEmail());
            ps.setString(2, acc.getPassword());
            ps.setString(3, acc.getName());
            ps.setString(4, acc.getRole());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===== 3. Insert Google account =====
    public boolean insertGoogleAccount(Account acc) {
        String sql = "INSERT INTO Account(email, name, first_name, family_name, picture, verified_email, provider, provider_id, role) "
                   + "VALUES (?, ?, ?, ?, ?, ?, 'google', ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, acc.getEmail());
            ps.setString(2, acc.getPassword());
            ps.setString(3, acc.getName());
            ps.setString(4, acc.getRole());
            ps.setString(8, acc.getRole() != null ? acc.getRole() : "learner");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===== 4. Update account info =====
    public boolean updateAccount(Account acc) {
        String sql = "UPDATE Account SET name=?, first_name=?, family_name=?, picture=?, verified_email=?, role=? WHERE email=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            
            ps.setString(6, acc.getRole());
            ps.setString(7, acc.getEmail());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===== 5. Check login local =====
    public Account checkLogin(String email, String password) {
        String sql = "SELECT * FROM Account WHERE email=? AND password=? AND provider='local'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password); // nhớ hash password trước khi so sánh
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToAccount(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ===== Helper: map ResultSet to Account =====
    private Account mapResultSetToAccount(ResultSet rs) throws SQLException {
        Account acc = new Account();
        acc.setAccountId(rs.getInt("account_id"));
        acc.setEmail(rs.getString("email"));
        acc.setPassword(rs.getString("password"));
        acc.setName(rs.getString("name"));
        acc.setPicture(rs.getString("picture"));
        acc.setRole(rs.getString("role"));
        return acc;
    }
    public static void main(String[] args) {
        try {
        AccountDAO dao = new AccountDAO(); // nhớ DBContext phải kết nối thành công

        // Giả lập token trả về GoogleAccount
        GoogleAccount googleUser = new GoogleAccount( "123456789",
            "testuser@gmail.com",
            "Test User",
            "https://example.com/pic.jpg");

        // Gọi hàm insertOrUpdateFromGoogle
        Account account = dao.insertOrUpdateFromGoogle(googleUser);

        if (account != null) {
            System.out.println("Insert/Update thành công:");
            System.out.println(account);
        } else {
            System.out.println("Thất bại khi insert/update GoogleAccount.");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    }
}
