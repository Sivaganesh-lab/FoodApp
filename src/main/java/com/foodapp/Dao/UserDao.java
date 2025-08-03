package com.foodapp.Dao;


import java.util.ArrayList;

import com.foodapp.Model.User;

public interface UserDao {
    int insert(User u);
    User select(int user_id);
    User selectWithEmailPassword(String email,String password);
    ArrayList selectAll();
	boolean update(User u);
    String delete(int user_id);


}
