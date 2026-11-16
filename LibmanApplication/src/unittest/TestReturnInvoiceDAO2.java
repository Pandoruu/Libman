package unittest;

import java.util.Date;
import dao.ReturnInvoiceDAO2;
import model.Document2;
import model.DocumentCopy2;
import model.Librarian2;
import model.PaymentSlip2;
import model.ReaderCard2;
import model.ReturnDetail2;
import model.ReturnInvoice2;

public class TestReturnInvoiceDAO2 {

    private final ReturnInvoiceDAO2 returnInvoiceDAO = new ReturnInvoiceDAO2();

    private void assertFalse(boolean condition) {
        if (condition) {
            throw new AssertionError("Assertion failed: expected false but was true");
        }
    }

    private void assertEquals(float expected, float actual) {
        if (Math.abs(expected - actual) > 0.01f) {
            throw new AssertionError("Assertion failed: expected " + expected + " but was " + actual);
        }
    }

    // Test 1: Kiểm tra tính tổng tiền phạt (calculateTotalFine) trên đối tượng ReturnInvoice2
    public void testCalculateTotalFineStandard() {
        Document2 doc = new Document2(1, "Giáo trình CNPM", "TS. Nguyễn Mạnh Hùng", "PTIT", "Giáo trình");
        DocumentCopy2 copy1 = new DocumentCopy2(1, "BC-CNPM-001", "Mới 100%", "Borrowed", doc);
        DocumentCopy2 copy2 = new DocumentCopy2(2, "BC-CNPM-002", "Tốt 95%", "Borrowed", doc);

        ReturnDetail2 d1 = new ReturnDetail2(0, 10000.0f, 50000.0f, "Quá hạn 10 ngày, rách bìa nhẹ", copy1);
        ReturnDetail2 d2 = new ReturnDetail2(0, 0.0f, 50000.0f, "Quá hạn 10 ngày", copy2);

        ReturnInvoice2 invoice = new ReturnInvoice2();
        invoice.setReturnDate(new Date());
        invoice.setReturnDetails(new ReturnDetail2[]{d1, d2});

        float total = invoice.calculateTotalFine();
        assertEquals(110000.0f, total);
    }

    // Test 2: Ngoại lệ lưu hóa đơn trả rỗng (không có danh sách chi tiết tài liệu trả)
    public void testSaveReturnInvoiceEmptyDetails() {
        ReturnInvoice2 invoice = new ReturnInvoice2();
        invoice.setReturnDate(new Date());
        invoice.setLibrarian(new Librarian2());
        invoice.setReaderCard(new ReaderCard2());
        invoice.setPaymentSlip(new PaymentSlip2(0, new Date()));
        invoice.setReturnDetails(new ReturnDetail2[0]);

        boolean saved = returnInvoiceDAO.saveReturnInvoice(invoice);
        assertFalse(saved);
    }

    public static void main(String[] args) {
        TestReturnInvoiceDAO2 tester = new TestReturnInvoiceDAO2();
        System.out.println("Running TestReturnInvoiceDAO2...");
        tester.testCalculateTotalFineStandard();
        tester.testSaveReturnInvoiceEmptyDetails();
        System.out.println("All TestReturnInvoiceDAO2 tests completed successfully!");
    }
}
