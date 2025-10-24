package model;

public class Category {
    private int cate_id; 
    private String cate_name; 

    public Category(int cate_id, String cate_name) {
        this.cate_id = cate_id;
        this.cate_name = cate_name;
    }

    public Category() {}

    public int getCate_id() {
        return cate_id;
    }

    public void setCate_id(int cate_id) {
        this.cate_id = cate_id;
    }

    public String getCate_name() {
        return cate_name;
    }

    public void setCate_name(String cate_name) {
        this.cate_name = cate_name;
    }
//
//    // 👉 Thêm hai getter alias để JSP hiểu
//    public int getCategoryID() {
//        return cate_id;
//    }
//
//    public String getCategoryName() {
//        return cate_name;
//    }

    @Override
    public String toString() {
        return "Category{" + "cate_id=" + cate_id + ", cate_name=" + cate_name + '}';
    }
}
