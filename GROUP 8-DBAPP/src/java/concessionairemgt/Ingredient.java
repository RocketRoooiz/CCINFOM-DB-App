package concessionairemgt;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccslearner
 */
import java.util.*;
import java.sql.*;

public class Ingredient {
    // MUST be public identifier for easy access
    
    // variables
    public int ing_id;
    public String ing_name;
    public float ing_price;
    public int stock;
    public int supplier_id;
    
    // list of ingredients
    public ArrayList<Integer> ing_id_list = new ArrayList<>();
    public ArrayList<String> ing_name_list = new ArrayList<>();
    public ArrayList<Float> ing_pricelist = new ArrayList<>();
    public ArrayList<Integer> ing_stock_list = new ArrayList<>();
    
    // list of stock info
    public String stock_ing_name;
    public int used_stock;
    public int bought_stock;
    public int cur_stock;
    
    public ArrayList<String> stock_ing_name_list = new ArrayList<>();
    public ArrayList<Integer> used_stock_list = new ArrayList<>();
    public ArrayList<Integer> bought_stock_list = new ArrayList<>();
    public ArrayList<Integer> cur_stock_list = new ArrayList<>();
    
    public int check_Stock(int month, int year)
    {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // GETS USED INGREDIENT QUANTITIES
            PreparedStatement pstmt = conn.prepareStatement("SELECT i.ing_name, i.stock, COALESCE(SUM(ip.portion * COALESCE(pr.bought_qty, 0)), 0) AS used_quantity FROM Ingredient i LEFT JOIN Ingredient_Product ip ON i.ing_id = ip.ing_id LEFT JOIN ( SELECT pr.prod_id, pr.bought_qty, r.date_generated FROM Prod_Receipt pr JOIN Receipt r ON pr.receipt_id = r.receipt_id WHERE MONTH(r.date_generated) = ? AND YEAR(r.date_generated) = ? ) pr ON ip.prod_id = pr.prod_id GROUP BY i.ing_id, i.ing_name ORDER BY i.ing_id;");
            pstmt.setInt(1, month); // 10 FOR NOW
            pstmt.setInt(2, year); // 2023 FOR NOW
            ResultSet rst = pstmt.executeQuery();
            
            stock_ing_name_list.clear();
            used_stock_list.clear();
            bought_stock_list.clear();
            cur_stock_list.clear();
            
            while(rst.next()) {
                stock_ing_name = rst.getString("ing_name");
                cur_stock = rst.getInt("stock");
                used_stock = rst.getInt("used_quantity");

                stock_ing_name_list.add(stock_ing_name);
                used_stock_list.add(used_stock);
                cur_stock_list.add(cur_stock);
            }
            
            // GETS BOUGHT INGREDIENT STOCK
            pstmt = conn.prepareStatement("SELECT COALESCE(SUM(filtered_ir.bought_qty), 0) AS bought_quantity FROM Ingredient i LEFT JOIN ( SELECT ir.ing_id, ir.bought_qty FROM Ing_Receipt ir JOIN Receipt r ON ir.receipt_id = r.receipt_id WHERE MONTH(r.date_generated) = ? AND YEAR(r.date_generated) = ? ) filtered_ir ON i.ing_id = filtered_ir.ing_id GROUP BY i.ing_id, i.ing_name ORDER BY i.ing_id;");
            pstmt.setInt(1, month); // 10 FOR NOW
            pstmt.setInt(2, year); // 2023 FOR NOW
            rst = pstmt.executeQuery();
            
            while(rst.next()) {
                bought_stock = rst.getInt("bought_quantity");

                bought_stock_list.add(bought_stock);
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
    
    public int display_ingredients()
    {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT ing_id, ing_name, ing_price, stock FROM Ingredient;");
            ResultSet rst = pstmt.executeQuery();
            
            ing_id_list.clear();
            ing_name_list.clear();
            ing_pricelist.clear();
            ing_stock_list.clear();
            
            while(rst.next()) {
                ing_id = rst.getInt("ing_id");
                ing_name = rst.getString("ing_name");
                ing_price = rst.getFloat("ing_price");
                stock = rst.getInt("stock");

                ing_id_list.add(ing_id);
                ing_name_list.add(ing_name);
                ing_pricelist.add(ing_price);
                ing_stock_list.add(stock);
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
    
    public int add_ingredient()
    {
        try {
            // connect to db
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // generate new ingredient id
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(ing_id) + 1 AS newID FROM Ingredient;");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()) {
                ing_id = rst.getInt("newID");
            }
            
            // save the new ingredient
            // stock will always start at 0 when a new ingredient is inserted
            pstmt = conn.prepareStatement("INSERT INTO Ingredient (ing_id, ing_name, ing_price, stock, supplier_id) VALUE (?, ?, ?, 0, ?)");
            pstmt.setInt(1, ing_id);
            pstmt.setString(2, ing_name);
            pstmt.setFloat(3, ing_price);
            pstmt.setInt(4, supplier_id);
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