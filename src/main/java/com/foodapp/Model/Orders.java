package com.foodapp.Model;


public class Orders {

    private int order_id;
    private int user_id;
    private int restarant_id;
    private String orderAddress;
    private String mobile;
    private double totalAmount;
    private String status;
    private String paymentMode;

    public Orders() {
    }

    public Orders(int user_id, int restarant_id,String orderAddress,String mobile, double totalAmount, String status,String paymentMode) {
    	
    	this.user_id = user_id;
        this.restarant_id = restarant_id;
        this.orderAddress=orderAddress;
        this.mobile=mobile;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentMode=paymentMode;
    }

    public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getOrderAddress() {
		return orderAddress;
	}

	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
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

    public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getRestarant_id() {
        return restarant_id;
    }

    public void setRestarant_id(int restarant_id) {
        this.restarant_id = restarant_id;
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