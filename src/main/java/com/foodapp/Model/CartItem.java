package com.foodapp.Model;

public class CartItem {

	private int menuId;
	private int restaurantId;
	private String name;
	private float price;
	private int quantity;
	private String imagePath;
	
	public CartItem() {
	
	}
	
	public CartItem(int menuId, int restaurantId, String name, float price, int quantity,String imagePath) {
		
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.name = name;
		this.price = price;
		this.quantity = quantity;
		this.imagePath=imagePath;
	}
	
	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public int getMenuId() {
		return menuId;
	}
	
	public int getRestaurantId() {
		return restaurantId;
	}
	
	public String getName() {
		return name;
	}
	
	public float getPrice() {
		return price;
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	
	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setPrice(float price) {
		this.price = price;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
	
	
}
