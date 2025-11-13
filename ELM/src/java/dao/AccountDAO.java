package dao;

import java.sql.*;
import model.Account;
import context.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.GoogleAccount;

public class AccountDAO extends DBContext {

   // Lấy tài khoản theo ID
public Account getAccountById(int accountId) {
    String sql = "SELECT * FROM Accounts WHERE AccountID = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, accountId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Account a = new Account();
            a.setAccountId(rs.getInt("AccountID"));
            a.setEmail(rs.getString("email"));
            a.setPassword(rs.getString("password"));
            a.setName(rs.getString("name"));
            a.setPicture(rs.getString("picture"));
            a.setRole(rs.getString("role"));
            a.setWorkplace(rs.getString("workplace"));
            a.setPhone(rs.getString("phone"));
            a.setDateOfBirth(rs.getString("dateOfBirth"));
            a.setGender(rs.getString("gender"));
            a.setAddress(rs.getString("address"));
            return a;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

// Lấy danh sách tài khoản theo role
public List<Account> getAccountsByRole(String role) {
    List<Account> list = new ArrayList<>();
    String sql = "SELECT * FROM Accounts WHERE role = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, role);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Account a = new Account();
            a.setAccountId(rs.getInt("AccountID"));
            a.setEmail(rs.getString("email"));
            a.setPassword(rs.getString("password"));
            a.setName(rs.getString("name"));
            a.setPicture(rs.getString("picture"));
            a.setRole(rs.getString("role"));
            a.setWorkplace(rs.getString("workplace"));
            a.setPhone(rs.getString("phone"));
            a.setDateOfBirth(rs.getString("dateOfBirth"));
            a.setGender(rs.getString("gender"));
            a.setAddress(rs.getString("address"));
            list.add(a);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

// Lấy toàn bộ danh sách tài khoản
public List<Account> getAllAccounts() {
    List<Account> list = new ArrayList<>();
    String sql = "SELECT * FROM Accounts";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Account a = new Account();
            a.setAccountId(rs.getInt("AccountID"));
            a.setEmail(rs.getString("email"));
            a.setPassword(rs.getString("password"));
            a.setName(rs.getString("name"));
            a.setPicture(rs.getString("picture"));
            a.setRole(rs.getString("role"));
            a.setWorkplace(rs.getString("workplace"));
            a.setPhone(rs.getString("phone"));
            a.setDateOfBirth(rs.getString("dateOfBirth"));
            a.setGender(rs.getString("gender"));
            a.setAddress(rs.getString("address"));
            list.add(a);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

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
                a.setWorkplace(rs.getString("workplace"));
                a.setPhone(rs.getString("phone"));
                a.setDateOfBirth(rs.getString("dateOfBirth")); // lưu dạng NVARCHAR yyyy-MM-dd
                a.setGender(rs.getString("gender"));
                a.setAddress(rs.getString("address"));
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insert(Account a) {
        String sql = "INSERT INTO Accounts (email, password, name, picture, role, workplace, phone, dateOfBirth, gender, address) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, a.getEmail());
            ps.setString(2, a.getPassword()); // null nếu tài khoản Google
            ps.setString(3, a.getName());
            ps.setString(4, a.getPicture() != null ? a.getPicture() : "default.png"); // ảnh mặc định nếu null
            ps.setString(5, a.getRole() != null ? a.getRole() : "learner"); // mặc định learner
            ps.setString(6, a.getWorkplace());
            ps.setString(7, a.getPhone());
            ps.setString(8, a.getDateOfBirth()); // lưu kiểu NVARCHAR yyyy-MM-dd
            ps.setString(9, a.getGender());
            ps.setString(10, a.getAddress());

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

    // Cập nhật thông tin tài khoản
    public boolean update(Account a) {
        String sql = "UPDATE Accounts SET "
                + "password=?, name=?, picture=?, role=?, "
                + "workplace=?, phone=?, dateOfBirth=?, gender=?, address=? "
                + "WHERE email=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, a.getPassword());
            ps.setString(2, a.getName());
            ps.setString(3, a.getPicture());
            ps.setString(4, a.getRole());
            ps.setString(5, a.getWorkplace());
            ps.setString(6, a.getPhone());
            ps.setString(7, a.getDateOfBirth()); // lưu NVARCHAR yyyy-MM-dd
            ps.setString(8, a.getGender());
            ps.setString(9, a.getAddress());
            ps.setString(10, a.getEmail());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

  // Đăng nhập
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
            a.setWorkplace(rs.getString("workplace"));
            a.setPhone(rs.getString("phone"));
            a.setDateOfBirth(rs.getString("dateOfBirth"));
            a.setGender(rs.getString("gender"));
            a.setAddress(rs.getString("address"));
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
            String sql;
            PreparedStatement ps;

            if (account == null) {
                // Nếu email chưa có → tự động insert vào DB
                sql = "INSERT INTO Accounts (email, password, name, picture, role, workplace, phone, dateOfBirth, gender, address) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, googleUser.getEmail());
                ps.setNull(2, java.sql.Types.VARCHAR); // password null vì đăng nhập bằng Google
                ps.setString(3, googleUser.getName());
                ps.setString(4, googleUser.getPicture());
                ps.setString(5, googleUser.getRole() != null ? googleUser.getRole() : "learner");
                ps.setString(6, googleUser.getWorkplace());
                ps.setString(7, googleUser.getPhone());

                // Xử lý dateOfBirth nếu có
                if (googleUser.getDateOfBirth() != null && !googleUser.getDateOfBirth().isEmpty()) {
                    java.sql.Date sqlDate = java.sql.Date.valueOf(googleUser.getDateOfBirth());
                    ps.setDate(8, sqlDate);
                } else {
                    ps.setNull(8, java.sql.Types.DATE);
                }

                ps.setString(9, googleUser.getGender());
                ps.setString(10, googleUser.getAddress());

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        googleUser.setAccountId(rs.getInt(1));
                    }
                }
                System.out.println("Đã tạo tài khoản mới từ Google: " + googleUser.getEmail());

            } else {
                // Nếu đã có → cập nhật lại thông tin từ Google
                sql = "UPDATE Accounts SET name=?, picture=?, workplace=?, phone=?, dateOfBirth=?, gender=?, address=? WHERE email=?";
                ps = connection.prepareStatement(sql);
                ps.setString(1, googleUser.getName());
                ps.setString(2, googleUser.getPicture());
                ps.setString(3, googleUser.getWorkplace());
                ps.setString(4, googleUser.getPhone());

                if (googleUser.getDateOfBirth() != null && !googleUser.getDateOfBirth().isEmpty()) {
                    java.sql.Date sqlDate = java.sql.Date.valueOf(googleUser.getDateOfBirth());
                    ps.setDate(5, sqlDate);
                } else {
                    ps.setNull(5, java.sql.Types.DATE);
                }

                ps.setString(6, googleUser.getGender());
                ps.setString(7, googleUser.getAddress());
                ps.setString(8, googleUser.getEmail());

                ps.executeUpdate();
                System.out.println("Cập nhật thông tin tài khoản Google: " + googleUser.getEmail());
            }

            // Sau khi insert hoặc update, trả về bản ghi mới nhất từ DB
            return findByEmail(googleUser.getEmail());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
         Account newAcc = new Account();
        newAcc.setEmail("testuser@gmail.com");
        newAcc.setPassword("123456"); 
        newAcc.setName("Nguyen Van Test");
        newAcc.setPicture("default.png");
        newAcc.setRole("learner");
        newAcc.setWorkplace("ABC Company");
        newAcc.setPhone("0123456789");
        newAcc.setDateOfBirth("2000-05-10");
        newAcc.setGender("Nam");
        newAcc.setAddress("Hanoi, Vietnam");

        // Thực hiện insert
        boolean result = dao.insert(newAcc);

        // Kiểm tra kết quả
        if(result) {
            System.out.println("Insert thành công! AccountID: " + newAcc.getAccountId());
        } else {
            System.out.println("Insert thất bại!");
        }
    
        

    }
}
