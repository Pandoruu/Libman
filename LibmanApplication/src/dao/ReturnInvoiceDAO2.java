package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.PaymentSlip2;
import model.ReturnDetail2;
import model.ReturnInvoice2;

public class ReturnInvoiceDAO2 extends DAO2 {

    public ReturnInvoiceDAO2() {
        super();
    }

    /**
     * Module 2: Lưu hóa đơn trả tài liệu, chi tiết trả, phiếu thanh toán tiền phạt
     * và cập nhật trạng thái chi tiết mượn / bản sao tài liệu trong một giao dịch (Transaction).
     */
    public boolean saveReturnInvoice(ReturnInvoice2 invoice) {
        if (invoice == null || invoice.getReaderCard() == null || invoice.getLibrarian() == null
                || invoice.getReturnDetails() == null || invoice.getReturnDetails().length == 0 || con == null) {
            return false;
        }
        boolean result = false;

        String sqlInsertInvoice = "INSERT INTO tblReturnInvoice2(returnDate, tblReaderCard2id, tblLibrarian2id) "
                                + "VALUES(?, ?, ?)";
        String sqlInsertDetail = "INSERT INTO tblReturnDetail2(damageFine, lateFine, note, tblReturnInvoice2id, tblDocumentCopy2id) "
                               + "VALUES(?, ?, ?, ?, ?)";
        String sqlUpdateBorrowDetail = "UPDATE tblBorrowDetail2 SET status = 'Returned' "
                                     + "WHERE tblDocumentCopy2id = ? AND status = 'Borrowing'";
        String sqlUpdateDocumentCopy = "UPDATE tblDocumentCopy2 SET status = 'Available' WHERE id = ?";
        String sqlUpdateCompletedBorrowRecord = "UPDATE tblBorrowRecord2 br SET br.status = 'Returned' "
                                              + "WHERE br.tblReaderCard2id = ? AND br.status = 'Borrowing' "
                                              + "AND NOT EXISTS ("
                                              + "    SELECT 1 FROM tblBorrowDetail2 bd "
                                              + "    WHERE bd.tblBorrowRecord2id = br.id AND bd.status = 'Borrowing'"
                                              + ")";
        String sqlInsertPaymentSlip = "INSERT INTO tblPaymentSlip2(paymentDate, tblReturnInvoice2id) VALUES(?, ?)";

        try {
            con.setAutoCommit(false);

            // 1. Thêm hóa đơn trả vào tblReturnInvoice2
            PreparedStatement psInvoice = con.prepareStatement(sqlInsertInvoice, Statement.RETURN_GENERATED_KEYS);
            Date returnDateSql = invoice.getReturnDate() != null
                    ? new Date(invoice.getReturnDate().getTime())
                    : new Date(System.currentTimeMillis());
            psInvoice.setDate(1, returnDateSql);
            psInvoice.setInt(2, invoice.getReaderCard().getId());
            psInvoice.setInt(3, invoice.getLibrarian().getId());
            psInvoice.executeUpdate();

            ResultSet rsInvoiceKeys = psInvoice.getGeneratedKeys();
            int invoiceId = 0;
            if (rsInvoiceKeys.next()) {
                invoiceId = rsInvoiceKeys.getInt(1);
                invoice.setId(invoiceId);
            }
            rsInvoiceKeys.close();
            psInvoice.close();

            // 2. Thêm từng dòng chi tiết trả và cập nhật trạng thái mượn & bản sao tài liệu
            PreparedStatement psDetail = con.prepareStatement(sqlInsertDetail, Statement.RETURN_GENERATED_KEYS);
            PreparedStatement psUpdBorrowDetail = con.prepareStatement(sqlUpdateBorrowDetail);
            PreparedStatement psUpdCopy = con.prepareStatement(sqlUpdateDocumentCopy);

            for (ReturnDetail2 detail : invoice.getReturnDetails()) {
                int copyId = detail.getDocumentCopy().getId();

                psDetail.setFloat(1, detail.getDamageFine());
                psDetail.setFloat(2, detail.getLateFine());
                psDetail.setString(3, detail.getNote());
                psDetail.setInt(4, invoiceId);
                psDetail.setInt(5, copyId);
                psDetail.executeUpdate();

                ResultSet rsDetailKeys = psDetail.getGeneratedKeys();
                if (rsDetailKeys.next()) {
                    detail.setId(rsDetailKeys.getInt(1));
                }
                rsDetailKeys.close();

                psUpdBorrowDetail.setInt(1, copyId);
                psUpdBorrowDetail.executeUpdate();

                psUpdCopy.setInt(1, copyId);
                psUpdCopy.executeUpdate();
            }

            psDetail.close();
            psUpdBorrowDetail.close();
            psUpdCopy.close();

            // 3. Cập nhật trạng thái tblBorrowRecord2 nếu tất cả tài liệu trong phiếu đã trả hết
            PreparedStatement psUpdRecord = con.prepareStatement(sqlUpdateCompletedBorrowRecord);
            psUpdRecord.setInt(1, invoice.getReaderCard().getId());
            psUpdRecord.executeUpdate();
            psUpdRecord.close();

            // 4. Lưu phiếu thanh toán (tblPaymentSlip2)
            PaymentSlip2 slip = invoice.getPaymentSlip();
            if (slip != null) {
                PreparedStatement psSlip = con.prepareStatement(sqlInsertPaymentSlip, Statement.RETURN_GENERATED_KEYS);
                Date payDateSql = slip.getPaymentDate() != null
                        ? new Date(slip.getPaymentDate().getTime())
                        : returnDateSql;
                psSlip.setDate(1, payDateSql);
                psSlip.setInt(2, invoiceId);
                psSlip.executeUpdate();

                ResultSet rsSlipKeys = psSlip.getGeneratedKeys();
                if (rsSlipKeys.next()) {
                    slip.setId(rsSlipKeys.getInt(1));
                }
                rsSlipKeys.close();
                psSlip.close();
            }

            con.commit();
            result = true;
        } catch (Exception e) {
            try {
                con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            result = false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }
}
