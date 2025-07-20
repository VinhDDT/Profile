/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class Employees {

    private int employeeID;
    private int userID;
    private String fullName;
    private String gender;
    private Date dateOfBirth;
    private String phone;
    private String email;
    private String address;
    private String identityNumber;
    private Date JjoinDate;

    public Employees() {
    }

    public Employees(int employeeID, int userID, String fullName, String gender, Date dateOfBirth, String phone, String email, String address, String identityNumber, Date JjoinDate) {
        this.employeeID = employeeID;
        this.userID = userID;
        this.fullName = fullName;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.identityNumber = identityNumber;
        this.JjoinDate = JjoinDate;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public String getIdentityNumber() {
        return identityNumber;
    }

    public void setIdentityNumber(String identityNumber) {
        this.identityNumber = identityNumber;
    }

    public Date getJjoinDate() {
        return JjoinDate;
    }

    public void setJjoinDate(Date JjoinDate) {
        this.JjoinDate = JjoinDate;
    }

}
