/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class Floors {

    private int floorId;
    private int buildingId;
    private int floorNumber;

    public Floors() {
    }

    public Floors(int floorId, int buildingId, int floorNumber) {
        this.floorId = floorId;
        this.buildingId = buildingId;
        this.floorNumber = floorNumber;
    }

    public int getFloorId() {
        return floorId;
    }

    public void setFloorId(int floorId) {
        this.floorId = floorId;
    }

    public int getBuildingId() {
        return buildingId;
    }

    public void setBuildingId(int buildingId) {
        this.buildingId = buildingId;
    }

    public int getFloorNumber() {
        return floorNumber;
    }

    public void setFloorNumber(int floorNumber) {
        this.floorNumber = floorNumber;
    }
    

}
