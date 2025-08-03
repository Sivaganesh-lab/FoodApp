<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodApp - Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-cyan: #00d4ff;
            --dark-bg: #0f2027;
            --medium-bg: #203a43;
            --light-text: #e0e0e0;
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
        }

        /* Left Food Design Section */
        .food-design {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                        url('https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
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
            background: linear-gradient(to right, #00d4ff, #0078ff);
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

        /* Right Registration Section */
        
        
          .form-container {
            background: linear-gradient(135deg, var(--medium-bg), var(--dark-bg));
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .create-box {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            backdrop-filter: blur(10px);
            padding: 2rem;
            max-width: 500px;
            width: 100%;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        h2 {
            color: white;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            color: var(--light-text);
            margin-bottom: 0.5rem;
        }

        input {
            padding: 0.85rem;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.15);
            color: white;
        }

        #password, #confirm-password, .submit-btn {
            grid-column: span 2;
        }

        .submit-btn {
            padding: 0.9rem;
            background: linear-gradient(135deg, #00d4ff, #0078ff);
            border: none;
            color: white;
            font-size: 1rem;
            border-radius: 8px;
            cursor: pointer;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
        }

        .signin-link {
            grid-column: span 2;
            text-align: center;
            margin-top: 1rem;
            color: var(--lighter-text);
        }

     
        @media (max-width: 768px) {
            body {
                grid-template-columns: 1fr;
            }
            
            .food-design {
                display: none;
            }
            
            .form-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Left Food Design Section -->
    <div class="food-design">
        <div class="food-overlay">
            <h1>Join FoodApp</h1>
            <p>Become part of our food-loving community and enjoy exclusive benefits</p>
            <div class="food-items">
                <div class="food-item" style="background-image: url('https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
                <div class="food-item" style="background-image: url('https://images.unsplash.com/photo-1481931098730-318b6f776db0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
                <div class="food-item" style="background-image: url('https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
                <div class="food-item" style="background-image: url('https://images.unsplash.com/photo-1467003909585-2f8a72700288?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
            </div>
        </div>
    </div>

    <!-- Right Registration Section -->
    <div class="form-container">
        <div class="create-box">
            <h2>Create an Account</h2>
            <form action="registerInputs" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" pattern="^[a-zA-Z\s]+$" required placeholder="Enter your name">
                </div>
                
                <div class="form-group">
                    <label for="mobile">Mobile</label>
                    <input type="tel" id="mobile" name="mobile" pattern="^[6-9]\d{9}$" required placeholder="Enter 10-digit number">
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" pattern="^[a-zA-Z0-9._%+-]+@gmail\.com$" required placeholder="example@gmail.com">
                </div>
                
                 <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" pattern="^[a-zA-Z]+$" required placeholder="Enter your city">
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required placeholder="Create password">
                </div>
                
                <div class="form-group">
                    <label for="confirm-password">Confirm Password</label>
                    <input type="password" id="confirm-password" name="confirmPassword" required placeholder="Re-enter password">
                </div>
                
               
                
                <button type="submit" class="submit-btn">Register Now</button>
            </form>
            
            <div class="signin-link">
                <p class="footer-text" >Already have an account? <a href="index.jsp">Sign In</a></p>
            </div>
        </div>
    </div>
</body>
</html>