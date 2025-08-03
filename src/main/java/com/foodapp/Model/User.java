package com.foodapp.Model;

public class User{
    private int user_id;
    private String userName;
    private String mobile;
    private String password;
    private String email;
    private String address;
    private String imagePath;

    public User(int user_id,String userName,String mobile, String password, String email, String address,String imagePath) {
    	this.user_id=user_id;
    	this.userName = userName;
        this.mobile=mobile;
        this.password = password;
        this.email = email;
        this.address = address;
        this.imagePath=imagePath;
    }
    public User(String userName,String mobile, String password, String email, String address,String imagePath) {
        this.userName = userName;
        this.mobile=mobile;
        this.password = password;
        this.email = email;
        this.address = address;
        this.imagePath=imagePath;

    }
    public User(int user_id,String userName,String mobile, String password, String email, String address) {
    	this.user_id=user_id;
    	this.userName = userName;
        this.mobile=mobile;
        this.password = password;
        this.email = email;
        this.address = address;
    }
    
    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public void setMobile(String mobile) {
    	this.mobile=mobile;
    }
    
    public String getMobile() {
    	return mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}