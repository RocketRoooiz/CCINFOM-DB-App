<%-- 
    Document   : prod_menu
    Created on : 11 19, 23, 10:13:05 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buy Product</title>
        
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
                var dropdown = document.getElementById("prod_id");
                var selectedOption = dropdown.options[dropdown.selectedIndex];

                // Get the corresponding price value
                var price = selectedOption.getAttribute("data-price");

                // Update the price textbox
                document.getElementById("prod_price").value = price;
            }
        </script>
    </head>
    <body>
        <h1>Buy Product Menu</h1>
        
        <jsp:useBean id="prod" class="concessionairemgt.Product" scope="session" />
        
        <form action="buy_prod_processing.jsp" onsubmit="return validateForm();">    
            Choose product:<select name="prod_id" id="prod_id" onchange="updateValues()">
                <%
                    prod.display_products();
                    for (int i = 0; i < prod.prod_id_list.size(); i++) {
                %>
                <option value="<%=prod.prod_id_list.get(i)%>" data-price="<%=prod.prod_pricelist.get(i)%>">
                    <%=prod.prod_name_list.get(i)%></option>
                <%
                    }
                %>
            </select><br>

            Price:<input type="text" id="prod_price" name="prod_price" readonly><br>

            Enter quantity:<input type="text" id="bought_qty" name="bought_qty"><br>
            <br>
            
            <input type="submit" value="Buy Product">            
        </form>
    </body>
</html>

