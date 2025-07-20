/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author KHANH
 */
public class Equipment {
    private int equipmentID;
    private String equipmentName;
    private String description;

    public Equipment(int equipmentID, String equipmentName, String description) {
        this.equipmentID = equipmentID;
        this.equipmentName = equipmentName;
        this.description = description;
    }

    public Equipment() {
    }

    
    
    public int getEquipmentID() {
        return equipmentID;
    }

    public void setEquipmentID(int equipmentID) {
        this.equipmentID = equipmentID;
    }

    public String getEquipmentName() {
        return equipmentName;
    }

    public void setEquipmentName(String equipmentName) {
        this.equipmentName = equipmentName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}