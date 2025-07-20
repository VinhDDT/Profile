/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author KHANH
 */
public class RoomEquipment {
    private int roomId;
    private int equipmentID;
    private int quantity;
    private int isWorking;

    public RoomEquipment(int roomId, int equipmentID, int quantity, int isWorking) {
        this.roomId = roomId;
        this.equipmentID = equipmentID;
        this.quantity = quantity;
        this.isWorking = isWorking;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getEquipmentID() {
        return equipmentID;
    }

    public void setEquipmentID(int equipmentID) {
        this.equipmentID = equipmentID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getIsWorking() {
        return isWorking;
    }

    public void setIsWorking(int isWorking) {
        this.isWorking = isWorking;
    }

    
}




