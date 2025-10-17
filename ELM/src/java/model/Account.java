package model;


public class Account {
    private int accountId;
    private String email;
    private String password;       // null nếu login bằng Google
    private String name;
    private String picture;
    private String role; 

    // ===== Constructors =====
    public Account() {
    }

    public Account(String email, String password, String name) {
        this.email = email;
        this.password = password;
        this.name = name;
    }
    
    public Account(int accountId, String email, String password, String name, String picture, String role) {
        this.accountId = accountId;
        this.email = email;
        this.password = password;
        this.name = name;
        this.picture = picture;
        this.role = role;
    }
    

    // ===== Getters & Setters =====
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

    @Override
    public String toString() {
        return "Account{" + "accountId=" + accountId + ", email=" + email + ", password=" + password + ", name=" + name + ", picture=" + picture + ", role=" + role + '}';
    }
    
}
