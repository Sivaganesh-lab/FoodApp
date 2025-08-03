package com.foodapp.servlets;

import java.io.IOException;
import java.util.ArrayList;

import com.foodapp.Dao.MenuDao;
import com.foodapp.Imp.MenuDaoImplements;
import com.foodapp.Model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/GetMenu")
public class GetMenu extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		int id=Integer.parseInt(req.getParameter("restaurantId"));
		HttpSession session=req.getSession();
		session.setAttribute("restaurentId", id);
		MenuDao md=new MenuDaoImplements();
		
		ArrayList<Menu> menulist=md.selectbyRestaurent(id);
		
		req.getSession().setAttribute("menulist", menulist);
		resp.sendRedirect("menu.jsp");
	
	}

}
