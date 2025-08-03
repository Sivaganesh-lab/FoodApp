package com.foodapp.servlets;

import java.io.IOException;

import com.foodapp.Dao.MenuDao;
import com.foodapp.Imp.MenuDaoImplements;
import com.foodapp.Model.CartItem;
import com.foodapp.Model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CartProcess")
public class CartProcess extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		HttpSession session=req.getSession();
		Cart cart=(Cart) session.getAttribute("cart");
		
		if(cart==null) {
			cart=new Cart();
			session.setAttribute("cart", cart);
		}
		
		String action=req.getParameter("action");
		int itemId=Integer.parseInt(req.getParameter("itemId"));
		req.getSession().setAttribute("menuId",itemId);
		MenuDao menudao=null;

		
		try {
			menudao=new MenuDaoImplements();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		CartItem cartItem=null;
		try {
			if(action.equals("add")) {
				int quantity=1;
				Menu menuItem=menudao.select(itemId);
				if(menuItem!=null) {
					 cartItem=new CartItem(menuItem.getM_id(),menuItem.getR_id(),menuItem.getName(),menuItem.getPrice(),quantity,menuItem.getImagePath());
				}
				cart.addItem(cartItem);
			}
			else if(action.equals("update")) {
				int quantity=Integer.parseInt(req.getParameter("quantity"));
				cart.updateItem(itemId, quantity);
			}
			else if(action.equals("remove")){
				cart.removeItem(itemId);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect("cart.jsp");
		
	}
}
