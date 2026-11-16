<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.text.SimpleDateFormat,java.util.Date,model.*,dao.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Tài liệu Đang mượn (gdBorrowDocumentListView2)</title>
    <script type="text/javascript">
        function validateSelection() {
            var checkboxes = document.getElementsByName("chkSelectCopy");
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    return true;
                }
            }
            alert("Vui lòng chọn ít nhất một tài liệu bạn đọc mang trả!");
            return false;
        }
    </script>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <%
        Librarian2 librarian = (Librarian2) session.getAttribute("librarian");
        if (librarian == null) {
            response.sendRedirect("../user/gdLoginView2.jsp?err=timeout");
            return;
        }
        ReaderCard2 readerCard = (ReaderCard2) session.getAttribute("readerCard");
        if (readerCard == null) {
            response.sendRedirect("gdSearchReaderView2.jsp");
            return;
        }

        BorrowRecordDAO2 borrowDAO = new BorrowRecordDAO2();
        BorrowRecord2[] records = borrowDAO.getBorrowedDocuments(readerCard.getId());
        session.setAttribute("borrowedRecords", records);

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        long todayMs = System.currentTimeMillis();
    %>
    <div class="container">
        <h2>Danh sách Tài liệu Đang mượn của Bạn đọc (gdBorrowDocumentListView2)</h2>

        <div class="info-box">
            <strong>Thông tin Thẻ Bạn đọc:</strong><br/>
            - Mã thẻ: <strong><%= readerCard.getCardCode() %></strong>
            | Mã bạn đọc: <strong><%= readerCard.getReader().getReaderCode() %></strong><br/>
            - Họ và tên: <strong><%= readerCard.getReader().getFullName() %></strong>
            | Điện thoại: <strong><%= readerCard.getReader().getPhone() %></strong>
            | Email: <strong><%= readerCard.getReader().getEmail() %></strong>
        </div>

        <form name="frmBorrowList" action="gdInvoiceView2.jsp" method="post" onsubmit="return validateSelection();">
            <table id="tblBorrowedDocs" class="data-table">
                <thead>
                    <tr>
                        <th>Chọn trả (chkSelectCopy)</th>
                        <th>Mã phiếu mượn</th>
                        <th>Mã vạch (Barcode)</th>
                        <th>Tên tài liệu</th>
                        <th>Tác giả</th>
                        <th>Ngày mượn</th>
                        <th>Hạn trả (returnDue)</th>
                        <th>Tình trạng khi mượn</th>
                        <th>Phạt hư hỏng VNĐ (txtDamageFine)</th>
                        <th>Ghi chú trả</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int rowCount = 0;
                        if (records != null) {
                            for (BorrowRecord2 rec : records) {
                                BorrowDetail2[] details = rec.getBorrowDetails();
                                if (details != null) {
                                    for (BorrowDetail2 det : details) {
                                        rowCount++;
                                        DocumentCopy2 copy = det.getDocumentCopy();
                                        Document2 doc = copy.getDocument();
                                        long overdueDays = 0;
                                        if (rec.getReturnDue() != null && todayMs > rec.getReturnDue().getTime()) {
                                            overdueDays = (todayMs - rec.getReturnDue().getTime()) / (1000L * 60 * 60 * 24);
                                        }
                    %>
                    <tr>
                        <td style="text-align: center;">
                            <input type="checkbox" name="chkSelectCopy" value="<%= copy.getId() %>" checked />
                        </td>
                        <td>#<%= rec.getId() %></td>
                        <td><strong><%= copy.getBarcode() %></strong></td>
                        <td><%= doc.getName() %></td>
                        <td><%= doc.getAuthor() %></td>
                        <td><%= rec.getBorrowDate() != null ? sdf.format(rec.getBorrowDate()) : "" %></td>
                        <td>
                            <%= rec.getReturnDue() != null ? sdf.format(rec.getReturnDue()) : "" %>
                            <% if (overdueDays > 0) { %>
                                <br/><span style="color: #dc2626; font-size: 12px; font-weight: 600;">(Quá hạn <%= overdueDays %> ngày)</span>
                            <% } else { %>
                                <br/><span style="color: #16a34a; font-size: 12px;">(Đúng hạn)</span>
                            <% } %>
                        </td>
                        <td><%= copy.getCondition() %></td>
                        <td>
                            <input type="number" step="1000" min="0"
                                   id="txtDamageFine_<%= copy.getId() %>"
                                   name="txtDamageFine_<%= copy.getId() %>"
                                   value="0" style="width: 110px; padding: 5px;" />
                        </td>
                        <td>
                            <input type="text"
                                   name="txtNote_<%= copy.getId() %>"
                                   value="Bình thường" style="width: 130px; padding: 5px;" />
                        </td>
                    </tr>
                    <%
                                    }
                                }
                            }
                        }
                        if (rowCount == 0) {
                    %>
                    <tr>
                        <td colspan="10" style="text-align: center; color: #64748b; padding: 20px;">
                            Bạn đọc này hiện không còn tài liệu nào đang mượn chưa trả.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="btn-row">
                <% if (rowCount > 0) { %>
                    <button type="submit" id="btnConfirm" name="btnConfirm" class="btn">
                        Xác nhận tài liệu trả & Tính tiền phạt (btnConfirm)
                    </button>
                <% } %>
                <button type="button" id="btnBack" name="btnBack" class="btn btn-secondary"
                        onclick="window.location.href='gdSearchReaderView2.jsp'">
                    Quay lại tìm kiếm (btnBack)
                </button>
            </div>
        </form>
    </div>
</body>
</html>
