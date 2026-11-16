package model;

import java.io.Serializable;
import java.sql.Date;

public class ReturnInvoice2 implements Serializable {
    private int id;
    private Date returnDate;
    private float fineAmount;
    private ReaderCard2 readerCard;
    private Librarian2 librarian;
    private ReturnDetail2[] returnDetails;
    private PaymentSlip2 paymentSlip;

    public ReturnInvoice2() {
        super();
    }

    public ReturnInvoice2(ReturnDetail2[] returnDetails) {
        super();
        this.returnDetails = returnDetails;
        calculateTotalFine();
    }

    public ReturnInvoice2(Date returnDate, ReaderCard2 readerCard, Librarian2 librarian, ReturnDetail2[] returnDetails, PaymentSlip2 paymentSlip) {
        super();
        this.returnDate = returnDate;
        this.readerCard = readerCard;
        this.librarian = librarian;
        this.returnDetails = returnDetails;
        this.paymentSlip = paymentSlip;
        calculateTotalFine();
    }

    public float calculateTotalFine() {
        float total = 0f;
        if (this.returnDetails != null) {
            for (ReturnDetail2 detail : this.returnDetails) {
                if (detail != null) {
                    total += detail.getDamageFine() + detail.getLateFine();
                }
            }
        }
        this.fineAmount = total;
        return this.fineAmount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public float getFineAmount() {
        return fineAmount;
    }

    public void setFineAmount(float fineAmount) {
        this.fineAmount = fineAmount;
    }

    public ReaderCard2 getReaderCard() {
        return readerCard;
    }

    public void setReaderCard(ReaderCard2 readerCard) {
        this.readerCard = readerCard;
    }

    public Librarian2 getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian2 librarian) {
        this.librarian = librarian;
    }

    public ReturnDetail2[] getReturnDetails() {
        return returnDetails;
    }

    public void setReturnDetails(ReturnDetail2[] returnDetails) {
        this.returnDetails = returnDetails;
        calculateTotalFine();
    }

    public PaymentSlip2 getPaymentSlip() {
        return paymentSlip;
    }

    public void setPaymentSlip(PaymentSlip2 paymentSlip) {
        this.paymentSlip = paymentSlip;
    }
}
