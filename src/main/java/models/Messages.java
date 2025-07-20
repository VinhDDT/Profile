/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.time.LocalDateTime;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class Messages {
    private int MessageId;
    private int CustomerId;
    private int StaffId;
    private String SenderType;
    private String Content;
    private LocalDateTime SentAt;
    private boolean IsRead;
    private String ImageUrl;

    public int getMessageId() {
        return MessageId;
    }

    public void setMessageId(int MessageId) {
        this.MessageId = MessageId;
    }

    public int getCustomerId() {
        return CustomerId;
    }

    public void setCustomerId(int CustomerId) {
        this.CustomerId = CustomerId;
    }

    public int getStaffId() {
        return StaffId;
    }

    public void setStaffId(int StaffId) {
        this.StaffId = StaffId;
    }

    public String getSenderType() {
        return SenderType;
    }

    public void setSenderType(String SenderType) {
        this.SenderType = SenderType;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String Content) {
        this.Content = Content;
    }

    public LocalDateTime getSentAt() {
        return SentAt;
    }

    public void setSentAt(LocalDateTime SentAt) {
        this.SentAt = SentAt;
    }

    public boolean isIsRead() {
        return IsRead;
    }

    public void setIsRead(boolean IsRead) {
        this.IsRead = IsRead;
    }

    public String getImageUrl() {
        return ImageUrl;
    }

    public void setImageUrl(String ImageUrl) {
        this.ImageUrl = ImageUrl;
    }
    
    
}
