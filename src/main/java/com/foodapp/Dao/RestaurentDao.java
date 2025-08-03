package com.foodapp.Dao;


import com.foodapp.Model.Restaurent;

import java.util.ArrayList;


public interface RestaurentDao {

    String insertDetails(Restaurent r);
    String selectRestarant(int r_id);
    ArrayList<Restaurent> selectAll();
    String updateRestarant(int r_id, String imagepath);
    String delete(int r_id);
}
