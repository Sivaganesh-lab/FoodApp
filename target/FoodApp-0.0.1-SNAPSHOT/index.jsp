<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodApp - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #3b82f6;
            --light-blue: #60a5fa;
            --dark-bg: #0f172a;
            --medium-bg: #1e293b;
            --light-text: #e2e8f0;
            --lighter-text: #cbd5e1;
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            display: grid;
            grid-template-columns: 1fr 1fr;
            height: 100vh;
            margin: 0;
            overflow: hidden;
            position: relative;
        }

        /* Left Food Design Section */
        .food-design {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                        url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            animation: slideIn 1s ease-out;
        }

        .food-overlay {
            text-align: center;
            color: white;
            z-index: 1;
        }

        .food-overlay h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(to right, #ff6b6b, #ff8787);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .food-overlay p {
            font-size: 1.1rem;
            color: var(--lighter-text);
            max-width: 400px;
        }

        .food-items {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-top: 2rem;
            opacity: 0.9;
        }

        .food-item {
            width: 150px;
            height: 150px;
            border-radius: 12px;
            background-size: cover;
            background-position: center;
            transition: transform 0.3s ease;
        }

        .food-item:hover {
            transform: translateY(-5px);
        }

        /* Right Login Section */
        .login-container {
            background: linear-gradient(135deg, var(--medium-bg), var(--dark-bg));
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        /* Rest of your existing login styles... */
        /* [Keep all previous login container styles here] */

        @keyframes slideIn {
            0% {
                transform: translateX(-50px);
                opacity: 0;
            }
            100% {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @media (max-width: 768px) {
            body {
                grid-template-columns: 1fr;
            }
            
            .food-design {
                display: none;
            }
            
            .login-container {
                padding: 1.5rem;
            }
        }
        
        .login-container {
            background: linear-gradient(135deg, var(--medium-bg), var(--dark-bg));
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .login-box {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            backdrop-filter: blur(10px);
            padding: 2rem;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .logo h2 {
            color: var(--light-blue);
            text-align: center;
            font-size: 2.5rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .input-group label {
            color: var(--light-text);
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        button {
            background-color: var(--primary-blue);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
        }

        button:hover {
            background-color: var(--light-blue);
        }

        .footer-text {
            text-align: center;
            margin-top: 1rem;
            color: var(--lighter-text);
        }

        .footer-text a {
            color: var(--light-blue);
            text-decoration: none;
        }
    </style>
</head>
<body>
    <!-- Left Food Design Section -->
    <div class="food-design">
        <div class="food-overlay">
            <h1>Welcome to FoodApp</h1>
            <p>Discover the finest culinary experiences delivered to your doorstep</p>
            <div class="food-items">
                <div class="food-item" style="background-image: url('https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
                <div class="food-item" style="background-image: url('https://images.unsplash.com/photo-1565958011703-44f9829ba187?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
                <div class="food-item" style="background-image: url('https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
                <div class="food-item" style="background-image: url('https://images.unsplash.com/photo-1506354666786-959d6d497f1a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
            </div>
        </div>
    </div>

    <!-- Right Login Section -->
    <div class="login-container">
        <div class="login-box">
            <div class="logo">
                <h2>FoodApp</h2>
                <p>Delicious meals at your doorstep</p>
            </div>
            
            <form action="ValidInput" method="post">
                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required 
                           pattern="^[a-zA-Z0-9._%+-]+@gmail\.com$" 
                           placeholder="Ent er your email">
                </div>
                
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Enter your password">
                </div>
                
                <button type="submit">Login</button>
            </form>
            
            <p class="footer-text">Don't have an account? <a href="register.jsp">Create one</a></p>
        </div>
    </div>
</body>
</html>


