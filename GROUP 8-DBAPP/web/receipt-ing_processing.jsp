<%-- 
    Document   : receipt-ing_processing
    Created on : 11 19, 23, 2:30:48 PM
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
            <%
                r.receipt_type = "I";
                int status = r.add_receipt();
                
                response.sendRedirect("ing_menu.jsp");
            %>
    </body>
</html>
