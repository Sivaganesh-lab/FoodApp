package com.foodapp.Dao;

import com.foodapp.Model.*;

import java.util.ArrayList;

public interface OrdersDao {


    int insert(Orders o);
    Orders select(int order_id);
    ArrayList<Orders> selectAll();
    String update(int order_id,String status);
    String delete(int order_id);
}
