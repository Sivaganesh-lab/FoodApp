<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Failed</title>
  <style>
    /* General Reset */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Arial', sans-serif;
      background: linear-gradient(135deg, #ff6b6b, #f8d7da);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      color: #333;
    }

    .order-failed-container {
      background-color: #ffffff;
      border-radius: 12px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
      text-align: center;
      padding: 40px 30px;
      width: 400px;
      max-width: 90%;
      animation: fadeIn 1s ease-in-out;
    }

    .order-failed-container h1 {
      color: #d9534f;
      font-size: 28px;
      margin-bottom: 15px;
    }

    .order-failed-container p {
      color: #6c757d;
      font-size: 16px;
      margin-bottom: 25px;
    }

    .try-again-link {
      display: inline-block;
      padding: 12px 25px;
      color: #fff;
      background-color: #d9534f;
      text-decoration: none;
      font-size: 16px;
      font-weight: bold;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
      transition: background-color 0.3s, transform 0.2s;
    }

    .try-again-link:hover {
      background-color: #c9302c;
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
  <div class="order-failed-container">
    <h1>Order Failed</h1>
    <p>We’re sorry, but your order could not be processed at this time.</p>
    <!-- Retry link -->
    <a href="cart.jsp" class="try-again-link">Try Again</a>
  </div>
</body>
</html>
