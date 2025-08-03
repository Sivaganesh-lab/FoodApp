<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.foodapp.Model.*"%>
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
  <title>Order Confirmed</title>
  <style>
    /* General Reset */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Arial', sans-serif;
      background: linear-gradient(135deg, #28a745, #d4edda);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      color: #333;
    }

    .order-confirmed-container {
      background-color: #ffffff;
      border-radius: 12px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
      text-align: center;
      padding: 40px 30px;
      width: 400px;
      max-width: 90%;
      animation: fadeIn 1s ease-in-out;
    }

    .order-confirmed-container h1 {
      color: #28a745;
      font-size: 28px;
      margin-bottom: 15px;
    }

    .order-confirmed-container p {
      color: #6c757d;
      font-size: 16px;
      margin-bottom: 25px;
    }

    .order-details {
      font-size: 14px;
      color: #495057;
      background-color: #f8f9fa;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 25px;
    }

    .action-link {
      display: inline-block;
      padding: 12px 25px;
      color: #fff;
      background-color: #28a745;
      text-decoration: none;
      font-size: 16px;
      font-weight: bold;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
      transition: background-color 0.3s, transform 0.2s;
    }

    .action-link:hover {
      background-color: #218838;
      transform: scale(1.05);
    }

    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(-20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
  </style>
</head>
<body>
  <div class="order-confirmed-container">
    <h1>Order Confirmed</h1>
    <p>Thank you for your purchase! Your order has been successfully placed.</p>

    <div class="order-details">
    
      <p><strong>Order ID:</strong> <%=(int)request.getSession().getAttribute("orderId") %></p>
      <p><strong>Estimated Delivery:</strong> 3-5 Business Days</p>
      <p><strong>Total Amount:</strong> <%=(double)request.getSession().getAttribute("total") %></p>
    </div>
	<%request.getSession().removeAttribute("orderId"); %>
	<%request.getSession().removeAttribute("total"); %>
    <!-- Links for actions -->
    <a href="home.jsp" class="action-link">Go to Homepage</a>
    <br><br>
  </div>
</body>
</html>
