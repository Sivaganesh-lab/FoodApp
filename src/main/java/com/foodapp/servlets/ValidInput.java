package com.foodapp.servlets;

import java.io.IOException;
import com.foodapp.Dao.UserDao;
import com.foodapp.Imp.UserImp;
import com.foodapp.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/ValidInput")
@WebServlet("/CheckValidInput")

public class ValidInput extends HttpServlet{

	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String email1=encrypt(req.getParameter("email"));
		String password1=encrypt(req.getParameter("password"));
		
		UserDao ud=new UserImp();
		
		User user=ud.selectWithEmailPassword(email1, password1);
		
		
		if(user==null) {
			
			resp.sendRedirect("index.jsp");
		}
		else {
			int id=user.getUser_id();
			user.setUserName(decrypt(user.getUserName()));
			user.setMobile(decrypt(user.getMobile()));
			user.setPassword(decrypt(user.getPassword()));;
			user.setEmail(decrypt(user.getEmail()));;
			user.setAddress(decrypt(user.getAddress()));;
			user.setImagePath(user.getImagePath());
			
			
			HttpSession session=req.getSession();
			session.setAttribute("user",user);
//			req.setAttribute("user", decrypt(a));
			resp.sendRedirect("getallrestaurant");
//			req.getRequestDispatcher("").include(req, resp);;
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
