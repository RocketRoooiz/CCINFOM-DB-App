<%-- 
    Document   : buy_prod_processing
    Created on : 11 19, 23, 10:28:20 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buy Product Processing</title>
    </head>
    <body>
        <jsp:useBean id = "r" class = "concessionairemgt.Receipt" scope = "session"/>
        <jsp:useBean id = "prec" class = "concessionairemgt.Prod_Receipt" scope = "session"/>
        <jsp:useBean id = "ip" class = "concessionairemgt.Ingredient_Product" scope = "session"/>
        <jsp:useBean id = "ing" class = "concessionairemgt.Ingredient" scope = "session"/>
        
        <form action = "prod_menu.jsp">
            <%
                r.get_last_rec(); // getter for last receipt id
                ing.display_ingredients(); // updates the list of ingredients and their info (getter for stock of the selected ing to be specific)
                
                int prod_id = Integer.valueOf(request.getParameter("prod_id"));
                int bought_qty = Integer.valueOf(request.getParameter("bought_qty"));
                                
                ip.get_ingprod(prod_id); // gets the ingredients (id and portion) needed for the product
                
                boolean proceed = true;
                int status;
                               
                for(int i = 0; i < ip.ing_id_list.size(); i++)
                {
                    int cur_stock = ing.ing_stock_list.get(ip.ing_id_list.get(i)-1);
                    int to_consume = ip.portion_list.get(i) * bought_qty;

                    if(cur_stock - to_consume < 0)
                        proceed = false;
                }
                
                if(proceed)
                {
                    prec.receipt_id = r.last_id;
                    prec.prod_id = prod_id;
                    prec.bought_qty = bought_qty;
                    prec.prod_amt = prec.bought_qty * Float.valueOf(request.getParameter("prod_price"));

                    status = prec.add_prodrec();
                } else {
                    status = 0;
                }

                if(status == 1) {
            %>
            <h1>Product Bought Successfully</h1>
            <%  } else {
            %>
            <h1>Unable to Buy Product Due to Insufficient Ingredients</h1>
            <%  }
            %>
            <input type="submit" value="Buy More Products">
        </form>
        
        <form action = "show_receipt.jsp">
            <input type="submit" value="Print Receipt">
        </form>
    </body>
</html>
