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

public class Product {
    
    public int prod_id;
    public String prod_name;
    public float prod_price;
    public boolean avail_term1;
    public boolean avail_term2;
    public boolean avail_term3;
    
    public int last_id;
    public String last_prod;
    
    public ArrayList<Integer> prod_id_list = new ArrayList<>();
    public ArrayList<String> prod_name_list = new ArrayList<>();
    public ArrayList<Float> prod_pricelist = new ArrayList<>();
    
    public int display_products()
    {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT p.prod_id, p.prod_name, p.prod_price FROM Product p WHERE (p.avail_term1 = TRUE OR p.avail_term2 = TRUE OR p.avail_term3 = TRUE) AND NOT EXISTS (SELECT ip.prod_id, ip.ing_id, ip.portion, i.stock FROM Ingredient_Product ip JOIN Ingredient i ON ip.ing_id = i.ing_id WHERE ip.prod_id = p.prod_id AND (i.stock < ip.portion OR i.stock IS NULL));");
            ResultSet rst = pstmt.executeQuery();
            
            prod_id_list.clear();
            prod_name_list.clear();
            prod_pricelist.clear();
            
            while(rst.next()) {
                prod_id = rst.getInt("prod_id");
                prod_name = rst.getString("prod_name");
                prod_price = rst.getFloat("prod_price");

                prod_id_list.add(prod_id);
                prod_name_list.add(prod_name);
                prod_pricelist.add(prod_price);
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
    
    public int get_last_prod() {
        try {
            // connect to db
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // get the last product in the db
            PreparedStatement pstmt = conn.prepareStatement("SELECT prod_id, prod_name FROM Product WHERE prod_id = (SELECT MAX(prod_id) FROM Product);");
            ResultSet rst = pstmt.executeQuery();
                     
            while(rst.next()) {
                last_id = rst.getInt("prod_id");
                last_prod = rst.getString("prod_name");
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
    
    public int add_product()
    {
        try {
            // connect to db
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // generate new product id
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(prod_id) + 1 AS newID FROM Product;");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()) {
                prod_id = rst.getInt("newID");
            }
            
            // save the new product
            pstmt = conn.prepareStatement("INSERT INTO Product (prod_id, prod_name, prod_price, avail_term1, avail_term2, avail_term3) VALUE (?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, prod_id);
            pstmt.setString(2, prod_name);
            pstmt.setFloat(3, prod_price);
            pstmt.setBoolean(4, avail_term1);
            pstmt.setBoolean(5, avail_term2);
            pstmt.setBoolean(6, avail_term3);
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
