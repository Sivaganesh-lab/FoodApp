package com.foodapp.servlets;

import java.util.HashMap;
import java.util.Map;

import com.foodapp.Model.CartItem;

public class Cart {
	
	Map<Integer, CartItem> items;
	
	public Cart() {
		this.items=new HashMap<Integer, CartItem>();
	}
	
	public void addItem(CartItem item) {
		if(items.containsKey(item.getMenuId())) {
			
			CartItem existingItem = items.get(item.getMenuId());
			existingItem.setQuantity(existingItem.getQuantity()+item.getQuantity());
			
		}
		else {
			items.put(item.getMenuId(), item);
		}
	}
	
	public void removeItem(int itemId) {
		items.remove(itemId);
	}
	
	public void clear() {
		items.clear();
	}
	
	public Map<Integer, CartItem> getItem(){
		return items;
	}

	public void updateItem(int itemId,int quantity) {
		if(items.containsKey(itemId)) {
			if(quantity<=0) {
				items.remove(itemId);
			}
			else {
				items.get(itemId).setQuantity(quantity);
			}
		}
		
	}
}
