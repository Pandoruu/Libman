<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.text.DecimalFormat,java.text.SimpleDateFormat,java.util.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn Trả Tài liệu (gdInvoiceView2)</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <%
        request.setCharacterEncoding("UTF-8");
        Librarian2 librarian = (Librarian2) session.getAttribute("librarian");
        if (librarian == null) {
            response.sendRedirect("../user/gdLoginView2.jsp?err=timeout");
            return;
        }
        ReaderCard2 readerCard = (ReaderCard2) session.getAttribute("readerCard");
        BorrowRecord2[] borrowedRecords = (BorrowRecord2[]) session.getAttribute("borrowedRecords");
        if (readerCard == null || borrowedRecords == null) {
            response.sendRedirect("gdSearchReaderView2.jsp");
            return;
        }

        String[] selectedCopyIds = request.getParameterValues("chkSelectCopy");
        ReturnInvoice2 returnInvoice = null;

        if (selectedCopyIds != null && selectedCopyIds.length > 0) {
            Set<Integer> selectedSet = new HashSet<Integer>();
            for (String s : selectedCopyIds) {
                selectedSet.add(Integer.parseInt(s));
            }

            List<ReturnDetail2> returnDetailsList = new ArrayList<ReturnDetail2>();
            Date now = new Date();
            final float LATE_FINE_PER_DAY = 5000.0f; // 5,000 VNĐ / ngày quá hạn

            for (BorrowRecord2 rec : borrowedRecords) {
                if (rec.getBorrowDetails() == null) continue;
                for (BorrowDetail2 det : rec.getBorrowDetails()) {
                    DocumentCopy2 copy = det.getDocumentCopy();
                    if (selectedSet.contains(copy.getId())) {
                        float damageFine = 0.0f;
                        String dmgParam = request.getParameter("txtDamageFine_" + copy.getId());
                        if (dmgParam != null && !dmgParam.trim().isEmpty()) {
                            try {
                                damageFine = Float.parseFloat(dmgParam.trim());
                            } catch (NumberFormatException ex) {
                                damageFine = 0.0f;
                            }
                        }

                        String note = request.getParameter("txtNote_" + copy.getId());
                        if (note == null || note.trim().isEmpty()) {
                            note = "Trả tài liệu";
                        }

                        long overdueDays = 0;
                        if (rec.getReturnDue() != null && now.getTime() > rec.getReturnDue().getTime()) {
                            overdueDays = (now.getTime() - rec.getReturnDue().getTime()) / (1000L * 60 * 60 * 24);
                        }
                        float lateFine = overdueDays > 0 ? (overdueDays * LATE_FINE_PER_DAY) : 0.0f;

                        ReturnDetail2 rDetail = new ReturnDetail2();
                        rDetail.setDamageFine(damageFine);
                        rDetail.setLateFine(lateFine);
                        rDetail.setNote(note + (overdueDays > 0 ? " (Quá hạn " + overdueDays + " ngày)" : " (Đúng hạn)"));
                        rDetail.setDocumentCopy(copy);
                        returnDetailsList.add(rDetail);
                    }
                }
            }

            returnInvoice = new ReturnInvoice2();
            returnInvoice.setReturnDate(now);
            returnInvoice.setLibrarian(librarian);
            returnInvoice.setReaderCard(readerCard);
            returnInvoice.setReturnDetails(returnDetailsList.toArray(new ReturnDetail2[0]));
            returnInvoice.calculateTotalFine();
            session.setAttribute("returnInvoice", returnInvoice);
        } else {
            returnInvoice = (ReturnInvoice2) session.getAttribute("returnInvoice");
        }

        if (returnInvoice == null || returnInvoice.getReturnDetails() == null || returnInvoice.getReturnDetails().length == 0) {
            response.sendRedirect("gdBorrowDocumentListView2.jsp");
            return;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        DecimalFormat df = new DecimalFormat("#,##0");
    %>
    <div class="container">
        <h2>Hóa đơn Trả Tài liệu & Tính Tiền phạt (gdInvoiceView2)</h2>

        <div class="info-box">
            - <strong>Ngày trả (lblReturnDate):</strong>
              <span id="lblReturnDate"><%= sdf.format(returnInvoice.getReturnDate()) %></span><br/>
            - <strong>Bạn đọc:</strong> <%= readerCard.getReader().getFullName() %>
              (Mã thẻ: <strong><%= readerCard.getCardCode() %></strong> | Mã bạn đọc: <strong><%= readerCard.getReader().getReaderCode() %></strong>)<br/>
            - <strong>Nhân viên thư viện nhận trả:</strong> <%= librarian.getFullName() %><br/>
            - <em>Quy định phạt trả muộn: 5,000 VNĐ / ngày quá hạn trên mỗi tài liệu.</em>
        </div>

        <table id="tblReturnDetails" class="data-table">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã vạch (Barcode)</th>
                    <th>Tên tài liệu</th>
                    <th>Tác giả</th>
                    <th>Phạt hư hỏng (damageFine)</th>
                    <th>Phạt quá hạn (lateFine)</th>
                    <th>Thành tiền phạt</th>
                    <th>Ghi chú</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ReturnDetail2[] details = returnInvoice.getReturnDetails();
                    for (int i = 0; i < details.length; i++) {
                        ReturnDetail2 d = details[i];
                        DocumentCopy2 copy = d.getDocumentCopy();
                        Document2 doc = copy.getDocument();
                        float subTotal = d.getDamageFine() + d.getLateFine();
                %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td><strong><%= copy.getBarcode() %></strong></td>
                    <td><%= doc.getName() %></td>
                    <td><%= doc.getAuthor() %></td>
                    <td><%= df.format(d.getDamageFine()) %> VNĐ</td>
                    <td><%= df.format(d.getLateFine()) %> VNĐ</td>
                    <td><strong><%= df.format(subTotal) %> VNĐ</strong></td>
                    <td><%= d.getNote() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div style="margin-top: 18px; text-align: right; font-size: 18px;">
            <strong>Tổng tiền phạt (lblFineAmount): </strong>
            <span id="lblFineAmount" style="color: #dc2626; font-weight: 700;">
                <%= df.format(returnInvoice.calculateTotalFine()) %> VNĐ
            </span>
        </div>

        <div class="btn-row">
            <button type="button" id="btnContinue" name="btnContinue" class="btn"
                    onclick="window.location.href='gdInvoiceConfirmationView2.jsp'">
                Tiếp tục xác nhận hóa đơn (btnContinue)
            </button>
            <button type="button" id="btnBack" name="btnBack" class="btn btn-secondary"
                    onclick="window.location.href='gdBorrowDocumentListView2.jsp'">
                Quay lại chọn tài liệu (btnBack)
            </button>
        </div>
    </div>
</body>
</html>
