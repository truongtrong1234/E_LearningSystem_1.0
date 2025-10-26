package dao;
import model.Category;
import context.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author nvtha
 */
public class CategoryDAO extends DBContext{
    public  List<Category> getAllCat(){
        List<Category> list = new ArrayList();
        String sql="Select c.CategoryID id ,c.CategoryName name from Category c";
        try {
            PreparedStatement stm=connection.prepareStatement(sql);
            ResultSet rs= stm.executeQuery();
            while(rs.next()){
                Category cat = new Category(rs.getInt("id")
                        , rs.getString("name"));
                list.add(cat);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return  list;
    }
    public Category getCategoryById(int id) {
    String sql = "SELECT c.CategoryID AS id, c.CategoryName AS name FROM Category c WHERE c.CategoryID = ?";
    try {
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return new Category(rs.getInt("id"), rs.getString("name"));
        }
    } catch (SQLException ex) {
        Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
}

    public static void main(String[] args) {
        List<Category> list = new CategoryDAO().getAllCat();
        for (Category cat : list) {
            System.out.println(cat.getCate_id());
        }
    }
}
