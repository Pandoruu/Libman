package model;

import java.io.Serializable;
import java.sql.Date;

public class BorrowRecord2 implements Serializable {
    private int id;
    private Date borrowDate;
    private Date returnDue;
    private String status;
    private ReaderCard2 readerCard;
    private Librarian2 librarian;
    private BorrowDetail2[] borrowDetails;

    public BorrowRecord2() {
        super();
    }

    public BorrowRecord2(Date borrowDate, Date returnDue, String status, ReaderCard2 readerCard, Librarian2 librarian, BorrowDetail2[] borrowDetails) {
        super();
        this.borrowDate = borrowDate;
        this.returnDue = returnDue;
        this.status = status;
        this.readerCard = readerCard;
        this.librarian = librarian;
        this.borrowDetails = borrowDetails;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getReturnDue() {
        return returnDue;
    }

    public void setReturnDue(Date returnDue) {
        this.returnDue = returnDue;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public BorrowDetail2[] getBorrowDetails() {
        return borrowDetails;
    }

    public void setBorrowDetails(BorrowDetail2[] borrowDetails) {
        this.borrowDetails = borrowDetails;
    }
}
