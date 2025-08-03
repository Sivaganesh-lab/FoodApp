<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%-- Session and cache control remains same --%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Payment Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6a11cb;
            --secondary: #2575fc;
            --accent: #4caf50;
            --text: #f0f4f8;
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: var(--text);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
            width: 440px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transform: translateY(0);
            animation: slideUp 0.4s ease-out;
        }

        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        h2 {
            text-align: center;
            margin-bottom: 1.8rem;
            font-weight: 600;
            font-size: 2rem;
            background: linear-gradient(to right, #fff, #e0e0e0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        form {
            display: grid;
            gap: 1.2rem;
        }

        .input-group {
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
            color: #e0e0e0;
            font-weight: 500;
        }

        input, select {
            width: 100%;
            padding: 0.9rem 1.2rem;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.05);
            color: var(--text);
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        input::placeholder, select::placeholder {
            color: #c7d2fe;
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--accent);
            background: rgba(76, 175, 80, 0.05);
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.2);
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23e0e0e0'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            background-size: 1.2rem;
        }

        button {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--accent), #45a049);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-top: 1rem;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }

        .security-note {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: #c7d2fe;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        @media (max-width: 480px) {
            .container {
                width: 90%;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Payment Gateway</h2>
        <form action="CheckOut" method="post">
            <!-- Address Details -->
            <div class="input-group">
                <label for="house">Street Address</label>
                <input type="text" id="house" name="house" required 
                       placeholder="House/Street number">
            </div>

            <div class="input-group">
                <label for="city">City</label>
                <input type="text" id="city" name="city" required 
                       placeholder="Enter your city">
            </div>

            <div class="input-group">
                <label for="state">State</label>
                <input type="text" id="state" name="state" required 
                       placeholder="Enter your state">
            </div>

            <div class="input-group">
                <label for="country">Country</label>
                <input type="text" id="country" name="country" required 
                       placeholder="Your nationality">
            </div>

            <div class="input-group">
                <label for="pincode">Postal Code</label>
                <input type="text" id="pincode" name="pincode" required 
                       placeholder="Pincode/ZIP code">
            </div>

            <div class="input-group">
                <label for="mobile">Contact Number</label>
                <input type="text" id="mobile" name="mobile" required 
                       placeholder="Mobile number" pattern="[0-9]{10}">
            </div>

            <!-- Payment Selection -->
            <div class="input-group">
                <label for="paymentMode">Payment Method</label>
                <select id="paymentMode" name="paymentMode" required>
                    <option value="" disabled selected>Select payment option</option>
                    <option value="Credit Card">💳 Credit Card</option>
                    <option value="Debit Card">🏦 Debit Card</option>
                    <option value="UPI">📱 UPI</option>
                    <option value="Net Banking">🌐 Net Banking</option>
                    <option value="Cash on Delivery">📦 Cash on Delivery</option>
                </select>
            </div>

            <button type="submit">
                🔒 Confirm Payment
            </button>
        </form>
        
        <div class="security-note">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="#4CAF50">
                <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm0 10.99h7c-.53 4.12-3.28 7.79-7 8.94V12H5V6.3l7-3.11v8.8z"/>
                <path d="M0 0h24v24H0z" fill="none"/>
            </svg>
            256-bit SSL Secure Connection
        </div>
    </div>
</body>
</html>