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

public class Receipt {
    
    public int receipt_id;
    public String receipt_type;
    
    public int last_id;
    public String last_type; // if "P" or "I"
    
    public String item_name;
    public int item_qty;
    public float receipt_price;
    public float item_price;
    
    public ArrayList<String> item_name_list = new ArrayList<>();
    public ArrayList<Integer> item_qty_list = new ArrayList<>();
    public ArrayList<Float> receipt_pricelist = new ArrayList<>();
    public ArrayList<Float> item_pricelist = new ArrayList<>();
    
    public String monthly_month;
    public float monthly_cost;
    public float monthly_revenue;
    public float monthly_profit;
    
    public ArrayList<String> monthly_month_list = new ArrayList<>();
    public ArrayList<Float> monthly_cost_list = new ArrayList<>();
    public ArrayList<Float> monthly_revenue_list = new ArrayList<>();
    public ArrayList<Float> monthly_profit_list = new ArrayList<>();
    
    public int generate_item_sales(int year)
    {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
                        
            PreparedStatement pstmt = conn.prepareStatement("SELECT MONTH(r.date_generated) AS month, COALESCE(ROUND(SUM(ir.ing_amt), 2), 0.00) AS cost, COALESCE(ROUND(SUM(pr.prod_amt), 2), 0.00) AS revenue, COALESCE(ROUND(SUM(pr.prod_amt), 2), 0.00) - COALESCE(ROUND(SUM(ir.ing_amt), 2), 0.00) AS profit FROM Receipt r LEFT JOIN Ing_Receipt ir ON r.receipt_id = ir.receipt_id LEFT JOIN Prod_Receipt pr ON r.receipt_id = pr.receipt_id WHERE YEAR(r.date_generated) = ? GROUP BY MONTH(r.date_generated);");
            pstmt.setInt(1, year);
            ResultSet rst = pstmt.executeQuery();
            
            monthly_month_list.clear();
            monthly_cost_list.clear();
            monthly_revenue_list.clear();
            monthly_profit_list.clear();
            
            while(rst.next()) {
                monthly_month = rst.getString("month");
                monthly_cost = rst.getFloat("cost");
                monthly_revenue = rst.getFloat("revenue");
                monthly_profit = rst.getFloat("profit");
                
                monthly_month_list.add(monthly_month);
                monthly_cost_list.add(monthly_cost);
                monthly_revenue_list.add(monthly_revenue);
                monthly_profit_list.add(monthly_profit);
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
    
    public int get_prodrec_deets(int rec_id)
    {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
                        
            PreparedStatement pstmt = conn.prepareStatement("SELECT p.prod_name, SUM(pr.bought_qty) AS qty, SUM(pr.prod_amt) AS total_price, p.prod_price AS unit_price FROM Prod_Receipt pr JOIN Product p ON pr.prod_id = p.prod_id WHERE pr.receipt_id = ? GROUP BY prod_name;");
            pstmt.setInt(1, rec_id);
            ResultSet rst = pstmt.executeQuery();
            
            item_name_list.clear();
            item_qty_list.clear();
            receipt_pricelist.clear();
            item_pricelist.clear();
            
            while(rst.next()) {
                item_name = rst.getString("p.prod_name");
                item_qty = rst.getInt("qty");
                receipt_price = rst.getFloat("total_price");
                item_price = rst.getFloat("unit_price");
                
                item_name_list.add(item_name);
                item_qty_list.add(item_qty);
                receipt_pricelist.add(receipt_price);
                item_pricelist.add(item_price);
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
    
    public int get_ingrec_deets(int rec_id)
    {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT i.ing_name, SUM(ir.bought_qty) AS qty, SUM(ir.ing_amt) AS total_price, i.ing_price AS unit_price FROM Ing_Receipt ir JOIN Ingredient i ON ir.ing_id = i.ing_id WHERE ir.receipt_id = ? GROUP BY ing_name;");
            pstmt.setInt(1, rec_id);
            ResultSet rst = pstmt.executeQuery();
            
            item_name_list.clear();
            item_qty_list.clear();
            receipt_pricelist.clear();
            item_pricelist.clear();
            
            while(rst.next()) {
                item_name = rst.getString("i.ing_name");
                item_qty = rst.getInt("qty");
                receipt_price = rst.getFloat("total_price");
                item_price = rst.getFloat("unit_price");
                
                item_name_list.add(item_name);
                item_qty_list.add(item_qty);
                receipt_pricelist.add(receipt_price);
                item_pricelist.add(item_price);
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
    
    public int get_last_rec() {
        try {
            // connect to db
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // get the last product in the db
            PreparedStatement pstmt = conn.prepareStatement("SELECT receipt_id, receipt_type FROM Receipt ORDER BY receipt_id DESC LIMIT 1;");
            ResultSet rst = pstmt.executeQuery();
                     
            while(rst.next()) {
                last_id = rst.getInt("receipt_id");
                last_type = rst.getString("receipt_type");
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
    
    public int add_receipt()
    {
        try {
            // connect to db
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // generate new receipt id
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(receipt_id) + 1 AS newID FROM Receipt;");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()) {
                receipt_id = rst.getInt("newID");
            }
            
            // save the new receipt
            pstmt = conn.prepareStatement("INSERT INTO Receipt (receipt_id, receipt_type, date_generated) VALUE (?, ?, NOW())");
            pstmt.setInt(1, receipt_id);
            pstmt.setString(2, receipt_type);
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
