package com.foodapp.Model;

import java.io.FileInputStream;

public class Restaurent {

    private int  r_id;
    private String name;
    private String type;
    private int deliveryTime;
    private String address;
    private float rating;
    private boolean isActive;
    private String imagePath;

    public Restaurent() {
    }

    public Restaurent(int r_id, String name, String type, int deliveryTime, String address,float rating, boolean isActive,String imagePath)
    {
        this.r_id = r_id;
        this.name = name;
        this.type = type;
        this.deliveryTime = deliveryTime;
        this.address = address;
        this.rating = rating;
        this.isActive = isActive;
        this.imagePath =  imagePath;
    }

    public int getR_id() {
        return r_id;
    }

    public void setR_id(int r_id) {
        this.r_id = r_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(int deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public boolean getActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
