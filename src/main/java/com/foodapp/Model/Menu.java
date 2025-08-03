package com.foodapp.Model;

public class Menu {
    private int m_id;
    private int r_id;
    private String name;
    private String description;
    private float price;
    private int isAvailable;
    private String imagePath;

    public Menu() {
    }

    public int getM_id() {
        return m_id;
    }

    public Menu(int m_id, int r_id, String name, String description, float price, int isAvailable, String imagePath) {
        this.m_id = m_id;
        this.r_id = r_id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.isAvailable = isAvailable;
        this.imagePath = imagePath;
    }

    public void setM_id(int m_id) {
        this.m_id = m_id;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getAvailable() {
        return isAvailable;
    }

    public void setAvailable(int available) {
        isAvailable = available;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
