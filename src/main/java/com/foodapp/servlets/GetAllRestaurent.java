package com.foodapp.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;

import com.foodapp.Dao.RestaurentDao;
import com.foodapp.Imp.RestaurentImp;
import com.foodapp.Model.Restaurent;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/GetAllRestaurent")
public class GetAllRestaurent extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RestaurentDao rd=new RestaurentImp();
		
//		ArrayList<Restaurent> al=rd.selectAll();
		
		
		HttpSession session = req.getSession();
		if (session.getAttribute("restaurent") == null) {
		    ArrayList<Restaurent> al = rd.selectAll();
		    session.setAttribute("restaurent", al);
		}

				
//		HttpSession session=req.getSession();
//	
//		session.setAttribute("list", al);
		
		req.getRequestDispatcher("home.jsp").forward(req, resp);
	}
}
