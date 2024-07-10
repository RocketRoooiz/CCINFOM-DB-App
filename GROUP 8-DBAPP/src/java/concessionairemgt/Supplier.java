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

public class Supplier {
    
    public int supplier_id;
    public String supplier_name;
    public String email;
    public long contact_no;
    public boolean avail_Mon;
    public boolean avail_Tues;
    public boolean avail_Wed;
    public boolean avail_Thurs;
    public boolean avail_Fri;
    public boolean avail_Sat;
    public boolean avail_Sun;

    public ArrayList<Integer> sup_id_list = new ArrayList<>();
    public ArrayList<String> sup_name_list = new ArrayList<>();
    
    public int display_suppliers()
    {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT supplier_id, supplier_name FROM Supplier;");
            ResultSet rst = pstmt.executeQuery();
            
            sup_id_list.clear();
            sup_name_list.clear();
            
            while(rst.next()) {
                supplier_id = rst.getInt("supplier_id");
                supplier_name = rst.getString("supplier_name");
                
                sup_id_list.add(supplier_id);
                sup_name_list.add(supplier_name);
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

    public int add_supplier()
    {
        try {
            // connect to db
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DBAPPSQL?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful!");
            
            // generate new supplier id
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(supplier_id) + 1 AS newID FROM Supplier;");
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()) {
                supplier_id = rst.getInt("newID");
            }
            
            // save the new supplier
            pstmt = conn.prepareStatement("INSERT INTO Supplier (supplier_id, supplier_name, email, contact_no, avail_Mon, avail_Tues, avail_Wed, avail_Thurs, avail_Fri, avail_Sat, avail_Sun) VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, supplier_id);
            pstmt.setString(2, supplier_name);
            pstmt.setString(3, email);
            pstmt.setLong(4, contact_no);
            pstmt.setBoolean(5, avail_Mon);
            pstmt.setBoolean(6, avail_Tues);
            pstmt.setBoolean(7, avail_Wed);
            pstmt.setBoolean(8, avail_Thurs);
            pstmt.setBoolean(9, avail_Fri);
            pstmt.setBoolean(10, avail_Sat);
            pstmt.setBoolean(11, avail_Sun);
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
        Supplier s = new Supplier();
    }
}
