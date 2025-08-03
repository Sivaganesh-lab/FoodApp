<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.foodapp.Model.User,com.foodapp.Model.Menu"%>
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
<title>Menu Card</title>
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

    .menu-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 2rem;
        padding: 3rem 5%;
        max-width: 1400px;
        margin: 0 auto;
    }

    .menu-card {
        background: white;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        display: flex;
        flex-direction: column;
    }

    .menu-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.1);
    }

    .menu-image {
        height: 200px;
        position: relative;
        overflow: hidden;
    }

    .menu-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
    }

    .menu-card:hover .menu-image img {
        transform: scale(1.05);
    }

    .availability-badge {
        position: absolute;
        top: 1rem;
        right: 1rem;
        background: #48c479;
        color: white;
        padding: 0.3rem 1rem;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 500;
    }

    .menu-content {
        padding: 1.5rem;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    .menu-name {
        font-size: 1.3rem;
        font-weight: 600;
        margin: 0 0 1rem;
        color: var(--dark);
    }

    .menu-description {
        color: #666;
        font-size: 0.95rem;
        line-height: 1.5;
        margin-bottom: auto;
    }

    .menu-details {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 1.5rem;
    }

    .menu-price {
        font-size: 1.4rem;
        font-weight: 700;
        color: var(--secondary);
    }

    .add-to-cart-btn {
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        border: none;
        padding: 0.8rem 1.5rem;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.2s, box-shadow 0.2s;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .add-to-cart-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
    }

    .no-items {
        text-align: center;
        grid-column: 1 / -1;
        font-size: 1.2rem;
        color: #666;
        padding: 4rem;
    }

    @media (max-width: 768px) {
        .menu-container {
            grid-template-columns: 1fr;
            padding: 2rem;
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

        <% User user = (User)session.getAttribute("user"); %>
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

    <div class="menu-container">
        <% ArrayList<Menu> menu = (ArrayList<Menu>) request.getSession().getAttribute("menulist"); %>
        <% if (menu != null && !menu.isEmpty()) { %>
            <% for (Menu a : menu) { %>
                <div class="menu-card">
                    <div class="menu-image">
                        <img src="data:image/jpeg;base64,<%= a.getImagePath() %>" alt="<%= a.getName() %>">
                        <div class="availability-badge <%= a.getAvailable() == 1 ? "available" : "" %>">
                            <%= a.getAvailable() == 1 ? "Available" : "Sold Out" %>
                        </div>
                    </div>
                    <div class="menu-content">
                        <h3 class="menu-name"><%= a.getName() %></h3>
                        <p class="menu-description"><%= a.getDescription() %></p>
                        <div class="menu-details">
                            <span class="menu-price">₹<%= a.getPrice() %></span>
                            <form action="CartProcess" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="itemId" value="<%= a.getM_id() %>">
                                <button type="submit" class="add-to-cart-btn" <%= a.getAvailable() != 1 ? "disabled" : "" %>>
                                    <i class="fas fa-cart-plus"></i>
                                    <%= a.getAvailable() == 1 ? "Add to Cart" : "Unavailable" %>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <p class="no-items"><i class="fas fa-utensils-slash"></i> No menu items available</p>
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