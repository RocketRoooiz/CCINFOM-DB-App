<%-- 
    Document   : ing_menu
    Created on : 11 19, 23, 12:02:48 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Buy Ingredient</title>
    
    <script type="text/javascript">
        function validateForm() {
            var boughtQty = document.getElementById("bought_qty").value;

            var proceed = true;

            // Validate bought_qty
            if (boughtQty.trim().length === 0) {
                alert("Please enter quantity.");
                proceed = false;
            } else {
                // Validate if bought_qty is a valid positive integer
                try {
                    var qty = parseInt(boughtQty);
                    if (qty < 0 || isNaN(qty)) {
                        alert("Please enter a valid positive numeric quantity.");
                        proceed = false;
                    }
                } catch (e) {
                    // handle the case where boughtQty has non-numeric characters
                    alert("Please enter a valid numeric quantity.");
                    proceed = false;
                }
            }

            return proceed;
        }
        
        document.addEventListener("DOMContentLoaded", function() {
            // Update the displayed price and stock based on the first option initially
            updateValues();
        });

        function updateValues() {
            // Get the selected option from the dropdown
            var dropdown = document.getElementById("ing_id");
            var selectedOption = dropdown.options[dropdown.selectedIndex];

            // Get the corresponding price and stock values
            var price = selectedOption.getAttribute("data-price");
            var stock = selectedOption.getAttribute("data-stock");

            // Update the price and stock textboxes
            document.getElementById("ing_price").value = price;
            document.getElementById("stock").value = stock;
        }
    </script>
</head>
<body>
    <h1>Buy Ingredient Menu</h1>

    <jsp:useBean id="ing" class="concessionairemgt.Ingredient" scope="session" />
    
    <form action="buy_ing_processing.jsp" onsubmit="return validateForm();">
        Choose ingredient: <select name="ing_id" id="ing_id" onchange="updateValues()">
            <%
                ing.display_ingredients();
                for (int i = 0; i < ing.ing_id_list.size(); i++) {
            %>
            <option value="<%=ing.ing_id_list.get(i)%>" data-price="<%=ing.ing_pricelist.get(i)%>"
                data-stock="<%=ing.ing_stock_list.get(i)%>"><%=ing.ing_name_list.get(i)%></option>
            <%
                }
            %>
        </select><br>

        Price:<input type="text" id="ing_price" name="ing_price" readonly><br>
        Current Stock:<input type="text" id="stock" name="stock" readonly><br>

        Enter quantity:<input type="text" id="bought_qty" name="bought_qty"><br>
        <br>

        <input type="submit" value="Buy Ingredient">
    </form>
</body>
</html>