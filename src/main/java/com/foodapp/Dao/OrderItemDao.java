package com.foodapp.Dao;

import com.foodapp.Model.OrderItem;
import java.util.ArrayList;
public interface OrderItemDao {


    int insert(OrderItem oi);
    String select(int orderitem_id);
    ArrayList selectAll();
    String update(int oderitem_id,int quantity);
    String delete(int orderitem_id);

}
