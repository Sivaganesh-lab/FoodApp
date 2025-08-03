package com.foodapp.Dao;

import com.foodapp.Model.OrderHistory;
import java.util.ArrayList;

public interface OrderHistoryDao {

    int insert(OrderHistory oh);
    ArrayList<OrderHistory> select(int id);
    ArrayList<OrderHistory> selectAll();
    String update(int orderHistory_id,String status);
    String delete(int orderHistory_id);
}
