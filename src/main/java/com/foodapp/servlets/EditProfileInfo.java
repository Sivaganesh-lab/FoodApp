package com.foodapp.servlets;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import com.foodapp.Model.User;
import com.foodapp.Dao.UserDao;
import com.foodapp.Imp.UserImp;

@WebServlet("/EditProfileInfo")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB max file size
public class EditProfileInfo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Get updated form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String city = request.getParameter("city");

        // Process profile image
        Part filePart = request.getPart("image");
        String base64Image = null;

        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream fileContent = filePart.getInputStream()) {
                byte[] imageBytes = fileContent.readAllBytes();
                base64Image = Base64.getEncoder().encodeToString(imageBytes);
            }
        }

        // Set updated values to user object
        user.setUserName(name);
        user.setEmail(email);
        user.setMobile(mobile);
        user.setPassword(password);
        user.setAddress(city);
        if (base64Image != null) {
            user.setImagePath(base64Image);
        }

        // Update in DB
        UserDao userDao = new UserImp();
        boolean isUpdated = userDao.update(user);

        if (isUpdated) {
            session.setAttribute("user", user); // update session
            response.sendRedirect("profile.jsp"); // Redirect to profile page
        } else {
            response.getWriter().println("Failed to update profile. Please try again.");
        }
    }
}