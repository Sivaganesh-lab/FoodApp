package EditingOption;

import java.awt.Menu;

import com.foodapp.Imp.MenuDaoImplements;
import com.foodapp.Imp.RestaurentImp;
import com.foodapp.Model.Restaurent;

public class Main {

	public static void main(String[] args) {
		
		int id=20;
		
		String image = "C:\\Users\\Prasad\\Downloads\\1."+id+".jpg";
		MenuDaoImplements r=new MenuDaoImplements();
		
		String res=r.update(id, image);
		System.out.println(res+id);
		
	}
}
