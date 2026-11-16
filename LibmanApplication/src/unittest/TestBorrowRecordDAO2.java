package unittest;

import dao.BorrowRecordDAO2;
import model.BorrowRecord2;

public class TestBorrowRecordDAO2 {

    private final BorrowRecordDAO2 borrowRecordDAO = new BorrowRecordDAO2();

    private void assertTrue(boolean condition) {
        if (!condition) {
            throw new AssertionError("Assertion failed: expected true but was false");
        }
    }

    private void assertNotNull(Object obj) {
        if (obj == null) {
            throw new AssertionError("Assertion failed: expected non-null object");
        }
    }

    private void assertEquals(int expected, int actual) {
        if (expected != actual) {
            throw new AssertionError("Assertion failed: expected " + expected + " but was " + actual);
        }
    }

    // Test 1: Lấy danh sách tài liệu đang mượn của thẻ bạn đọc có mượn sách (cardId = 1)
    public void testGetBorrowedDocumentsStandard() {
        BorrowRecord2[] records = borrowRecordDAO.getBorrowedDocuments(1);
        assertNotNull(records);
        assertTrue(records.length > 0);
        assertNotNull(records[0].getBorrowDetails());
        assertTrue(records[0].getBorrowDetails().length > 0);
    }

    // Test 2: Lấy danh sách tài liệu đang mượn của thẻ bạn đọc không tồn tại (cardId = 9999)
    public void testGetBorrowedDocumentsEmpty() {
        BorrowRecord2[] records = borrowRecordDAO.getBorrowedDocuments(9999);
        assertNotNull(records);
        assertEquals(0, records.length);
    }

    public static void main(String[] args) {
        TestBorrowRecordDAO2 tester = new TestBorrowRecordDAO2();
        System.out.println("Running TestBorrowRecordDAO2...");
        tester.testGetBorrowedDocumentsStandard();
        tester.testGetBorrowedDocumentsEmpty();
        System.out.println("All TestBorrowRecordDAO2 tests completed successfully!");
    }
}
