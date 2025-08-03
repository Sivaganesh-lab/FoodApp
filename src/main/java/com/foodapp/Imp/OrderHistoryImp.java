package com.foodapp.Imp;

import com.foodapp.connection.Connect;
import com.foodapp.Dao.OrderHistoryDao;
import com.foodapp.Model.OrderHistory;

import java.io.File;
import java.io.FileInputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;

import javax.sql.rowset.serial.SerialBlob;

 public class OrderHistoryImp implements OrderHistoryDao {

     public static Connection con=Connect.connector();


     public static final String INSERT="INSERT INTO ORDERHISTORY(ORDER_ID,USER_ID,NAME,TOTALAMOUNT,STATUS,IMAGEPATH) VALUES(?,?,?,?,?,?)";
     public static final String SELECT="SELECT * FROM ORDERHISTORY WHERE USER_ID= ?";
     public static final String SELECTALL="SELECT * FROM ORDERHISTORY";
     public static final String UPDATE="UPDATE ORDERHISTORY SET STATUS = ? WHERE ORDERHISTORY_ID = ?";
     public static final String DELETE="DELETE FROM ORDERHISTORY WHERE ORDERHISTORY_ID= ? ";

     
     @Override
    public int insert(OrderHistory oh) {

         try {

            PreparedStatement stmt=con.prepareStatement(INSERT);
            
             stmt.setInt(1,oh.getOrder_id());
             stmt.setInt(2,oh.getUser_id());
             stmt.setString(3, oh.getName());
             stmt.setDouble(4,oh.getTotalAmount());
             stmt.setString(5,oh.getStatus());
             
             byte[] ar=oh.getImagePath().getBytes();
             Blob b=new SerialBlob(ar);
             
//             stmt.setBytes(5, ar);
             
//             File imageFile = new File(oh.getImagePath());
// 	        FileInputStream inputStream = new FileInputStream(imageFile);
// 	        stmt.setBinaryStream(6, inputStream, (int) imageFile.length());
 	        
             stmt.setBlob(6, b);
//             stmt.setString(6, oh.getImagePath());
             
             return stmt.executeUpdate();
            
         } catch (Exception e) {
             e.printStackTrace();
         }

         return  0;

     }
     @Override
    public ArrayList<OrderHistory> select(int id){
    	 
    	 ArrayList<OrderHistory> al=new ArrayList<OrderHistory>();
         try {
             PreparedStatement stmt=con.prepareStatement(SELECT);
             stmt.setInt(1,id);
             ResultSet resultSet=stmt.executeQuery();
             
             while (resultSet.next()){
            	 
                 int orderHistory_id=resultSet.getInt(1);
                 int order_id=resultSet.getInt(2);
                 int user_id=resultSet.getInt(3);
                 String name=resultSet.getString(4);
                 double price=resultSet.getFloat(5);
                  Date date=resultSet.getDate(6);
                  String status=resultSet.getString(7);

//                 String imagePath=resultSet.getString(8);
                 
                 Blob imageBlob = resultSet.getBlob(8);
                 String imagePath = "";
                 if (imageBlob != null) {
                     byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                     imagePath = Base64.getEncoder().encodeToString(imageBytes);
                 }
//                 
                 if(imagePath.equals(null)) {
                	 imagePath="\"C:\\Users\\Prasad\\Downloads\\defaultuserimage.png\"";
                 }
                 System.out.println(price);
                 
                 OrderHistory o=new OrderHistory(orderHistory_id,order_id, user_id,name, price,date, status, imagePath);
                 al.add(o);
             }
         }
         catch (Exception e){
             e.printStackTrace();
         }

         return al;
     }

     @Override
    public ArrayList<OrderHistory> selectAll(){
         ArrayList<OrderHistory> al=new ArrayList();
         try {
             Statement stmt = con.createStatement();
             ResultSet resultSet = stmt.executeQuery(SELECTALL);
            while (resultSet.next()){
            	int orderHistory_id=resultSet.getInt(1);
                int order_id=resultSet.getInt(2);
                int user_id=resultSet.getInt(3);
                String name=resultSet.getString(4);
                double price=resultSet.getFloat(5);
                String status=resultSet.getString(6);
                Date date=resultSet.getDate(7);
//                String imagePath=resultSet.getString(8);
                Blob imageBlob = resultSet.getBlob(7);
                String imagePath = "";
                if (imageBlob != null) {
                    byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                    imagePath = Base64.getEncoder().encodeToString(imageBytes);
                }
                
                
                OrderHistory o=new OrderHistory(orderHistory_id,order_id, user_id,name,price,date, status, imagePath);
                al.add(o);
            }
         }
         catch (Exception e){
             e.printStackTrace();
         }
         return al;
     }
     @Override
    public String update(int orderHistory_id,String status){
        try {
            PreparedStatement stmt=con.prepareStatement(UPDATE);
            stmt.setString(1,status);
            stmt.setInt(2,orderHistory_id);
            int x=stmt.executeUpdate();
            if(x==1){
                return "UPDATE IS SUCCESSFUL";
            }

        }
        catch (Exception e){
            e.printStackTrace();
        }
         return "UPDATE IS FAILED! TRY AGAIN";
     }
    @Override
     public String delete(int orderHistory_id){


         try {
             PreparedStatement stmt=con.prepareStatement(DELETE);
             stmt.setInt(1,orderHistory_id);
             int x=stmt.executeUpdate();

             if(x==1){
                 return "DELETION IS SUCCESSFUL";
             }
         }
         catch (Exception e){
             e.printStackTrace();
         }
         return "DELETION IS FAILED! TRY AGAIN";
    }
}
