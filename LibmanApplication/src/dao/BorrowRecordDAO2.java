package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.BorrowDetail2;
import model.BorrowRecord2;
import model.Document2;
import model.DocumentCopy2;

public class BorrowRecordDAO2 extends DAO2 {

    public BorrowRecordDAO2() {
        super();
    }

    /**
     * Module 2: Lấy danh sách các phiếu mượn và chi tiết tài liệu đang mượn chưa trả của thẻ bạn đọc.
     */
    public BorrowRecord2[] getBorrowedDocuments(int cardId) {
        List<BorrowRecord2> recordList = new ArrayList<>();
        if (con == null) {
            return new BorrowRecord2[0];
        }

        String sqlRecords = "SELECT DISTINCT br.id, br.borrowDate, br.returnDue, br.status "
                          + "FROM tblBorrowRecord2 br "
                          + "INNER JOIN tblBorrowDetail2 bd ON bd.tblBorrowRecord2id = br.id "
                          + "WHERE br.tblReaderCard2id = ? AND bd.status = 'Borrowing' "
                          + "ORDER BY br.borrowDate ASC, br.id ASC";

        String sqlDetails = "SELECT bd.id AS detailId, bd.note, bd.status AS detailStatus, "
                          + "dc.id AS copyId, dc.barcode, dc.condition AS copyCondition, dc.status AS copyStatus, "
                          + "d.id AS docId, d.name AS docName, d.author, d.publisher, d.category "
                          + "FROM tblBorrowDetail2 bd "
                          + "INNER JOIN tblDocumentCopy2 dc ON bd.tblDocumentCopy2id = dc.id "
                          + "INNER JOIN tblDocument2 d ON dc.tblDocument2id = d.id "
                          + "WHERE bd.tblBorrowRecord2id = ? AND bd.status = 'Borrowing' "
                          + "ORDER BY bd.id ASC";

        try {
            PreparedStatement psRecords = con.prepareStatement(sqlRecords);
            psRecords.setInt(1, cardId);
            ResultSet rsRecords = psRecords.executeQuery();

            while (rsRecords.next()) {
                BorrowRecord2 record = new BorrowRecord2();
                int recordId = rsRecords.getInt("id");
                record.setId(recordId);
                record.setBorrowDate(rsRecords.getDate("borrowDate"));
                record.setReturnDue(rsRecords.getDate("returnDue"));
                record.setStatus(rsRecords.getString("status"));

                List<BorrowDetail2> detailList = new ArrayList<>();
                PreparedStatement psDetails = con.prepareStatement(sqlDetails);
                psDetails.setInt(1, recordId);
                ResultSet rsDetails = psDetails.executeQuery();

                while (rsDetails.next()) {
                    Document2 doc = new Document2(
                            rsDetails.getInt("docId"),
                            rsDetails.getString("docName"),
                            rsDetails.getString("author"),
                            rsDetails.getString("publisher"),
                            rsDetails.getString("category")
                    );

                    DocumentCopy2 copy = new DocumentCopy2(
                            rsDetails.getInt("copyId"),
                            rsDetails.getString("barcode"),
                            rsDetails.getString("copyCondition"),
                            rsDetails.getString("copyStatus"),
                            doc
                    );

                    BorrowDetail2 detail = new BorrowDetail2(
                            rsDetails.getInt("detailId"),
                            rsDetails.getString("note"),
                            rsDetails.getString("detailStatus"),
                            copy
                    );
                    detailList.add(detail);
                }
                rsDetails.close();
                psDetails.close();

                record.setBorrowDetails(detailList.toArray(new BorrowDetail2[0]));
                recordList.add(record);
            }
            rsRecords.close();
            psRecords.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return recordList.toArray(new BorrowRecord2[0]);
    }
}
