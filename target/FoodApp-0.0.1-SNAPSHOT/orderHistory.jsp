<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,com.foodapp.Model.*"%>
   <%@ page import="java.sql.*"%>
   <%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // Check if user session exists
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        header {
            background-color: #4CAF50;
            color: white;
            padding: 1rem;
            text-align: center;
        }

        .container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 1rem;
        }

        h2 {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .card {
            display: flex;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 1.5rem;
            overflow: hidden;
        }

        .card img {
            width: 150px;
            height: auto;
            object-fit: cover;
        }

        .card-content {
            padding: 1rem;
            flex: 1;
        }

        .card-content h3 {
            margin: 0;
            margin-bottom: 0.5rem;
            font-size: 1.2rem;
        }

        .card-content p {
            margin: 0.5rem 0;
            color: #555;
        }

        .status {
            font-weight: bold;
        }

        .status.completed {
            color: green;
        }

        .status.pending {
            color: orange;
        }

        .status.canceled {
            color: red;
        }

        footer {
            text-align: center;
            margin-top: 2rem;
            color: #555;
        }
    </style>
</head>
<body>
    <header>
        <h1>Order History</h1>
    </header>

    <div class="container">
        <h2>Your Orders</h2>

		<% ArrayList<OrderHistory>  al =(ArrayList)session.getAttribute("orderhistory"); 
		System.out.println("hello orderh2 is not null"+al);
		if(al!=null){
      	for(OrderHistory o:al){ %>
      
        <div class="card">
            <img src="data:image/jpeg;base64,<%= o.getImagePath() %>" alt="not available">
            <div class="card-content">
                <h3>  <%= o.getName() %> </h3>
                <p>Order ID:<%= o.getOrder_id() %></p>
              	<p>Date: <%= o.getDate() %></p>
                <p class="status completed">Status: <%=o.getStatus() %></p>
            </div>
        </div>
        <%
        session.removeAttribute("orderhistory");
        }
		}
		else{
			%>
			ORDERS HISTORY IS EMPTY....
			<%
		}
      	
      	%>
    </div>

    <footer>
        <p>&copy; 2025 Foodie Paradise. All rights reserved.</p>
    </footer>
</body>
</html>
