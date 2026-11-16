<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.text.DecimalFormat,java.text.SimpleDateFormat,java.util.Date,model.*,dao.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Phiếu Thanh toán & Xác nhận Trả Tài liệu (doSaveReturn2)</title>
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
            response.sendRedirect("gdLibrarianMainView2.jsp");
            return;
        }

        PaymentSlip2 paymentSlip = new PaymentSlip2();
        paymentSlip.setPaymentDate(new Date());
        returnInvoice.setPaymentSlip(paymentSlip);

        ReturnInvoiceDAO2 invoiceDAO = new ReturnInvoiceDAO2();
        boolean saved = invoiceDAO.saveReturnInvoice(returnInvoice);

        if (!saved) {
    %>
        <script type="text/javascript">
            alert("Có lỗi xảy ra khi lưu hóa đơn trả tài liệu vào CSDL!");
            window.location.href = "gdInvoiceConfirmationView2.jsp";
        </script>
    <%
            return;
        }

        ReaderCard2 readerCard = returnInvoice.getReaderCard();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        DecimalFormat df = new DecimalFormat("#,##0");

        session.removeAttribute("returnInvoice");
        session.removeAttribute("borrowedRecords");
    %>
    <div class="container">
        <div class="alert-success no-print">
            Lưu hóa đơn trả tài liệu (Mã HĐ: <strong>#<%= returnInvoice.getId() %></strong>)
            và phiếu thanh toán (Mã phiếu: <strong>#<%= paymentSlip.getId() %></strong>) vào CSDL thành công!
        </div>

        <h2 style="text-align: center;">PHIẾU THANH TOÁN &amp; HÓA ĐƠN TRẢ TÀI LIỆU</h2>
        <p style="text-align: center; margin-top: -6px; color: #475569;">
            Thư viện Trường Đại học (LibMan) — Mã Hóa đơn trả: <strong>#<%= returnInvoice.getId() %></strong>
            | Mã Phiếu thanh toán: <strong>#<%= paymentSlip.getId() %></strong>
        </p>

        <table class="data-table">
            <tbody>
                <tr>
                    <th style="width: 220px;">Họ và tên bạn đọc</th>
                    <td><strong><%= readerCard.getReader().getFullName() %></strong></td>
                    <th style="width: 200px;">Mã thẻ / Mã bạn đọc</th>
                    <td><strong><%= readerCard.getCardCode() %></strong> / <%= readerCard.getReader().getReaderCode() %></td>
                </tr>
                <tr>
                    <th>Nhân viên thư viện thu</th>
                    <td><%= librarian.getFullName() %></td>
                    <th>Ngày giờ thanh toán</th>
                    <td><%= sdf.format(paymentSlip.getPaymentDate()) %></td>
                </tr>
            </tbody>
        </table>

        <h3>Danh mục Tài liệu Đã trả</h3>
        <table class="data-table">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã vạch</th>
                    <th>Tên tài liệu</th>
                    <th>Phạt hư hỏng</th>
                    <th>Phạt quá hạn</th>
                    <th>Thành tiền</th>
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

        <div style="margin-top: 18px; text-align: right; font-size: 18px;">
            <strong>Tổng số tiền phạt đã thanh toán: </strong>
            <span style="color: #dc2626; font-weight: 700;">
                <%= df.format(returnInvoice.calculateTotalFine()) %> VNĐ
            </span>
        </div>

        <div style="display: flex; justify-content: space-between; margin-top: 32px; padding: 0 40px;">
            <div style="text-align: center;">
                <strong>Bạn đọc trả tài liệu</strong><br/>
                <em>(Ký và ghi rõ họ tên)</em><br/><br/><br/>
                <span><%= readerCard.getReader().getFullName() %></span>
            </div>
            <div style="text-align: center;">
                <strong>Nhân viên thư viện</strong><br/>
                <em>(Ký và ghi rõ họ tên)</em><br/><br/><br/>
                <span><%= librarian.getFullName() %></span>
            </div>
        </div>

        <div class="btn-row no-print" style="margin-top: 30px;">
            <button type="button" class="btn btn-success" onclick="window.print();">
                In Phiếu Thanh toán (Print)
            </button>
            <button type="button" class="btn" onclick="window.location.href='gdSearchReaderView2.jsp'">
                Tiếp tục nhận trả tài liệu khác
            </button>
            <button type="button" class="btn btn-secondary" onclick="window.location.href='gdLibrarianMainView2.jsp'">
                Về Trang chủ Nhân viên Thư viện
            </button>
        </div>
    </div>
</body>
</html>
