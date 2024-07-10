<%-- 
    Document   : reg_prod
    Created on : 11 18, 23, 10:01:01 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Ingredient Registration</title>
        
        <script>
            function validateForm() {
                var portion = document.getElementById("portion").value;

                var proceed = true;

                // Validate portion
                if (portion.trim().length === 0) {
                    alert("Please enter portion amount.");
                    proceed = false;
                } else {
                    // Validate if portion is a valid positive integer
                    try {
                        var qty = parseInt(portion);
                        if (qty < 0 || isNaN(qty)) {
                            alert("Please enter a valid positive portion amount.");
                            proceed = false;
                        }
                    } catch (e) {
                        // handle the case where portion has non-numeric characters
                        alert("Please enter a valid numeric portion amount.");
                        proceed = false;
                    }
                }

                return proceed;
            }
        </script>
    </head>
    <body>
        <jsp:useBean id = "p" class = "concessionairemgt.Product" scope = "session"/>
        <jsp:useBean id = "ing" class = "concessionairemgt.Ingredient" scope = "session"/>
        
        <% p.get_last_prod(); // getter for the newly added item in the db
        %>
        
        <h1><%=p.last_prod%> Ingredient Registration Menu</h1>
        
        <form action="prod_ing_processing.jsp" onsubmit="return validateForm();">
            Choose ingredient required for product:<select name="ing_id" id="ing_id">
            <%
                ing.display_ingredients();
                for(int i = 0; i < ing.ing_id_list.size(); i++) {
            %>
                <option value="<%=ing.ing_id_list.get(i)%>"><%=ing.ing_name_list.get(i)%></option>
            <%  }
            %>
            </select><br>

            Enter portion amount:<input type="text" id="portion" name="portion"><br>
            <br>

            <input type="submit" value="Add Ingredient to Product">
        </form>
    </body>
</html>
