<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.text.DecimalFormat,java.text.SimpleDateFormat,model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận Hóa đơn Trả & Thanh toán (gdInvoiceConfirmationView2)</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <%
        Librarian2 librarian = (Librarian2) session.getAttribute("librarian");
        if (librarian == null) {
            response.sendRedirect("../user/gdLoginView2.jsp?err=timeout");
            return;
        }
        ReturnInvoice2 returnInvoice = (ReturnInvoice2) session.getAttribute("returnInvoice");
        if (returnInvoice == null) {
            response.sendRedirect("gdBorrowDocumentListView2.jsp");
            return;
        }
        ReaderCard2 readerCard = returnInvoice.getReaderCard();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        DecimalFormat df = new DecimalFormat("#,##0");
    %>
    <div class="container">
        <h2>Xác nhận Hóa đơn Trả Tài liệu & In Phiếu Thanh toán (gdInvoiceConfirmationView2)</h2>

        <div class="info-box">
            Vui lòng kiểm tra lại toàn bộ thông tin hóa đơn trả tài liệu trước khi lưu vào CSDL và in phiếu thanh toán giao cho bạn đọc.
        </div>

        <table id="tblInvoiceInfo" class="data-table">
            <tbody>
                <tr>
                    <th style="width: 240px;">Họ và tên bạn đọc</th>
                    <td><strong><%= readerCard.getReader().getFullName() %></strong></td>
                    <th style="width: 200px;">Mã bạn đọc / Mã thẻ</th>
                    <td><%= readerCard.getReader().getReaderCode() %> / <strong><%= readerCard.getCardCode() %></strong></td>
                </tr>
                <tr>
                    <th>Nhân viên thư viện thực hiện</th>
                    <td><%= librarian.getFullName() %></td>
                    <th>Ngày trả tài liệu</th>
                    <td><%= sdf.format(returnInvoice.getReturnDate()) %></td>
                </tr>
                <tr>
                    <th>Số lượng tài liệu trả</th>
                    <td><%= returnInvoice.getReturnDetails().length %> cuốn</td>
                    <th>Tổng tiền phạt cần thu (lblTotalFine)</th>
                    <td>
                        <span id="lblTotalFine" style="color: #dc2626; font-weight: 700; font-size: 16px;">
                            <%= df.format(returnInvoice.calculateTotalFine()) %> VNĐ
                        </span>
                    </td>
                </tr>
            </tbody>
        </table>

        <h3>Chi tiết Tài liệu Trả trong Hóa đơn</h3>
        <table class="data-table">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã vạch</th>
                    <th>Tên tài liệu</th>
                    <th>Phạt hư hỏng</th>
                    <th>Phạt trả muộn</th>
                    <th>Tổng phạt dòng</th>
                    <th>Ghi chú</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ReturnDetail2[] details = returnInvoice.getReturnDetails();
                    for (int i = 0; i < details.length; i++) {
                        ReturnDetail2 d = details[i];
                        DocumentCopy2 copy = d.getDocumentCopy();
                %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td><strong><%= copy.getBarcode() %></strong></td>
                    <td><%= copy.getDocument().getName() %></td>
                    <td><%= df.format(d.getDamageFine()) %> VNĐ</td>
                    <td><%= df.format(d.getLateFine()) %> VNĐ</td>
                    <td><strong><%= df.format(d.getDamageFine() + d.getLateFine()) %> VNĐ</strong></td>
                    <td><%= d.getNote() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <form name="frmConfirmReturn" action="doSaveReturn2.jsp" method="post">
            <div class="btn-row">
                <button type="submit" id="btnConfirmPrint" name="btnConfirmPrint" class="btn btn-success">
                    Xác nhận Lưu & In Phiếu Thanh toán (btnConfirmPrint)
                </button>
                <button type="button" id="btnBack" name="btnBack" class="btn btn-secondary"
                        onclick="window.location.href='gdInvoiceView2.jsp'">
                    Quay lại (btnBack)
                </button>
            </div>
        </form>
    </div>
</body>
</html>
