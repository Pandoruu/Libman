<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="model.*,dao.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm Thẻ Bạn đọc (gdSearchReaderView2)</title>
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

        String errorMsg = null;
        String cardScanInfo = request.getParameter("txtCardScanInfo");
        String readerCode = request.getParameter("txtReaderCode");

        if (request.getParameter("btnConfirm") != null) {
            String keyword = (cardScanInfo != null && !cardScanInfo.trim().isEmpty())
                    ? cardScanInfo.trim()
                    : (readerCode != null ? readerCode.trim() : "");
            if (keyword.isEmpty()) {
                errorMsg = "Vui lòng quét mã thẻ bạn đọc hoặc nhập mã bạn đọc để tìm kiếm!";
            } else {
                ReaderCardDAO2 cardDAO = new ReaderCardDAO2();
                ReaderCard2 card = cardDAO.findReaderCard(keyword);
                if (card != null) {
                    session.setAttribute("readerCard", card);
                    session.removeAttribute("returnInvoice");
                    response.sendRedirect("gdBorrowDocumentListView2.jsp");
                    return;
                } else {
                    errorMsg = "Không tìm thấy thẻ bạn đọc với mã: " + keyword;
                }
            }
        }
    %>
    <div class="container" style="max-width: 680px;">
        <h2>Nhận và Trả Tài liệu - Tìm Thẻ Bạn đọc (gdSearchReaderView2)</h2>
        <div class="info-box">
            Quét mã thẻ bạn đọc (<code>txtCardScanInfo</code>) hoặc nhập mã sinh viên / bạn đọc (<code>txtReaderCode</code>) để tra cứu danh sách tài liệu đang mượn.
        </div>

        <% if (errorMsg != null) { %>
            <div class="alert-error"><%= errorMsg %></div>
        <% } %>

        <form name="frmSearchReader" action="gdSearchReaderView2.jsp" method="post">
            <div class="form-group">
                <label for="txtCardScanInfo">Quét mã thẻ (txtCardScanInfo):</label>
                <input type="text" id="txtCardScanInfo" name="txtCardScanInfo"
                       value="<%= cardScanInfo != null ? cardScanInfo : "" %>"
                       placeholder="VD: CARD001 hoặc CARD002" autofocus />
            </div>
            <div class="form-group">
                <label for="txtReaderCode">Hoặc Mã bạn đọc (txtReaderCode):</label>
                <input type="text" id="txtReaderCode" name="txtReaderCode"
                       value="<%= readerCode != null ? readerCode : "" %>"
                       placeholder="VD: SV001 hoặc SV002" />
            </div>
            <div class="btn-row">
                <button type="submit" id="btnConfirm" name="btnConfirm" value="1" class="btn">Xác nhận tìm (btnConfirm)</button>
                <button type="button" id="btnBack" name="btnBack" class="btn btn-secondary"
                        onclick="window.location.href='gdLibrarianMainView2.jsp'">Quay lại (btnBack)</button>
            </div>
        </form>

        <div class="info-box" style="margin-top: 22px; font-size: 13px;">
            <strong>Dữ liệu mẫu để kiểm thử nhanh:</strong>
            <ul style="margin: 6px 0 0 18px; padding: 0;">
                <li><code>CARD001</code> (hoặc <code>SV001</code> - Nguyễn Văn An): Đang mượn 3 tài liệu (có cả tài liệu quá hạn và trong hạn).</li>
                <li><code>CARD002</code> (hoặc <code>SV002</code> - Trần Thị Bình): Đang mượn 2 tài liệu.</li>
            </ul>
        </div>
    </div>
</body>
</html>
