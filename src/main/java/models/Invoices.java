/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class Invoices {
    private int invoiceId;
    private int bookingId;
   private long invoiceDate;
   private long roomPriceTotal;
   private long discount;
   private long totalAmount;
   private long status;
   private long paidAmount;

    public Invoices(int invoiceId, int bookingId, long invoiceDate, long roomPriceTotal, long discount, long totalAmount, long status, long paidAmount) {
        this.invoiceId = invoiceId;
        this.bookingId = bookingId;
        this.invoiceDate = invoiceDate;
        this.roomPriceTotal = roomPriceTotal;
        this.discount = discount;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paidAmount = paidAmount;
    }

    public Invoices() {
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public long getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(long invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public long getRoomPriceTotal() {
        return roomPriceTotal;
    }

    public void setRoomPriceTotal(long roomPriceTotal) {
        this.roomPriceTotal = roomPriceTotal;
    }

    public long getDiscount() {
        return discount;
    }

    public void setDiscount(long discount) {
        this.discount = discount;
    }

    public long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public long getStatus() {
        return status;
    }

    public void setStatus(long status) {
        this.status = status;
    }

    public long getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(long paidAmount) {
        this.paidAmount = paidAmount;
    }
    
    
}
