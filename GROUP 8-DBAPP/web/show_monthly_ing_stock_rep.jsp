<%-- 
    Document   : show_monthly_ing_stock_rep
    Created on : 11 21, 23, 5:25:57 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stock Report</title>
    </head>
    <body>
        <jsp:useBean id = "i" class = "concessionairemgt.Ingredient" scope = "session"/>
        <%
            int month = Integer.valueOf(request.getParameter("monthinput"));
            int year = Integer.valueOf(request.getParameter("yearinput"));
        %>
        <h1>Month <%= month %> of Year <%= year %> Stock Report</h1>
        
        <input type="text" id = "name" name = "name" value ="Ingredient Name" disabled>
        <input type="text" id = "used" name = "used" value ="Used This Month" disabled>
        <input type="text" id = "bought" name = "bought" value ="Bought This Month" disabled>
        <input type="text" id = "curstock" name = "curstock" value ="Current Stock" disabled>
        <br>
        <%
            i.check_Stock(month, year);
            
            for (int j = 0; j < i.stock_ing_name_list.size(); j++) {
                
            %>
                <input type="text" id = "name" name = "name" value ="<%=i.stock_ing_name_list.get(j)%>" readonly>
                <input type="text" id = "used" name = "used" value ="<%=i.used_stock_list.get(j)%>" readonly>
                <input type="text" id = "bought" name = "bought" value ="<%=i.bought_stock_list.get(j)%>" readonly>
                <input type="text" id = "curstock" name = "curstock" value ="<%=i.cur_stock_list.get(j)%>" readonly>
                <br>
            <%
            }
            %>
            <br>
            <form action = "index.html">
            <input type="submit" value="Back to Main Menu">
            </form>
    </body>
</html>
