package model;

import java.io.Serializable;

public class DocumentCopy2 implements Serializable {
    private int id;
    private String barcode;
    private String condition;
    private String status;
    private Document2 document;

    public DocumentCopy2() {
        super();
    }

    public DocumentCopy2(String barcode, String condition, String status, Document2 document) {
        super();
        this.barcode = barcode;
        this.condition = condition;
        this.status = status;
        this.document = document;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Document2 getDocument() {
        return document;
    }

    public void setDocument(Document2 document) {
        this.document = document;
    }
}
