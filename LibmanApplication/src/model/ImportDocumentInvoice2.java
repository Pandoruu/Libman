package model;

import java.io.Serializable;
import java.sql.Date;

public class ImportDocumentInvoice2 implements Serializable {
    private int id;
    private Date importDate;
    private String note;
    private Supplier2 supplier;
    private Librarian2 librarian;
    private ImportDocumentDetail2[] importDetails;

    public ImportDocumentInvoice2() {
        super();
    }

    public ImportDocumentInvoice2(Date importDate, String note, Supplier2 supplier, Librarian2 librarian, ImportDocumentDetail2[] importDetails) {
        super();
        this.importDate = importDate;
        this.note = note;
        this.supplier = supplier;
        this.librarian = librarian;
        this.importDetails = importDetails;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Supplier2 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier2 supplier) {
        this.supplier = supplier;
    }

    public Librarian2 getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian2 librarian) {
        this.librarian = librarian;
    }

    public ImportDocumentDetail2[] getImportDetails() {
        return importDetails;
    }

    public void setImportDetails(ImportDocumentDetail2[] importDetails) {
        this.importDetails = importDetails;
    }
}
