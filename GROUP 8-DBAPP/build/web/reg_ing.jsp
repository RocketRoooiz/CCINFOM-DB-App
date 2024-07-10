<%-- 
    Document   : reg_ing
    Created on : 11 18, 23, 9:10:30 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingredient Registration</title>
        
        <script>
            function validateForm() {
                var ingName = document.getElementById("ing_name").value;
                var ingPrice = document.getElementById("ing_price").value;

                var proceed = true;

                // Validate ingredient name
                if (ingName == null || ingName.trim().length === 0) {
                    alert("Please enter ingredient name.");
                    proceed = false;
                }

                // Validate ingredient price
                if (ingPrice == null || ingPrice.trim().length === 0) {
                    alert("Please enter ingredient price.");
                    proceed = false;
                } else {
                    // Validate if price is a negative number
                    try {
                        var price = parseFloat(ingPrice);
                        if (price < 0 || isNaN(price)) {
                            alert("Please enter a valid positive numeric price.");
                            proceed = false;
                        }
                    } catch (e) {
                        // handle the case where ingPrice has non-numeric characters
                        alert("Please enter a valid numeric price.");
                        proceed = false;
                    }
                }

                return proceed;
            }
        </script>
    </head>
    <body>
        <h1>Ingredient Registration Menu</h1>
        
        <jsp:useBean id = "s" class = "concessionairemgt.Supplier" scope = "session"/>
        
        <form action="ing_processing.jsp"  onsubmit="return validateForm();">
            Select supplier:<select name="supplier_id" id="supplier_id">
            <%
                s.display_suppliers();
                for(int i = 0; i < s.sup_id_list.size(); i++) {
            %>
                <option value="<%=s.sup_id_list.get(i)%>"><%=s.sup_name_list.get(i)%></option>
            <%  }
            %>
            </select><br>

            Enter ingredient name:<input type="text" id="ing_name" name="ing_name"><br>
            <br>

            Enter price:<input type="text" id="ing_price" name="ing_price"><br>
            <br>
            
            <input type="submit" value="Register Ingredient">
        </form>
    </body>
</html>
