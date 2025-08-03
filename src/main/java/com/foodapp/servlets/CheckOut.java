package com.foodapp.servlets;

import java.io.IOException;
import java.time.LocalDateTime;

import com.foodapp.Dao.OrderHistoryDao;
import com.foodapp.Dao.OrderItemDao;
import com.foodapp.Dao.OrdersDao;
import com.foodapp.Imp.OrderHistoryImp;
import com.foodapp.Imp.OrderItemImp;
import com.foodapp.Imp.OrdersImp;
import com.foodapp.Model.CartItem;
import com.foodapp.Model.OrderHistory;
import com.foodapp.Model.OrderItem;
import com.foodapp.Model.Orders;
import com.foodapp.Model.User;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CheckOut")
public class CheckOut extends HttpServlet {
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		HttpSession session=req.getSession();
		User user=(User)session.getAttribute("user");
		Cart cart=(Cart)session.getAttribute("cart");
		
		int menuId=(int)session.getAttribute("menuId");
		
		
		String house=req.getParameter("house");
		String city=req.getParameter("city");
		String state=req.getParameter("state");
		String country=req.getParameter("country");
		String pincode=req.getParameter("pincode");
		String paymentMode=req.getParameter("paymentMode");
		
		
		if(user!=null && cart!=null && cart.items!=null) {
			System.out.println("helloworld");
			int userId=user.getUser_id();
			int restaurentId=(int)session.getAttribute("restaurentId");
//			LocalDateTime datatime=LocalDateTime.now();
			String address=house+","+city+","+state+","+country+","+pincode;
			String mobile=req.getParameter("mobile");
			double total=0;
			for(CartItem a:cart.items.values()) {
				total+=(a.getQuantity()*a.getPrice());
			}
			total= Double.parseDouble(String.format("%.2f", total));
			String status="Pending";
			
			OrdersDao od=new OrdersImp();
			
			Orders order=new Orders(userId,restaurentId,address,mobile,total,status,paymentMode);
			int orderId=od.insert(order);
			
			req.getSession().setAttribute("orderId", orderId);
			req.getSession().setAttribute("total", total);
			System.out.println(orderId);
			if(orderId!=0) {
				
				OrderItemDao oid=new OrderItemImp();
				OrderHistoryDao ohd=new OrderHistoryImp();
				for(CartItem ci:cart.items.values()) {
					
					OrderItem orderitem=new OrderItem(orderId,menuId,ci.getQuantity(),ci.getQuantity()*ci.getPrice());
					if(oid.insert(orderitem)!=0) {
						
						OrderHistory orderhistory=new OrderHistory(orderId,userId,ci.getName(),total,"Delivered",ci.getImagePath());
						System.out.println(ci.getImagePath());
						if(ohd.insert(orderhistory)!=0) {
							continue;
						}
						else {
							resp.sendRedirect("orderfailed.jsp");
							return;
						}
					}
					else {
						resp.sendRedirect("orderfailed.jsp");
						return;
					}
					
				}
				
//				session.removeAttribute("user");
				session.removeAttribute("cart");
				session.removeAttribute("restaurentId");
				session.removeAttribute("menuId");
			
				resp.sendRedirect("orderconfirmed.jsp");
			}
			
			else {
				resp.sendRedirect("orderfailed.jsp");
			}

	}
		else {
			resp.sendRedirect("cart.jsp");
		}
	}
}
