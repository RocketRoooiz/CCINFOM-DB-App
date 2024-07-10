<%-- 
    Document   : show_monthly_revenue
    Created on : 11 20, 23, 11:57:17 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Revenue Report</title>
    </head>
    <body>
        <jsp:useBean id = "r" class = "concessionairemgt.Receipt" scope = "session"/>
        <%
            int year = Integer.valueOf(request.getParameter("yearrevinput"));
        %>
        <h1><%= year %> Monthly Item Sales Report</h1>
        
        <input type="text" id = "month" name = "month" value ="Month" disabled>
        <input type="text" id = "cost" name = "cost" value ="Cost" disabled>
        <input type="text" id = "revenue" name = "revenue" value ="Revenue" disabled>
        <input type="text" id = "profit" name = "profit" value ="Profit" disabled>
        <br>
        <%
            r.generate_item_sales(year);
            
            for (int i = 0; i < r.monthly_month_list.size(); i++) {
                
            %>
                <input type="text" id = "month" name = "month" value ="<%=r.monthly_month_list.get(i)%>" readonly>
                <input type="text" id = "cost" name = "cost" value ="<%=r.monthly_cost_list.get(i)%>" readonly>
                <input type="text" id = "revenue" name = "revenue" value ="<%=r.monthly_revenue_list.get(i)%>" readonly>
                <input type="text" id = "profit" name = "profit" value ="<%=r.monthly_profit_list.get(i)%>" readonly>
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