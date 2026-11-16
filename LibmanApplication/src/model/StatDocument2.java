package model;

public class StatDocument2 extends Document2 {
    private int borrowCount;

    public StatDocument2() {
        super();
    }

    public StatDocument2(String name, String author, String publisher, String category, int borrowCount) {
        super(name, author, publisher, category);
        this.borrowCount = borrowCount;
    }

    public int getBorrowCount() {
        return borrowCount;
    }

    public void setBorrowCount(int borrowCount) {
        this.borrowCount = borrowCount;
    }
}
