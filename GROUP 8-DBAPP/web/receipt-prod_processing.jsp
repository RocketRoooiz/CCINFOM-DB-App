<%-- 
    Document   : receipt-prod_processing
    Created on : 11 19, 23, 2:57:41 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Receipt Generation for Ingredient</title>
    </head>
    <body>
        <jsp:useBean id = "r" class = "concessionairemgt.Receipt" scope = "session"/>
        <jsp:useBean id = "pr" class = "concessionairemgt.Prod_Receipt" scope = "session"/>  
            <%
                r.receipt_type = "P";
                int status = r.add_receipt();
                
                response.sendRedirect("prod_menu.jsp");
            %>
    </body>
</html>