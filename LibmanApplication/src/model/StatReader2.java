package model;

import java.sql.Date;

public class StatReader2 extends Reader2 {
    private int borrowCount;
    private float totalFine;

    public StatReader2() {
        super();
    }

    public StatReader2(String username, String password, String fullName, Date dob, String address, String phone, String email, String readerCode, int borrowCount, float totalFine) {
        super(username, password, fullName, dob, address, phone, email, readerCode);
        this.borrowCount = borrowCount;
        this.totalFine = totalFine;
    }

    public int getBorrowCount() {
        return borrowCount;
    }

    public void setBorrowCount(int borrowCount) {
        this.borrowCount = borrowCount;
    }

    public float getTotalFine() {
        return totalFine;
    }

    public void setTotalFine(float totalFine) {
        this.totalFine = totalFine;
    }
}
