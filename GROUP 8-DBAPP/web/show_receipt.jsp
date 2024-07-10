<%-- 
    Document   : show_receipt
    Created on : 11 20, 23, 6:03:25 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Receipt</title>
    </head>
    <body>
        <jsp:useBean id = "r" class = "concessionairemgt.Receipt" scope = "session"/>
        <%
        r.get_last_rec();

        if(r.last_type.equals("P")){
            %>
            <h1>Product Purchase Receipt</h1>
            
            <input type="text" id = "name" name = "name" value ="Product Name" disabled>
            <input type="text" id = "unitprice" name = "unitprice" value ="Unit Price" disabled>
            <input type="text" id = "qty" name = "qty" value ="Quantity" disabled>
            <input type="text" id = "totalprice" name = "totalprice" value ="Amount" disabled>
            <br>
            
            <%
            r.get_prodrec_deets(r.last_id);

        }
        if(r.last_type.equals("I")){
            %>
            <h1>Ingredient Purchase Receipt</h1>
            
            <input type="text" id = "name" name = "name" value ="Ingredient Name" disabled>
            <input type="text" id = "unitprice" name = "unitprice" value ="Unit Price" disabled>
            <input type="text" id = "qty" name = "qty" value ="Quantity" disabled>
            <input type="text" id = "totalprice" name = "totalprice" value ="Amount" disabled>
            <br>
            
            <%
            r.get_ingrec_deets(r.last_id);
        }    

            double sum = 0;
            for (int i = 0; i < r.item_name_list.size(); i++) {
                
            %>
                <input type="text" id = "name" name = "name" value ="<%=r.item_name_list.get(i)%>" readonly>
                <input type="text" id = "unitprice" name = "unitprice" value ="<%=r.item_pricelist.get(i)%>" readonly>
                <input type="text" id = "qty" name = "qty" value ="<%=r.item_qty_list.get(i)%>" readonly>
                <input type="text" id = "totalprice" name = "totalprice" value ="<%=r.receipt_pricelist.get(i)%>" readonly>
                <br>
            <%
                sum += r.receipt_pricelist.get(i);
            }
            %>
            <br>
            Receipt Total: <input type="text" id = "sum" name = "sum" value ="<%=sum%>" readonly><br>
            <br>
            <form action = "index.html">
            <input type="submit" value="Back to Main Menu">
            </form>
    </body>
</html>
