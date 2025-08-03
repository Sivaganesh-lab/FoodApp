<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.Model.User"%>
<%-- Cache control and session check remains same --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Info</title>
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
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            margin: 0;
            min-height: 100vh;
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

        .profile-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .profile-header {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }

        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--primary);
            box-shadow: 0 8px 24px rgba(255, 107, 107, 0.2);
            margin-bottom: 1.5rem;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            padding: 1rem;
        }

        .profile-item {
            display: flex;
            align-items: center;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }

        .profile-item:hover {
            transform: translateY(-3px);
        }

        .profile-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1.5rem;
            color: white;
        }

        .profile-content {
            flex-grow: 1;
        }

        .profile-label {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.5rem;
        }

        .profile-value {
            font-size: 1.1rem;
            font-weight: 500;
            color: var(--dark);
            word-break: break-word;
        }

        .edit-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
            text-decoration: none;
        }

        .edit-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        .password-field {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
        }

        @media (max-width: 768px) {
            .profile-container {
                margin: 1rem;
                padding: 1.5rem;
            }
            
            .profile-grid {
                grid-template-columns: 1fr;
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
            <img src="data:image/jpeg;base64,<%= user.getImagePath()!=null ? user.getImagePath() :  "C:\\Users\\Prasad\\Downloads\\defaultuserimage.png"    %>" 
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

    <div class="profile-container">
        <div class="profile-header">
            <img src="data:image/jpeg;base64,<%=user.getImagePath() %>" 
                 class="profile-avatar" 
                 alt="Profile Picture">
            <button class="edit-button" onclick="location.href='editprofileInfo.jsp'">
                <i class="fas fa-edit"></i> Edit Profile
            </button>
        </div>

        <div class="profile-grid">
            <div class="profile-item">
                <div class="profile-icon">
                    <i class="fas fa-user"></i>
                </div>
                <div class="profile-content">
                    <div class="profile-label">Username</div>
                    <div class="profile-value"><%=user.getUserName() %></div>
                </div>
            </div>

            <div class="profile-item">
                <div class="profile-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="profile-content">
                    <div class="profile-label">Email</div>
                    <div class="profile-value"><%=user.getEmail() %></div>
                </div>
            </div>

            <div class="profile-item">
                <div class="profile-icon">
                    <i class="fas fa-phone"></i>
                </div>
                <div class="profile-content">
                    <div class="profile-label">Mobile</div>
                    <div class="profile-value"><%=user.getMobile() %></div>
                </div>
            </div>

            <div class="profile-item">
                <div class="profile-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div class="profile-content">
                    <div class="profile-label">Address</div>
                    <div class="profile-value"><%= user.getAddress() %></div>
                </div>
            </div>

            <div class="profile-item password-field">
                <div class="profile-icon">
                    <i class="fas fa-lock"></i>
                </div>
                <div class="profile-content">
                    <div class="profile-label">Password</div>
                    <div class="profile-value" id="password">••••••••</div>
                    <i class="fas fa-eye toggle-password" onclick="togglePassword()"></i>
                </div>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const eyeIcon = document.querySelector('.toggle-password');
            const realPassword = '<%= user.getPassword() %>';
            
            if (passwordField.textContent === '••••••••') {
                passwordField.textContent = realPassword;
                eyeIcon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                passwordField.textContent = '••••••••';
                eyeIcon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }

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