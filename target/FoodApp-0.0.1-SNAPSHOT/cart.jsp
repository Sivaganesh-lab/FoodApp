<%@page import="java.util.Map"%>
<%@page import="com.foodapp.Model.*"%>
<%@page import="com.google.protobuf.MapEntry"%>
<%@page import="com.foodapp.servlets.Cart"%>
<%@ page contentType="text/html; charset=UTF-8" %>
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
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Your Cart</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    :root {
        --primary: #ff6b6b;
        --secondary: #4ecdc4;
        --accent: #ffe66d;
        --dark: #2d3436;
        --light: #f9f9f9;
    }

    body {
        font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        margin: 0;
        background: #f8f9fa;
        color: var(--dark);
    }

    header {
        position: sticky;
        top: 0;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 1rem 5%;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
        z-index: 1000;
    }

    .logo {
        font-size: 1.8rem;
        font-weight: 700;
        background: linear-gradient(45deg, var(--primary), var(--secondary));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .nav-links {
        display: flex;
        gap: 2rem;
        align-items: center;
    }

    .nav-links a {
        color: var(--dark);
        text-decoration: none;
        font-weight: 500;
        position: relative;
        padding: 0.5rem 0;
        transition: color 0.3s ease;
    }

    .nav-links a::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 2px;
        background: var(--primary);
        transition: width 0.3s ease;
    }

    .nav-links a:hover::after {
        width: 100%;
    }

    .user-panel {
        display: flex;
        align-items: center;
        gap: 1rem;
        position: relative;
    }

    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid var(--primary);
        cursor: pointer;
        transition: transform 0.3s ease;
    }

    .dropdown-menu {
        position: absolute;
        top: 120%;
        right: 0;
        background: white;
        border-radius: 12px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        padding: 1rem;
        min-width: 200px;
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease;
        z-index: 1000;
    }

    .dropdown-menu.active {
        opacity: 1;
        visibility: visible;
        top: 100%;
    }

    .dropdown-menu a {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        padding: 0.8rem 1rem;
        color: var(--dark);
        text-decoration: none;
        border-radius: 8px;
        transition: all 0.2s ease;
    }

    .container {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 2rem;
    }

    .cart-header {
        text-align: center;
        margin-bottom: 3rem;
    }

    .cart-header h2 {
        font-size: 2.5rem;
        margin: 0;
        background: linear-gradient(45deg, var(--primary), var(--secondary));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .cart-items {
        display: grid;
        gap: 1.5rem;
    }

    .cart-item {
        background: white;
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
        display: grid;
        grid-template-columns: 100px 1fr auto;
        gap: 1.5rem;
        align-items: center;
        transition: transform 0.3s ease;
    }

    .cart-item:hover {
        transform: translateY(-3px);
    }

    .item-image img {
        width: 100%;
        height: 100px;
        object-fit: cover;
        border-radius: 12px;
    }

    .item-details {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .item-name {
        font-size: 1.2rem;
        font-weight: 600;
    }

    .item-price {
        color: var(--secondary);
        font-weight: 500;
    }

    .quantity-controls {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .quantity-btn {
        width: 35px;
        height: 35px;
        border: none;
        border-radius: 50%;
        background: var(--primary);
        color: white;
        font-size: 1.1rem;
        cursor: pointer;
        transition: transform 0.2s ease;
    }

    .quantity-btn:hover {
        transform: scale(1.1);
    }

    .quantity-display {
        min-width: 40px;
        text-align: center;
        font-weight: 500;
    }

    .remove-btn {
        background: none;
        border: none;
        color: #ff4d4d;
        cursor: pointer;
        padding: 0.5rem;
        transition: color 0.2s ease;
    }

    .remove-btn:hover {
        color: #e60000;
    }

    .summary {
        margin-top: 3rem;
        padding: 2rem;
        background: white;
        border-radius: 16px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
    }

    .total-amount {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 1.5rem;
        font-weight: 600;
    }

    .checkout-actions {
        display: flex;
        justify-content: flex-end;
        gap: 1rem;
        margin-top: 2rem;
    }

    .action-btn {
        padding: 1rem 2rem;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.2s ease;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .continue-btn {
        background: linear-gradient(45deg, var(--secondary), var(--primary));
        color: white;
    }

    .checkout-btn {
        background: linear-gradient(45deg, var(--primary), var(--secondary));
        color: white;
    }

    .empty-cart {
        text-align: center;
        padding: 4rem;
        background: white;
        border-radius: 16px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
    }

    .empty-cart h3 {
        font-size: 1.5rem;
        margin-bottom: 1.5rem;
    }

    .browse-btn {
        padding: 1rem 2rem;
        border-radius: 8px;
        background: linear-gradient(45deg, var(--primary), var(--secondary));
        color: white;
        text-decoration: none;
        font-weight: 600;
        transition: transform 0.2s ease;
    }

    @media (max-width: 768px) {
        .cart-item {
            grid-template-columns: 1fr;
            text-align: center;
        }
        
        .quantity-controls {
            justify-content: center;
        }
    }
</style>
</head>
<body>
    <header>
        <div class="logo">FoodieParadise</div>
        <nav class="nav-links">
            <a href="home.jsp"><i class="fas fa-utensils"></i> Restaurants</a>
            <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
        </nav>
        <% User user = (User) session.getAttribute("user"); %>
        <div class="user-panel">
            <img src="data:image/jpeg;base64,<%= user.getImagePath() %>" 
                 class="user-avatar" 
                 alt="User avatar"
                 onclick="toggleDropdown()">
            <div class="dropdown-menu" id="dropdownMenu">
                <a href="GetOrderHistory"><i class="fas fa-history"></i> Order History</a>
                <a href="cart.jsp"><i class="fas fa-cart-plus"></i> Cart</a>
                <a href="profileInfo.jsp"><i class="fas fa-user-cog"></i> Profile</a>
                <a href="LogOut"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
    </header>

    <div class="container">
        <div class="cart-header">
            <h2>Your Food Cart</h2>
        </div>

        <% Cart cart = (Cart) session.getAttribute("cart"); 
           if(cart == null || cart.getItem().isEmpty()) { %>
            <div class="empty-cart">
                <h3>Your cart is feeling lonely 😢</h3>
                <a href="home.jsp" class="browse-btn">
                    <i class="fas fa-utensils"></i> Browse Restaurants
                </a>
            </div>
        <% } else { 
            double totalAmount = 0;
            int restaurantId = 0;
            if(!cart.getItem().isEmpty()) {
                restaurantId = cart.getItem().values().iterator().next().getRestaurantId();
            } %>
            
            <div class="cart-items">
                <% for(Map.Entry<Integer, CartItem> entry : cart.getItem().entrySet()) { 
                    CartItem item = entry.getValue();
                    totalAmount += item.getPrice() * item.getQuantity(); %>
                    
                    <div class="cart-item">
                        <div class="item-image">
                            <img src="data:image/jpeg;base64,<%= item.getImagePath() %>" alt="<%= item.getName() %>">
                        </div>
                        
                        <div class="item-details">
                            <div class="item-name"><%= item.getName() %></div>
                            <div class="item-price">₹<%= item.getPrice() %> each</div>
                        </div>

                        <div class="item-controls">
                            <form class="quantity-controls" action="CartProcess" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="itemId" value="<%= item.getMenuId() %>">
                                <button type="submit" name="quantity" value="<%= item.getQuantity() - 1 %>" 
                                        class="quantity-btn">−</button>
                                <span class="quantity-display"><%= item.getQuantity() %></span>
                                <button type="submit" name="quantity" value="<%= item.getQuantity() + 1 %>" 
                                        class="quantity-btn">+</button>
                            </form>
                            
                            <form action="CartProcess" method="post">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="itemId" value="<%= item.getMenuId() %>">
                                <button type="submit" class="remove-btn">
                                    <i class="fas fa-trash-alt"></i> Remove
                                </button>
                            </form>
                        </div>
                    </div>
                <% } %>
            </div>

            <div class="summary">
                <div class="total-amount">
                    <span>Total Amount:</span>
                    <span>₹<%= String.format("%.2f", totalAmount) %></span>
                </div>
                
                <div class="checkout-actions">
                    <a href="home.jsp" class="action-btn continue-btn">
                        <i class="fas fa-plus"></i> Add More Items
                    </a>
                    <a href="checkout.jsp" class="action-btn checkout-btn">
                        <i class="fas fa-lock"></i> Secure Checkout
                    </a>
                </div>
            </div>
        <% } %>
    </div>

    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById('dropdownMenu');
            dropdown.classList.toggle('active');
        }

        window.onclick = function(event) {
            if (!event.target.matches('.user-avatar')) {
                const dropdowns = document.getElementsByClassName("dropdown-menu");
                for (let i = 0; i < dropdowns.length; i++) {
                    dropdowns[i].classList.remove('active');
                }
            }
        }
    </script>
</body>
</html>