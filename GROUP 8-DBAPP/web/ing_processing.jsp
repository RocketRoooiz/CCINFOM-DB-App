<%-- 
    Document   : ing_processing
    Created on : 11 15, 23, 6:47:11 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Ingredient Processing</title>
    </head>
    <body>
        <jsp:useBean id = "i" class = "concessionairemgt.Ingredient" scope = "session"/>
        
        <form action = "index.html">
            <%
                String ing_name = request.getParameter("ing_name");
                float ing_price = Float.valueOf(request.getParameter("ing_price"));
                int supplier_id = Integer.valueOf(request.getParameter("supplier_id"));
                
                i.ing_name = ing_name;
                i.ing_price = ing_price;
                i.supplier_id = supplier_id;

                int status = i.add_ingredient();
                                
                if(status == 1) {
            %>
            <h1>Registered Ingredient Successfully</h1>
            <%  } else {
            %>
            <h1>Registering Ingredient Failed Due to Duplicate Name</h1>
            <%  }
            %>
            <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
