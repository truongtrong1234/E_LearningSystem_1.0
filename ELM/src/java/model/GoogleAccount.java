package model;

public class GoogleAccount {

    private int accountId;
    private String email;
    private String password;       // null nếu login bằng Google
    private String name;
    private String picture;
    private String role;
    private String workplace;      // Nơi công tác
    private String phone;          // Số điện thoại
    private String dateOfBirth;    // Ngày sinh (dạng String, ví dụ "2000-05-10")
    private String gender;         // Giới tính
    private String address;        // Địa chỉ

    public GoogleAccount() {
    }

    public GoogleAccount(int accountId, String email, String password, String name, String picture,
            String role, String workplace, String phone, String dateOfBirth,
            String gender, String address) {
        this.accountId = accountId;
        this.email = email;
        this.password = password;
        this.name = name;
        this.picture = picture;
        this.role = role;
        this.workplace = workplace;
        this.phone = phone;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.address = address;
    }

    // Getters và Setters
    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getWorkplace() {
        return workplace;
    }

    public void setWorkplace(String workplace) {
        this.workplace = workplace;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
