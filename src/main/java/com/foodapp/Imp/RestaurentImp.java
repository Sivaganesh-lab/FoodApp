package com.foodapp.Imp;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashSet;
import java.util.Set;

import com.foodapp.Dao.RestaurentDao;
import com.foodapp.Model.Restaurent;
import com.foodapp.connection.Connect;


import jakarta.servlet.http.HttpSession;

public class RestaurentImp implements RestaurentDao {

    static Connection connect = Connect.connector();
    static final String INSERT = "INSERT INTO RESTAURENT VALUES(?,?,?,?,?,?,?)";
    static final String SELECT = "SELECT * FROM RESTAURENT WHERE R_ID=?";
    static final String SELECTAll = "SELECT * FROM RESTAURENT";
    static final String UPDATE = "UPDATE RESTAURENT SET IMAGEPATH= ? WHERE R_ID = ?";
    static final String DELETE = "DELETE FROM RESTAURENT WHERE R_ID= ? ";

    static ArrayList<Restaurent> al=new ArrayList();

    @Override
    public String insertDetails(Restaurent r) {

        try {
            PreparedStatement stmt = connect.prepareStatement(INSERT);
            stmt.setInt(1, r.getR_id());
            stmt.setString(2, r.getName());
            stmt.setString(3, r.getType());
            stmt.setInt(4, r.getDeliveryTime());
            stmt.setString(5, r.getAddress());
            stmt.setFloat(6, r.getRating());
            stmt.setBoolean(7, r.getActive());
            

            int x = stmt.executeUpdate();
            if (x == 1) {
                return "Insertion successful";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    @Override
    public String selectRestarant(int r_id){

        try{
            PreparedStatement stmt=connect.prepareStatement(SELECT);
            stmt.setInt(1,r_id);
            ResultSet res=stmt.executeQuery();

            while (res.next()){
                return res.getInt(1)+" "+ res.getString(2) + " " +res.getString(3)+" "+ res.getInt(4)+ " " +res.getString(5)+" "+ res.getFloat(6)+" "+ res.getString(7) +" "+res.getString(8);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return "NO RECORDS FOUND";
    }
   
   
    @Override
    public ArrayList<Restaurent> selectAll() {
    	 Set<Integer> uniqueIds = new HashSet<>(); 
        try {
            Statement stmt = connect.createStatement();
            ResultSet res = stmt.executeQuery(SELECTAll);

            while (res.next()) {
                int resturant_id = res.getInt(1);
                String name = res.getString(2);
                String cuisinetype = res.getString(3);
                int deliverytime = res.getInt(4);
                String address = res.getString(5);
                float rating = res.getFloat(6);
                boolean isactive = res.getBoolean(7);

                // Convert Blob to Base64 String
                Blob imageBlob = res.getBlob(8);
                String imagePath = "";
                if (imageBlob != null) {
                    byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                    imagePath = Base64.getEncoder().encodeToString(imageBytes);
                }

                System.out.println(imagePath);

                Restaurent restaurant = new Restaurent(resturant_id, name, cuisinetype, deliverytime, address, rating, isactive, imagePath);
                al.add(restaurant);
                uniqueIds.add(resturant_id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return al;
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
    
    @Override
    public String updateRestarant(int r_id,String imagePath) {

        try{
        PreparedStatement stmt = connect.prepareStatement(UPDATE);
        
        

      
        File imageFile = new File(imagePath);
        FileInputStream inputStream = new FileInputStream(imageFile);
        stmt.setBinaryStream(1, inputStream, (int) imageFile.length());
        stmt.setInt(2, r_id);
        int x = stmt.executeUpdate();
        if (x==1){
           return  "UPDATE IS SUCCESSFUL";
        }
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
        return "Updationn is failed! TRY AGAIN";
    }

    @Override
    public String delete(int r_id){

        try{
           PreparedStatement stmt=connect.prepareStatement(DELETE);
           stmt.setInt(1,r_id);
           int x=stmt.executeUpdate();
           if(x==1){
               return "DELETION IS SUCCESSFULLY COMPLETED";
           }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return "DELETION IS FAILED TO DELETE TRY AGAIN";

    }

}
