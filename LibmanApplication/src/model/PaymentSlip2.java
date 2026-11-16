package model;

import java.io.Serializable;
import java.sql.Date;

public class PaymentSlip2 implements Serializable {
    private int id;
    private Date paymentDate;
    private float totalAmount;

    public PaymentSlip2() {
        super();
    }

    public PaymentSlip2(Date paymentDate, float totalAmount) {
        super();
        this.paymentDate = paymentDate;
        this.totalAmount = totalAmount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }
}
