package com.foodapp.Imp;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Stack;

import com.foodapp.Dao.MenuDao;
import com.foodapp.Model.Menu;
import com.foodapp.connection.Connect;

public class MenuDaoImplements implements MenuDao
{
    static Connection con;
    static {
       con= Connect.connector();
    }
    static final String INSERT="INSERT INTO MENU VALUES(?,?,?,?,?,?,?)";
    static final String SELECT = "SELECT * FROM Menu WHERE m_id = ?";
    static final String SELECTWITHRESTAURANT = "SELECT * FROM Menu WHERE r_id = ?";
    static final String SELECTAll="SELECT * FROM MENU";
    static final String UPDATE = "UPDATE MENU SET  IMAGEPATH= ? WHERE m_id = ?";
    static final String DELETE="DELETE FROM MENU WHERE M_ID= ? ";

 
 
    @Override
    public String insert(Menu menu){

   try {
       PreparedStatement stmt=con.prepareStatement(INSERT);
       stmt.setInt(1,menu.getM_id());
       stmt.setInt(2,menu.getR_id());
       stmt.setString(3,menu.getName());
       stmt.setString(4,menu.getDescription());
       stmt.setFloat(5,menu.getPrice());
       stmt.setInt(6,menu.getAvailable());
       stmt.setString(7,menu.getImagePath());

       int x=stmt.executeUpdate();
       if(x==1) {
           return "insertion is successful";
       }
   } catch (Exception e) {
       e.printStackTrace();
   }
   return "unsuccessful! try again";
    }
    
    
    


    @Override
    public Menu select(int m_id){

        try {
            PreparedStatement stmt=con.prepareStatement(SELECT);
            stmt.setInt(1,m_id);
            ResultSet res =stmt.executeQuery();

            while (res.next()){
            	
                int menuId=res.getInt(1);
                int restarentId=res.getInt(2);
                String menuName=res.getString(3);
                String description=res.getString(4);
                float price=res.getFloat(5);
                int isAvailable=res.getInt(6);
//                String image=res.getString(7);
                Blob imageBlob = res.getBlob(7);
                String imagePath = "";
                if (imageBlob != null) {
                    byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                    imagePath = Base64.getEncoder().encodeToString(imageBytes);
                }
                
                Menu menu=new Menu(menuId,restarentId,menuName,description,price,isAvailable,imagePath);
                return menu;
            }
        }
        catch (Exception e){
        e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public ArrayList<Menu> selectbyRestaurent(int RESTAURENT_ID) {
    	ArrayList<Menu> menulist=new ArrayList<Menu>();
    	try {
    		PreparedStatement stmt=con.prepareStatement(SELECTWITHRESTAURANT);
    		stmt.setInt(1, RESTAURENT_ID);
    		ResultSet res=stmt.executeQuery();
    		
    		while(res.next()) {
    			int menu_id=res.getInt(1);
    			int restaurant_id=res.getInt(2);
    			String name=res.getString(3);
    			String description=res.getString(4);
    			float price=res.getFloat(5);
    			int isAvailable=res.getInt(6);
    			
    			Blob imageBlob = res.getBlob(7);
                String imagePath = "";
                if (imageBlob != null) {
                    byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                    imagePath = Base64.getEncoder().encodeToString(imageBytes);
                }
    			
    			
    			Menu m=new Menu(menu_id,restaurant_id,name,description,price,isAvailable,imagePath);
    			menulist.add(m);
    		}
    
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    	return menulist;
    }

    @Override
    public ArrayList<String> selectAll(){
        ArrayList<String> al=new ArrayList<String>();
       try{
           Statement stmt=con.createStatement();
           ResultSet res=stmt.executeQuery(SELECTAll);

           while (res.next()){
               al.add(res.getInt(1)+" "+res.getInt(2)+" "+res.getString(3)+" "+res.getString(4)+" "+res.getInt(5)+" "+res.getString(6)+" "+res.getString(7));
           }
       }
       catch(Exception e){
           e.printStackTrace();
       }

       return al;
    }

    @Override
    public String update(int m_id,String imagePath){

	    try {
	    	
	    	PreparedStatement stmt=con.prepareStatement(UPDATE);
	        File imageFile = new File(imagePath);
	        FileInputStream inputStream = new FileInputStream(imageFile);
	        stmt.setBinaryStream(1, inputStream, (int) imageFile.length());
	        stmt.setInt(2, m_id);
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

    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
//    	
//    	
//     
//        stmt.setInt(1,isAvailable);
//       stmt.setInt(2,Menu_id);
//       int x=stmt.executeUpdate();
//       if(x==1){
//           return "UPDATE IS SUCCESSFUL";
//       }
//    }
//    catch (Exception e){
//        e.printStackTrace();
//    }
//    return "UPDATE IS FAILED! TRY AGAIN";
//    
//    
//    

    

//    }

    @Override
    public String delete(int menu_id){
      try {

          PreparedStatement stmt=con.prepareStatement(DELETE);
          stmt.setInt(1,menu_id);
          int x=stmt.executeUpdate();
          if(x==1){
              return "DELECTION IS SUCCESSFUL";
          }
      } catch (Exception e) {
          e.printStackTrace();
      }
        return "DELETION IS FAILED!TRY AGAIN";
    }
}
