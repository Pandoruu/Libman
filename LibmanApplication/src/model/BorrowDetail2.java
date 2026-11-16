package model;

import java.io.Serializable;

public class BorrowDetail2 implements Serializable {
    private int id;
    private String note;
    private String status;
    private DocumentCopy2 documentCopy;

    public BorrowDetail2() {
        super();
    }

    public BorrowDetail2(String note, String status, DocumentCopy2 documentCopy) {
        super();
        this.note = note;
        this.status = status;
        this.documentCopy = documentCopy;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public DocumentCopy2 getDocumentCopy() {
        return documentCopy;
    }

    public void setDocumentCopy(DocumentCopy2 documentCopy) {
        this.documentCopy = documentCopy;
    }
}
