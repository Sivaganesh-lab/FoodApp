<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.foodapp.Model.User" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    User user = (User) session.getAttribute("user");
    String defaultImagePath = "images/defaultuserimage.png"; // Make sure this file exists in your project
    String imageSrc = (user.getImagePath() != null && !user.getImagePath().isEmpty())
                        ? "data:image/jpeg;base64," + user.getImagePath()
                        : defaultImagePath;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            width: 100%;
            max-width: 400px;
            margin: 5% auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-group input, .form-group button {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .form-group button {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #0056b3;
        }

        .upload-label {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #f0f0f0;
            margin: 0 auto 15px;
            border: 2px dashed #ccc;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .upload-label img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
        }

        input[type="file"] {
            display: none;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Edit Profile</h2>

        <form action="EditProfileInfo" method="POST" enctype="multipart/form-data">
            <!-- Profile Image Upload -->
            <div class="form-group">
                <label class="upload-label" for="image">
                    <img src="<%= imageSrc %>" alt="Profile Image" id="previewImage" />
                </label>
                <input type="file" id="image" name="image" accept="image/*" onchange="previewFile(event)" />
            </div>

            <!-- Name -->
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="<%= (user.getUserName() != null) ? user.getUserName() : "" %>" required />
            </div>

            <!-- Email -->
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email"
                       value="<%= (user.getEmail() != null) ? user.getEmail() : "" %>"
                       pattern="^[a-zA-Z0-9._%+-]+@gmail\.com$"
                       title="Only Gmail addresses are allowed."
                       required />
            </div>

            <!-- Mobile -->
            <div class="form-group">
                <label for="mobile">Mobile</label>
                <input type="tel" id="mobile" name="mobile"
                       pattern="^[6-9]\d{9}$"
                       title="Enter a valid 10-digit Indian mobile number."
                       value="<%= (user.getMobile() != null) ? user.getMobile() : "" %>" required />
            </div>

            <!-- Password -->
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       value="<%= (user.getPassword() != null) ? user.getPassword() : "" %>" required />
            </div>

            <!-- City -->
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" id="city" name="city" value="<%= (user.getAddress() != null) ? user.getAddress() : "" %>" required />
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <button type="submit">Save Changes</button>
            </div>
        </form>
    </div>

    <script>
        function previewFile(event) {
            const previewImage = document.getElementById('previewImage');
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImage.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>
