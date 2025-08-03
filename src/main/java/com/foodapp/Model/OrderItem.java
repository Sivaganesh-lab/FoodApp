package com.foodapp.Model;

public class OrderItem {

    private int orderItem_id;
    private int order_id;
    private int menu_id;
    private int quantity;
    private double totalItem;

    public OrderItem(){

    }

    public OrderItem( int order_id, int menu_id, int quantity, double totalItem) {
        
        this.order_id = order_id;
        this.menu_id = menu_id;
        this.quantity = quantity;
        this.totalItem = totalItem;
    }

    public int getOrderItem_id() {
        return orderItem_id;
    }

    public void setOrderItem_id(int orderItem_id) {
        this.orderItem_id = orderItem_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getMenu_id() {
        return menu_id;
    }

    public void setMenu_id(int menu_id) {
        this.menu_id = menu_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalItem() {
        return totalItem;
    }

    public void setTotalItem(double totalItem) {
        this.totalItem = totalItem;
    }
}
