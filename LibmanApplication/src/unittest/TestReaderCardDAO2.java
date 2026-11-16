package unittest;

import java.sql.Connection;
import java.util.Date;
import dao.DAO2;
import dao.ReaderCardDAO2;
import model.Reader2;
import model.ReaderCard2;

public class TestReaderCardDAO2 {

    private final ReaderCardDAO2 readerCardDAO = new ReaderCardDAO2();

    private void assertTrue(boolean condition) {
        if (!condition) {
            throw new AssertionError("Assertion failed: expected true but was false");
        }
    }

    private void assertFalse(boolean condition) {
        if (condition) {
            throw new AssertionError("Assertion failed: expected false but was true");
        }
    }

    private void assertNotNull(Object obj) {
        if (obj == null) {
            throw new AssertionError("Assertion failed: expected non-null object");
        }
    }

    private void assertNull(Object obj) {
        if (obj != null) {
            throw new AssertionError("Assertion failed: expected null but was " + obj);
        }
    }

    private void assertEquals(Object expected, Object actual) {
        if (expected == null && actual == null) return;
        if (expected == null || !expected.equals(actual)) {
            throw new AssertionError("Assertion failed: expected [" + expected + "] but was [" + actual + "]");
        }
    }

    // Test 1: Tìm thẻ bạn đọc tồn tại theo mã thẻ (CARD001)
    public void testFindReaderCardStandardByCardCode() {
        ReaderCard2 card = readerCardDAO.findReaderCard("CARD001");
        assertNotNull(card);
        assertEquals("CARD001", card.getCardCode());
        assertNotNull(card.getReader());
        assertEquals("SV001", card.getReader().getReaderCode());
    }

    // Test 2: Tìm thẻ bạn đọc tồn tại theo mã sinh viên (SV001)
    public void testFindReaderCardStandardByReaderCode() {
        ReaderCard2 card = readerCardDAO.findReaderCard("SV001");
        assertNotNull(card);
        assertEquals("CARD001", card.getCardCode());
        assertEquals("Nguyễn Văn An", card.getReader().getFullName());
    }

    // Test 3: Tìm thẻ bạn đọc không tồn tại
    public void testFindReaderCardExceptionNotFound() {
        ReaderCard2 card = readerCardDAO.findReaderCard("NON_EXISTENT_999");
        assertNull(card);
    }

    // Test 4: Đăng ký thẻ bạn đọc mới thành công
    public void testRegisterReaderCardStandard() {
        Connection con = DAO2.con;
        String uniqueCode = "TEST_" + (System.currentTimeMillis() % 100000);
        try {
            Reader2 reader = new Reader2();
            reader.setUsername("user_" + uniqueCode);
            reader.setPassword("123456");
            reader.setFullName("Sinh Viên Kiểm Thử");
            reader.setDob(new Date());
            reader.setAddress("Hà Đông, Hà Nội");
            reader.setPhone("0911223344");
            reader.setEmail("test@stu.ptit.edu.vn");
            reader.setReaderCode("SV_" + uniqueCode);

            ReaderCard2 card = new ReaderCard2();
            card.setCardCode("CARD_" + uniqueCode);
            card.setIssueDate(new Date());
            card.setExpiryDate(new Date(System.currentTimeMillis() + 31536000000L));
            card.setStatus("Active");
            card.setReader(reader);

            boolean result = readerCardDAO.registerReaderCard(card);
            assertTrue(result);
            assertTrue(card.getId() > 0);

            // Dọn dữ liệu kiểm thử để không làm bẩn CSDL
            if (con != null) {
                con.prepareStatement("DELETE FROM tblUser2 WHERE id = " + reader.getId()).executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Test 5: Ngoại lệ đăng ký trùng mã thẻ đã tồn tại (CARD001)
    public void testRegisterReaderCardDuplicateCardCode() {
        Reader2 reader = new Reader2();
        reader.setUsername("dup_user");
        reader.setPassword("123456");
        reader.setFullName("Trùng Mã Thẻ");
        reader.setReaderCode("SV_DUP_999");

        ReaderCard2 card = new ReaderCard2();
        card.setCardCode("CARD001"); // Đã tồn tại trong CSDL
        card.setIssueDate(new Date());
        card.setExpiryDate(new Date());
        card.setStatus("Active");
        card.setReader(reader);

        boolean result = readerCardDAO.registerReaderCard(card);
        assertFalse(result);
    }

    public static void main(String[] args) {
        TestReaderCardDAO2 tester = new TestReaderCardDAO2();
        System.out.println("Running TestReaderCardDAO2...");
        tester.testFindReaderCardStandardByCardCode();
        tester.testFindReaderCardStandardByReaderCode();
        tester.testFindReaderCardExceptionNotFound();
        tester.testRegisterReaderCardStandard();
        tester.testRegisterReaderCardDuplicateCardCode();
        System.out.println("All TestReaderCardDAO2 tests completed successfully!");
    }
}
