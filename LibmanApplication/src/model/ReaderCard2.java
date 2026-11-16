package model;

import java.io.Serializable;
import java.sql.Date;

public class ReaderCard2 implements Serializable {
    private int id;
    private String cardCode;
    private Date issueDate;
    private Date expiryDate;
    private String status;
    private Reader2 reader;

    public ReaderCard2() {
        super();
    }

    public ReaderCard2(String cardCode, Date issueDate, Date expiryDate, String status, Reader2 reader) {
        super();
        this.cardCode = cardCode;
        this.issueDate = issueDate;
        this.expiryDate = expiryDate;
        this.status = status;
        this.reader = reader;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCardCode() {
        return cardCode;
    }

    public void setCardCode(String cardCode) {
        this.cardCode = cardCode;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Reader2 getReader() {
        return reader;
    }

    public void setReader(Reader2 reader) {
        this.reader = reader;
    }
}
