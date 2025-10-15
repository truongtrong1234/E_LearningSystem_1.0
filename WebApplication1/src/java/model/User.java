package model;

public class User {
    private String fullname;
    private String password;
    private String id;
    private String email;

    public User(String fullname, String password, String id, String email) {
        this.fullname = fullname;
        this.password = password;
        this.id = id;
        this.email = email;
    }

    public String getFullname() { return fullname; }
    public String getPassword() { return password; }
    public String getId() { return id; }
    public String getEmail() { return email; }
}
