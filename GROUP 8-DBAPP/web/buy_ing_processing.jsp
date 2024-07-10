<%-- 
    Document   : buy_ing_processing
    Created on : 11 19, 23, 4:31:37 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buy Ingredient Processing</title>
    </head>
    <body>
        <jsp:useBean id = "r" class = "concessionairemgt.Receipt" scope = "session"/>
        <jsp:useBean id = "irec" class = "concessionairemgt.Ing_Receipt" scope = "session"/>
        <jsp:useBean id = "i" class = "concessionairemgt.Ingredient" scope = "session"/>  
        
        <form action = "ing_menu.jsp"> 
            <%
                r.get_last_rec();
                
                int ing_id = Integer.valueOf(request.getParameter("ing_id"));
                String bought_qty = request.getParameter("bought_qty");
                                
                irec.receipt_id = r.last_id;
                irec.ing_id = ing_id;
                irec.bought_qty = Integer.valueOf(bought_qty);
                irec.ing_amt = irec.bought_qty * Float.valueOf(request.getParameter("ing_price"));

                int status = irec.add_ingrec();
                                
                if(status == 1) {
            %>
            <h1>Ingredient Bought Successfully</h1>
            <%  } else {
            %>
            <h1>Unable to Buy Ingredient</h1>
            <%  }
            %>
            <input type="submit" value="Buy More Ingredients">
        </form>
        
        <form action = "show_receipt.jsp">
            <input type="submit" value="Print Receipt">
        </form>
    </body>
</html>
