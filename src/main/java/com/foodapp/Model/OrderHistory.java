package com.foodapp.Model;

import java.sql.Date;


public class OrderHistory {
    private int orderHistory_id;
    private int order_id;
    private int user_id;
    private String name;
    private double totalAmount;
    private Date date;
	private String status;
    private String imagePath;

    public OrderHistory(int order_id,int user_id,String name, double totalAmount,  String status,String imagePath) {
        
    this.order_id = order_id;
    this.user_id = user_id;
    this.name=name;
    this.totalAmount = totalAmount;
    this.status = status;
    this.imagePath=imagePath;
}
    
    public OrderHistory(int orderHistory_id, int order_id,int user_id, String name,double totalAmount,Date date, String status,String imagePath) {
        this.orderHistory_id = orderHistory_id;
        this.order_id = order_id;
        this.user_id = user_id;
        this.name=name;
        this.totalAmount = totalAmount;
        this.date=date;
        this.status = status;
        this.imagePath=imagePath;
    }
    
    public String getName() {
		return name;
	}

	public Date getDate() {
		return date;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	


    public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public int getOrderHistory_id() {
        return orderHistory_id;
    }

    public void setOrderHistory_id(int orderHistory_id) {
        this.orderHistory_id = orderHistory_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
