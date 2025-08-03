package com.foodapp.Imp;

import com.foodapp.connection.Connect;
import com.foodapp.Dao.OrdersDao;
import com.foodapp.Model.Orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class OrdersImp implements OrdersDao {

    public static Connection con= Connect.connector();

    public static final String INSERT="INSERT INTO ORDERS(USER_ID,R_ID,ORDERADDRESS,MOBILE,TOTALAMOUNT,STATUS,PAYMENTMODE) VALUES(?,?,?,?,?,?,?)";
    public static final String SELECT="SELECT * FROM ORDERS WHERE ORDER_ID= ?";
    public static final String SELECTALL="SELECT * FROM ORDERS";
    public static final String UPDATE="UPDATE ORDERS SET STATUS=? WHERE ORDER_ID = ?";
    public static final String DELETE="DELETE FROM ORDERS WHERE ORDER_ID= ? ";


    @Override
    public int insert(Orders o) {
    	
           try{
               PreparedStatement stmt=con.prepareStatement(INSERT,Statement.RETURN_GENERATED_KEYS);
            
               stmt.setInt(1,o.getUser_id());
               stmt.setInt(2,o.getRestarant_id());
               stmt.setString(3,o.getOrderAddress());
               stmt.setString(4,o.getMobile());
               stmt.setDouble(5,o.getTotalAmount());
               stmt.setString(6,o.getStatus());
               stmt.setString(7, o.getPaymentMode());
            
               if(stmt.executeUpdate()!=0) {
               ResultSet res=stmt.getGeneratedKeys();
               if(res.next()) {
            	   return res.getInt(1);
               }
               }

           }
           catch (Exception e){
               e.printStackTrace();
           }
           return 0;
        }
    
    @Override
    public Orders select(int order_id){

        try {
           PreparedStatement stmt=con.prepareStatement(SELECT);
           stmt.setInt(1,order_id);
            ResultSet res= stmt.executeQuery();

            while (res.next()){
            	
                return new Orders(res.getInt(2),res.getInt(3),res.getString(4),res.getString(5),res.getDouble(6),res.getString(6),res.getString(7));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public ArrayList<Orders> selectAll(){

        ArrayList<Orders> al=new ArrayList<Orders>();

        try {
        Statement stmt=con.createStatement();
        ResultSet res=stmt.executeQuery(SELECTALL);

        while (res.next()){

            Orders orders=new Orders(res.getInt(2),res.getInt(3),res.getString(4),res.getString(5),res.getDouble(6),res.getString(6),res.getString(7));

            al.add(orders);
        }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return al;
    }

    @Override
    public String update(int user_id,String status){

        try {
           PreparedStatement stmt=con.prepareStatement(UPDATE);
           stmt.setString(1,status);
           stmt.setInt(2,user_id);
           int x=stmt.executeUpdate();
           if(x==1){
               return "UPDATE SUCCESSFUL";
           }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "UPDATE FAILED";
    }

    @Override
    public String delete(int user_id){

        try {
        PreparedStatement stmt=con.prepareStatement(DELETE);
        stmt.setInt(1,user_id);
        int x=stmt.executeUpdate();
        if(x==1){
            return "DELETE SUCCESSFUL";
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
        return "DELETE FAILED";
    }
}
