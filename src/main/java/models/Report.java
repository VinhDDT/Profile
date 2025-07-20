/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;

/**
 *
 * @author KHANH
 */
public class Report {
    private int reportId;
    private int roomId;
    private int reportedByCustomerId;
    private int reportedByUserId;
    private Timestamp reportTime;
    private String description;
    private String status;
    private int handledBy;
    private Timestamp handledTime;
    private String notes;

    public Report() {
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getReportedByCustomerId() {
        return reportedByCustomerId;
    }

    public void setReportedByCustomerId(int reportedByCustomerId) {
        this.reportedByCustomerId = reportedByCustomerId;
    }

    public int getReportedByUserId() {
        return reportedByUserId;
    }

    public void setReportedByUserId(int reportedByUserId) {
        this.reportedByUserId = reportedByUserId;
    }

    public Timestamp getReportTime() {
        return reportTime;
    }

    public void setReportTime(Timestamp reportTime) {
        this.reportTime = reportTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getHandledBy() {
        return handledBy;
    }

    public void setHandledBy(int handledBy) {
        this.handledBy = handledBy;
    }

    public Timestamp getHandledTime() {
        return handledTime;
    }

    public void setHandledTime(Timestamp handledTime) {
        this.handledTime = handledTime;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
    
}
