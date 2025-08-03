package com.foodapp.Imp;

import com.foodapp.connection.Connect;
import com.foodapp.Dao.OrderItemDao;
import com.foodapp.Model.OrderItem;

import java.sql.*;
import java.util.ArrayList;

public class OrderItemImp implements OrderItemDao {

    public static Connection con=Connect.connector();


    public static final String INSERT="INSERT INTO ORDERITEM(ORDER_ID,MENU_ID,QUANTITY,TOTALITEM) VALUES(?,?,?,?)";
    public static final String SELECT="SELECT * FROM ORDERITEM WHERE ORDERITEM_ID= ?";
    public static final String SELECTALL="SELECT * FROM ORDERITEM";
    public static final String UPDATE="UPDATE ORDERITEM SET QUANTITY = ? WHERE ORDERITEM_ID = ?";
    public static final String DELETE="DELETE FROM ORDERITEM WHERE ORDERITEM_ID= ? ";


    @Override
    public int insert(OrderItem oi) {

        try {
          PreparedStatement stmt=con.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
         
          stmt.setInt(1,oi.getOrder_id());
          stmt.setInt(2,oi.getMenu_id());
          stmt.setInt(3,oi.getQuantity());
          stmt.setDouble(4,oi.getTotalItem());
          
          int x=stmt.executeUpdate();
          
          if(x==1) {
          
        	  ResultSet res=stmt.getGeneratedKeys();
        	  
        	 while(res.next()) {
        		 return res.getInt(1);
        	 }

          }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    public String select(int orderitem_id){

        try {
            PreparedStatement stmt = con.prepareStatement(SELECT);
            stmt.setInt(1, orderitem_id);
            ResultSet resultSet=stmt.executeQuery();

            while (resultSet.next()){
                return resultSet.getInt(1)+" "+resultSet.getInt(2)+" "+resultSet.getInt(3)+" "+resultSet.getInt(4)+" "+resultSet.getDouble(5);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "NO DETAILS FOUND";
    }
    public ArrayList selectAll(){
        ArrayList al=new ArrayList();

        try {
          Statement stmt=con.createStatement();
          ResultSet resultSet = stmt.executeQuery(SELECTALL);

          while (resultSet.next()) {
              String ans = resultSet.getInt(1) + " " + resultSet.getInt(2) + " " + resultSet.getInt(3) + " " + resultSet.getInt(4) + " " + resultSet.getDouble(5);
              al.add(ans);
          }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return al;
    }
    public String update(int oderitem_id,int quantity){


        try {
            PreparedStatement stmt = con.prepareStatement(UPDATE);
            stmt.setInt(1,quantity);
            stmt.setInt(2, oderitem_id);
            int x=stmt.executeUpdate();

            if(x==1){
                return "UPDATE IS SUCCESSFUL";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
            return "UPDATE IS FAILED";
    }
    public String delete(int orderitem_id){

        try {
            PreparedStatement stmt = con.prepareStatement(DELETE);
            stmt.setInt(1, orderitem_id);
            int x=stmt.executeUpdate();
            if(x==1){
                return "DELETION IS SUCCESSFUL";
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return "DELETION IS FAILED";
    }
}
