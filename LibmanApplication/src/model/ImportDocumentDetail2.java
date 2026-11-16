package model;

import java.io.Serializable;

public class ImportDocumentDetail2 implements Serializable {
    private int id;
    private int quantity;
    private float price;
    private Document2 document;

    public ImportDocumentDetail2() {
        super();
    }

    public ImportDocumentDetail2(int quantity, float price, Document2 document) {
        super();
        this.quantity = quantity;
        this.price = price;
        this.document = document;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Document2 getDocument() {
        return document;
    }

    public void setDocument(Document2 document) {
        this.document = document;
    }
}
