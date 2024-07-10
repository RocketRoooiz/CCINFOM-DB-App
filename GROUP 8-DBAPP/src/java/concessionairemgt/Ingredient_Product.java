/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package concessionairemgt;

/**
 *
 * @author ccslearner
 */
import java.util.*;
import java.sql.*;

public class Ingredient_Product {
    
    public int ing_id;
    public int prod_id;
    public int portion;
    
    public ArrayList<Integer> ing_id_list = new ArrayList<>();
    public ArrayList<Integer> portion_list = new ArrayList<>();
    
    public int get_ingprod(int prod_id)
    {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT ing_id, portion FROM Ingredient_Product WHERE prod_id = ?;");
            pstmt.setInt(1, prod_id);
            ResultSet rst = pstmt.executeQuery();
            
            ing_id_list.clear();
            portion_list.clear();
            
            while(rst.next()) {
                ing_id = rst.getInt("ing_id");
                portion = rst.getInt("portion");

                ing_id_list.add(ing_id);
                portion_list.add(portion);
            }
            
            pstmt.close();
            conn.close();
            System.out.println("Success!");
            
            return 1;
        } catch(Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int add_ingprod()
    {
        try {
            // connect to db
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // insert the connection to ing prod
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Ingredient_Product (ing_id, prod_id, portion) VALUE (?, ?, ?)");
            pstmt.setInt(1, ing_id);
            pstmt.setInt(2, prod_id);
            pstmt.setInt(3, portion);
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            System.out.println("Success!");
            
            return 1;
        } catch(Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public static void main(String args[])
    {
        
    }
}
