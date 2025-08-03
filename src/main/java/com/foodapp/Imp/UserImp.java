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

import com.foodapp.Dao.UserDao;
import com.foodapp.Model.User;
import com.foodapp.connection.Connect;

public class UserImp implements UserDao {
    public static Connection con= Connect.connector();

    public static final String INSERT="INSERT INTO USER(USERNAME,MOBILE,PASSWORD,EMAIL,ADDRESS,IMAGEPATH) VALUES(?,?,?,?,?,?)";
    public static final String SELECT="SELECT * FROM USER WHERE USER_ID= ?";
    public static final String SELECTWITHEMAIL="SELECT * FROM USER WHERE EMAIL=? AND PASSWORD=?";
    public static final String SELECTALL="SELECT * FROM USER";
    public static final String UPDATE="UPDATE USER SET NAME = ? , MOBILE = ? ,PASSWORD= ? , EMAIL = ?,ADDRESS = ? ,IMAGEPATH = ? WHERE USER_ID = ?";
    public static final String DELETE="DELETE FROM USER WHERE USER_ID= ? ";



    @Override
    public int insert(User u){

        try{
            PreparedStatement stmt=con.prepareStatement(INSERT);
          
            stmt.setString(1,u.getUserName());
            stmt.setString(2,u.getMobile());
            stmt.setString(3,u.getPassword());
            stmt.setString(4,u.getEmail());
            stmt.setString(5,u.getAddress());
            
            FileInputStream fis=new FileInputStream(u.getImagePath());
            
            stmt.setBlob(6, fis);
            
            int res=stmt.executeUpdate();
           return res;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
    
    @Override
    public User select(int user_id){


        try {
            PreparedStatement stmt=con.prepareStatement(SELECT);
            stmt.setInt(1,user_id);
            ResultSet res= stmt.executeQuery();
            
          


            while (res.next()){
            	  
            	int id=res.getInt("user_id");
	    		String name=res.getString("username");
	    		String mobile=res.getString("mobile");
	    		String password1=res.getString("password");
	    		String email1=res.getString("email");
	    		String address=res.getString("address");
	    		
	    		  Blob imageBlob = res.getBlob("imagepath");
	                String imagePath = "";
	                if (imageBlob != null) {
	                    byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
	                    imagePath = Base64.getEncoder().encodeToString(imageBytes);
	                }
	    		
	    		User user=new User(id,name,mobile,password1,email1,address,imagePath);
                return user;
           }
    	    

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }
    
    @Override
    public User selectWithEmailPassword(String email,String password) {

    	try {
	    	PreparedStatement stmt=con.prepareStatement(SELECTWITHEMAIL);
	    	stmt.setString(1, email);
	    	stmt.setString(2, password);
	    	
	    	ResultSet res=stmt.executeQuery();
	    	
	    	while(res.next()) {
	    		
	    		int id=res.getInt("user_id");
	    		String name=res.getString("username");
	    		String mobile=res.getString("mobile");
	    		String password1=res.getString("password");
	    		String email1=res.getString("email");
	    		String address=res.getString("address");
	    		
	    		  Blob imageBlob = res.getBlob("imagepath");
	                String imagePath = "";
	                if (imageBlob != null) {
	                    byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
	                    imagePath = Base64.getEncoder().encodeToString(imageBytes);
	                }
	    		
	    		User user=new User(id,name,mobile,password1,email1,address,imagePath);
                return user;
	    		
	    	}
    	
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    	return null;
    }
  
    @Override
    public ArrayList<User> selectAll(){

        ArrayList<User> al=new ArrayList<User>();

        try {
            Statement stmt=con.createStatement();
            ResultSet res=stmt.executeQuery(SELECTALL);

            while (res.next()){

//                String res=resultSet.getInt(1)+" "+resultSet.getString(2)+" "+resultSet.getString(3)+" "+resultSet.getString(4)+" "+resultSet.getString(5);
                
          		User user=new User(res.getInt("user_id"),res.getString("username"),res.getString("mobile"),res.getString("password"),res.getString("email"),res.getString("address"));
            	al.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return al;
    }


    @Override
    public boolean update(User u) {
        boolean isUpdated = false;

        try {
            String sql = "UPDATE users SET username=?, email=?, mobile=?, password=?, address=?, imagePath=? WHERE id=?";

            try {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, u.getUserName());
                ps.setString(2, u.getEmail());
                ps.setString(3, u.getMobile());
                ps.setString(4, u.getPassword());
                ps.setString(5, u.getAddress());
                ps.setString(6, u.getImagePath());
                ps.setInt(7, u.getUser_id());

                int res = ps.executeUpdate();
                isUpdated = res > 0;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                return isUpdated;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false; // fallback return in case the outer try fails
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
