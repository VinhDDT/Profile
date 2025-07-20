/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.time.LocalDateTime;

/**
 *
 * @author KHANH
 */
public class MaintenanceSchedule {

    private int maintenanceID;
    private int consumableID;
    private int equipmentID;
    private String note;
    private LocalDateTime date;
    private int userID;
    private int statusID;
    private Rooms rooms;
    private Equipment equipment;
    private MaintenanceStatuses maintenanceStatuses;
    private Users users;

    public MaintenanceSchedule() {
    }

    public MaintenanceSchedule(int maintenanceID, int consumableID, int equipmentID, String note, LocalDateTime date, int userID, int statusID, Rooms rooms, Equipment equipment, MaintenanceStatuses maintenanceStatuses, Users users) {
        this.maintenanceID = maintenanceID;
        this.consumableID = consumableID;
        this.equipmentID = equipmentID;
        this.note = note;
        this.date = date;
        this.userID = userID;
        this.statusID = statusID;
        this.rooms = rooms;
        this.equipment = equipment;
        this.maintenanceStatuses = maintenanceStatuses;
        this.users = users;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    public int getMaintenanceID() {
        return maintenanceID;
    }

    public void setMaintenanceID(int maintenanceID) {
        this.maintenanceID = maintenanceID;
    }

    public int getConsumableID() {
        return consumableID;
    }

    public void setConsumableID(int consumableID) {
        this.consumableID = consumableID;
    }

    public int getEquipmentID() {
        return equipmentID;
    }

    public void setEquipmentID(int equipmentID) {
        this.equipmentID = equipmentID;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public Rooms getRooms() {
        return rooms;
    }

    public void setRooms(Rooms rooms) {
        this.rooms = rooms;
    }

    public Equipment getEquipment() {
        return equipment;
    }

    public void setEquipment(Equipment equipment) {
        this.equipment = equipment;
    }

    public MaintenanceStatuses getMaintenanceStatuses() {
        return maintenanceStatuses;
    }

    public void setMaintenanceStatuses(MaintenanceStatuses maintenanceStatuses) {
        this.maintenanceStatuses = maintenanceStatuses;
    }

    private String formattedDate;

    public String getFormattedDate() {
        return formattedDate;
    }

    public void setFormattedDate(String formattedDate) {
        this.formattedDate = formattedDate;
    }

}
