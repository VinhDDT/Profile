/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author KHANH
 */
public class Amenities {
     private int AmenityId;
     private String Name;
     private String Description;

    public Amenities() {
    }

    public int getAmenityId() {
        return AmenityId;
    }

    public void setAmenityId(int AmenityId) {
        this.AmenityId = AmenityId;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }
     
}
