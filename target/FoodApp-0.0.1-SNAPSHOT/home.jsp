<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.foodapp.Model.*,java.io.FileInputStream"%>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Foodie Paradise</title>
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
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
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

    .user-avatar:hover {
        transform: scale(1.1);
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

    .dropdown-menu a:hover {
        background: #f8f9fa;
        transform: translateX(5px);
    }

    .container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 2rem;
        padding: 3rem 5%;
    }

    
    
    .restaurant-card {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    text-decoration: none;
    color: inherit;

    .restaurant-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.1);
    }

    .card-image {
        height: 200px;
        position: relative;
        overflow: hidden;
    }

    .card-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
    }

    .restaurant-card:hover .card-image img {
        transform: scale(1.05);
    }

    .card-badge {
        position: absolute;
        top: 1rem;
        left: 1rem;
        background: #48c479;
        color: white;
        padding: 0.3rem 0.8rem;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 500;
    }

    .card-content {
        padding: 1.5rem;
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1rem;
    }

    .card-title {
        font-size: 1.3rem;
        font-weight: 600;
        margin: 0;
    }

    .rating {
        display: flex;
        align-items: center;
        gap: 0.3rem;
        background: rgba(255, 193, 7, 0.1);
        padding: 0.3rem 0.8rem;
        border-radius: 20px;
        color: #ffc107;
    }
    
    .rating-green {
    background-color: #48c479;
    color: white;
    padding: 4px 8px;
    border-radius: 5px;
    font-weight: bold;
}

.rating-yellow {
    background-color: #facc15;
    color: black;
    padding: 4px 8px;
    border-radius: 5px;
    font-weight: bold;
}

.rating-red {
    background-color: #ef4444;
    color: white;
    padding: 4px 8px;
    border-radius: 5px;
    font-weight: bold;
}

    .card-details {
        display: flex;
        flex-direction: column;
        gap: 0.8rem;
    }

    .detail-item {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: #666;
        font-size: 0.95rem;
    }

    .detail-item i {
        width: 20px;
        color: var(--primary);
    }

    @media (max-width: 768px) {
        .container {
            grid-template-columns: 1fr;
            padding: 2rem;
        }

        header {
            padding: 1rem;
        }

        .nav-links {
            gap: 1rem;
        }

        .logo {
            font-size: 1.5rem;
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

    <div class="container">
        <% 
            ArrayList<Restaurent> al = (ArrayList)(request.getSession().getAttribute("restaurent"));
            for (Restaurent a : al) { 
        %>
            <a href="getmenu?restaurantId=<%= a.getR_id() %>" class="restaurant-card">
                <div class="card-image">
                    <img src="data:image/jpeg;base64,<%= a.getImagePath() %>" alt="<%= a.getName() %>">
                    <div class="card-badge">
                        <%= a.getActive() ? "OPEN NOW" : "CLOSED" %>
                    </div>
                </div>
                <div class="card-content">
                    <div class="card-header">
                        <h3 class="card-title"><%= a.getName() %></h3>
	                  <%
						    String ratingClass = "";
						    double rating = a.getRating();
						    if (rating >= 4) {
						        ratingClass = "rating-green";
						    } else if (rating >= 3) {
						        ratingClass = "rating-yellow";
						    } else {
						        ratingClass = "rating-red";
						    }
						%>
						<div class="rating <%= ratingClass %>">
						    <i class="fas fa-star"></i>
						    <%= a.getRating() %>
						</div>

                    </div>
                    <div class="card-details">
                        <div class="detail-item">
                            <i class="fas fa-utensils"></i>
                            <%= a.getType() %>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-clock"></i>
                            <%= a.getDeliveryTime() %> mins delivery
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <%= a.getAddress() %>
                        </div>
                    </div>
                </div>
            </a>
        <% } %>
    </div>

    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById('dropdownMenu');
            dropdown.classList.toggle('active');
        }

        // Close dropdown when clicking outside
        window.onclick = function(event) {
            if (!event.target.matches('.user-avatar')) {
                const dropdowns = document.getElementsByClassName("dropdown-menu");
                for (let i = 0; i < dropdowns.length; i++) {
                    const openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('active')) {
                        openDropdown.classList.remove('active');
                    }
                }
            }
        }
    </script>
</body>
</html>