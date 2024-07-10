<%-- 
    Document   : sup_processing
    Created on : 11 17, 23, 1:14:23 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, concessionairemgt.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Supplier Processing</title>
    </head>
    <body>
        <jsp:useBean id = "s" class = "concessionairemgt.Supplier" scope = "session"/>       
        
        <form action = "index.html">
            <%
                String supplier_name = request.getParameter("supplier_name");
                String email = request.getParameter("email");
                long contact_no = Long.valueOf(request.getParameter("contact_no"));
                                
                // Get the "day" parameter values
                String[] dayValues = request.getParameterValues("day");
                ArrayList<String> selected_days = new ArrayList<>();

                // Check if "day" parameter is not null and not empty
                if (dayValues != null) {
                    selected_days.addAll(Arrays.asList(dayValues));
                }
                                
                s.supplier_name = supplier_name;
                s.email = email;
                s.contact_no = contact_no;
                s.avail_Mon = selected_days.contains("Monday");
                s.avail_Tues = selected_days.contains("Tuesday");
                s.avail_Wed = selected_days.contains("Wednesday");
                s.avail_Thurs = selected_days.contains("Thursday");
                s.avail_Fri = selected_days.contains("Friday");
                s.avail_Sat = selected_days.contains("Saturday");
                s.avail_Sun = selected_days.contains("Sunday");

                int status = s.add_supplier();
                
                if(status == 1) {
            %>
            <h1>Registered Supplier Successfully</h1>
            <%  } else {
            %>
            <h1>Registering Supplier Failed Due to Duplicates (Name/Email/Contact No.)</h1>
            <%  }
            %>
            <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
