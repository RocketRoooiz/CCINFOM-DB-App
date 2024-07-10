<%-- 
    Document   : prod_ing_processing
    Created on : 11 19, 23, 12:07:16 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Product Ingredient Processing</title>
    </head>
    <body>
        <jsp:useBean id = "p" class = "concessionairemgt.Product" scope = "session"/>
        <jsp:useBean id = "pi" class = "concessionairemgt.Ingredient_Product" scope = "session"/>

        <%
            p.get_last_prod();

            int ing_id = Integer.valueOf(request.getParameter("ing_id"));
            int portion = Integer.valueOf(request.getParameter("portion"));
            
            pi.ing_id = ing_id;
            pi.prod_id = p.last_id;
            pi.portion = portion;

            int status = pi.add_ingprod();
            
            if(status == 1) {
        %>
        <h1>Registered Product Ingredient Successfully</h1>
        <%  } else {
        %>
        <h1>Registering Product Ingredient Failed</h1>
        <%  }
        %>
        <form action = "reg_prod_ing.jsp">
            <input type="submit" value="Add More Product Ingredients">
        </form>
        <form action = "index.html">
            <input type="submit" value="Back to Menu">
        </form>
    </body>
</html>
