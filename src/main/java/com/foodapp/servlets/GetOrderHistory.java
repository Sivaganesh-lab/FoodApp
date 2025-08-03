package com.foodapp.servlets;

import java.io.IOException;
import java.util.ArrayList;

import com.foodapp.Dao.OrderHistoryDao;
import com.foodapp.Imp.OrderHistoryImp;
import com.foodapp.Model.OrderHistory;
import com.foodapp.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/GetOrderHistory")
public class GetOrderHistory extends HttpServlet {


	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
		
		User user=(User)req.getSession().getAttribute("user");
		
		int userId=user.getUser_id();
		System.out.println("user_id "+userId);
		OrderHistoryDao orderHistoryDao =new OrderHistoryImp();
		
		if(req.getSession().getAttribute("orderhistory")==null) {
		ArrayList<OrderHistory> al=	orderHistoryDao.select(userId);
		System.out.println("hello orderh1 is not null"+al);
		req.getSession().setAttribute("orderhistory", al);
		
		}
		resp.sendRedirect("orderHistory.jsp");
		
		//OrderHistory orderHistory=new OrderHistory();
	}
	
}
