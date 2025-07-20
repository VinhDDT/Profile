/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
public class CustomerStatus {

    private int customerId;
    private String statusName;

    public CustomerStatus() {
    }

    public CustomerStatus(int customerId, String statusName) {
        this.customerId = customerId;
        this.statusName = statusName;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

}
