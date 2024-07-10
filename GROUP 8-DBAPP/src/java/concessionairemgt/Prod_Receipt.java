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

public class Prod_Receipt {
    
    public int receipt_id;
    public int prod_id;
    public int bought_qty;
    public float prod_amt;
        
    public int add_prodrec()
    {
        try {
            // connect to db
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // insert the transaction to ing rec
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Prod_Receipt (receipt_id, prod_id, bought_qty, prod_amt) VALUE (?, ?, ?, ?)");
            pstmt.setInt(1, receipt_id);
            pstmt.setInt(2, prod_id);
            pstmt.setInt(3, bought_qty);
            pstmt.setFloat(4, prod_amt);
            pstmt.executeUpdate();
            
            // select the ingredients needed for the product
            pstmt = conn.prepareStatement("SELECT ing_id, portion FROM Ingredient_Product WHERE prod_id = ?");
            pstmt.setInt(1, prod_id);
            ResultSet rs = pstmt.executeQuery();
           
            while (rs.next()) {
                int ing_id = rs.getInt("ing_id");
                int portion = rs.getInt("portion");

                // update the value of stock in the ingredient (subtract from the current stock)
                pstmt = conn.prepareStatement("UPDATE Ingredient SET stock = stock - ? WHERE ing_id = ?");
                pstmt.setInt(1, bought_qty * portion); // Multiply by portion
                pstmt.setInt(2, ing_id);
                pstmt.executeUpdate();
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
}

