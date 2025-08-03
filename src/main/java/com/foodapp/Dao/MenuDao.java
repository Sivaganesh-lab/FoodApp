package com.foodapp.Dao;




import java.util.ArrayList;

import com.foodapp.Model.Menu;

public interface MenuDao {

      String insert(Menu menu);
      Menu select(int m_id);
    
      ArrayList<Menu> selectbyRestaurent(int r_id);
      ArrayList<String> selectAll();
      String update(int Menu_id,String imagePath);
      String delete(int menu_id);
}
