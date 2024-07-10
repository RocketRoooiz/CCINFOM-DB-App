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

public class Ing_Receipt {
    
    public int receipt_id;
    public int ing_id;
    public int bought_qty;
    public float ing_amt;
    
    public int add_ingrec()
    {
        try {
            // connect to db
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // insert the transaction to ing rec
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Ing_Receipt (receipt_id, ing_id, bought_qty, ing_amt) VALUE (?, ?, ?, ?)");
            pstmt.setInt(1, receipt_id);
            pstmt.setInt(2, ing_id);
            pstmt.setInt(3, bought_qty);
            pstmt.setFloat(4, ing_amt);
            pstmt.executeUpdate();
            
            // update the value of stock in the ingredient (add to the current stock)
            pstmt = conn.prepareStatement("UPDATE Ingredient SET stock = stock + ? WHERE ing_id = ?");
            pstmt.setInt(1, bought_qty);
            pstmt.setInt(2, ing_id);
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
}
