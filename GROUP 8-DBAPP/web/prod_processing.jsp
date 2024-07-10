<%-- 
    Document   : prod_processing
    Created on : 11 18, 23, 10:55:43 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Product Processing</title>
    </head>
    <body>
        <jsp:useBean id = "p" class = "concessionairemgt.Product" scope = "session"/>
             
        <%
            String prod_name = request.getParameter("prod_name");
            float prod_price = Float.valueOf(request.getParameter("prod_price"));
                                   
            // Get the "term" parameter values
            String[] termValues = request.getParameterValues("term");
            ArrayList<String> availability = new ArrayList<>();
            
            // Check if "term" parameter is not null and not empty
            if (termValues != null) {
                availability.addAll(Arrays.asList(termValues));
            }
            
            p.prod_name = prod_name;
            p.prod_price = prod_price;
            p.avail_term1 = availability.contains("Term 1");
            p.avail_term2 = availability.contains("Term 2");
            p.avail_term3 = availability.contains("Term 3");

            int status = p.add_product();
            
            if(status == 1) {
        %>
        <h1>Registered Product Successfully</h1>
        <form action = "reg_prod_ing.jsp">
            <input type="submit" value="Add Product Ingredients">
        </form>
        <%  } else {
        %>
        <h1>Registering Product Failed Due to Duplicate Name</h1>
        <form action = "index.html">
            <input type="submit" value="Return to Menu">
        </form>
        <%  }
        %>
    </body>
</html>
