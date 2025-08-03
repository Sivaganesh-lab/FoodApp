package com.foodapp.servlets;
import com.foodapp.Dao.UserDao;
import com.foodapp.Imp.UserImp;
import com.foodapp.Model.User;
import com.google.protobuf.compiler.PluginProtos.CodeGeneratorResponse.File;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProcessRegistration")
public class ProcessRegistration extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Retrieve form data
        String username = encrypt(request.getParameter("username"));
        String mobile = encrypt(request.getParameter("mobile"));
        String email = encrypt(request.getParameter("email"));
        String password = encrypt(request.getParameter("password"));
        String confirmPassword = encrypt(request.getParameter("confirmPassword"));
        String city = encrypt(request.getParameter("city"));

        String imagePath = "C:\\Users\\Prasad\\Downloads\\defaultuserimage.png";
      

        
        // Validate and process data
        if (password.equals(confirmPassword)) {
        	
        	UserDao udao=new UserImp();
        	User user=udao.selectWithEmailPassword(email, password);
        	
        	if(user==null) {
        		User u=new User(username,mobile,password,email,city,imagePath);
            	UserDao ud=new UserImp();
            	int res=ud.insert(u);
            	
            	if(res==1) {
           
        			response.sendRedirect("index.jsp");
            	
            	}
            	else {
            	response.sendRedirect("register.jsp");
            	}
        	}
        	
        	else {
    			response.sendRedirect("index.jsp");
	        }
	       
        }
        else {
        	response.sendRedirect("register.jsp");
        }
    }
    
    String decrypt(String s) {

		 String t="";
		 
		 for(int i=0;i<s.length();i++) {
			 t=t+(char)(s.charAt(i)-2);
		 }
		 
		 return t;
	}

	String encrypt(String s) {
		
		 String t="";
		 
		 for(int i=0;i<s.length();i++) {
			 t=t+(char)(s.charAt(i)+2);
		 }
		 
		 return t;
	}
}