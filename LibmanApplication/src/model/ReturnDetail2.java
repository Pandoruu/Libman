package model;

import java.io.Serializable;

public class ReturnDetail2 implements Serializable {
    private int id;
    private float damageFine;
    private float lateFine;
    private String note;
    private DocumentCopy2 documentCopy;

    public ReturnDetail2() {
        super();
    }

    public ReturnDetail2(float damageFine, float lateFine, String note, DocumentCopy2 documentCopy) {
        super();
        this.damageFine = damageFine;
        this.lateFine = lateFine;
        this.note = note;
        this.documentCopy = documentCopy;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getDamageFine() {
        return damageFine;
    }

    public void setDamageFine(float damageFine) {
        this.damageFine = damageFine;
    }

    public float getLateFine() {
        return lateFine;
    }

    public void setLateFine(float lateFine) {
        this.lateFine = lateFine;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public DocumentCopy2 getDocumentCopy() {
        return documentCopy;
    }

    public void setDocumentCopy(DocumentCopy2 documentCopy) {
        this.documentCopy = documentCopy;
    }
}
