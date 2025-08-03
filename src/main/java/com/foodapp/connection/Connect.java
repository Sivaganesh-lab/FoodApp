package com.foodapp.connection;

import java.sql.DriverManager;
import java.sql.Connection;

public class Connect {

    public static Connection connection;
    public static Connection connector(){

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
             connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/FOODAPP","root","root");
        }catch (Exception e){
            e.printStackTrace();
        }
        return connection;
    }
}
