package model;

public class StatSupplier2 extends Supplier2 {
    private int importCount;
    private float totalImportValue;

    public StatSupplier2() {
        super();
    }

    public StatSupplier2(String name, String address, String phone, String email, int importCount, float totalImportValue) {
        super(name, address, phone, email);
        this.importCount = importCount;
        this.totalImportValue = totalImportValue;
    }

    public int getImportCount() {
        return importCount;
    }

    public void setImportCount(int importCount) {
        this.importCount = importCount;
    }

    public float getTotalImportValue() {
        return totalImportValue;
    }

    public void setTotalImportValue(float totalImportValue) {
        this.totalImportValue = totalImportValue;
    }
}
