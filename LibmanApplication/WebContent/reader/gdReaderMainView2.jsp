<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.text.SimpleDateFormat,model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ Bạn đọc (gdReaderMainView2)</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <%
        Reader2 reader = (Reader2) session.getAttribute("reader");
        ReaderCard2 registeredCard = (ReaderCard2) session.getAttribute("registeredCard");
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    %>
    <div class="container">
        <h2>Trang chủ Bạn đọc (gdReaderMainView2)</h2>

        <div class="info-box">
            <% if (reader != null) { %>
                Xin chào bạn đọc: <strong><%= reader.getFullName() %></strong>
                <% if (reader.getReaderCode() != null) { %>
                    (Mã bạn đọc: <strong><%= reader.getReaderCode() %></strong>)
                <% } %>
            <% } else { %>
                Chào mừng bạn đọc đến với Cổng thông tin Thư viện Đại học (LibMan).
            <% } %>
        </div>

        <% if (registeredCard != null) { %>
            <div class="alert-success">
                <strong>Thông tin thẻ bạn đọc vừa đăng ký thành công:</strong><br/>
                - Mã thẻ (cardCode): <strong><%= registeredCard.getCardCode() %></strong><br/>
                - Mã sinh viên / bạn đọc (readerCode): <strong><%= registeredCard.getReader().getReaderCode() %></strong><br/>
                - Họ và tên: <strong><%= registeredCard.getReader().getFullName() %></strong><br/>
                - Ngày cấp: <strong><%= registeredCard.getIssueDate() != null ? sdf.format(registeredCard.getIssueDate()) : "" %></strong>
                | Ngày hết hạn: <strong><%= registeredCard.getExpiryDate() != null ? sdf.format(registeredCard.getExpiryDate()) : "" %></strong>
                | Trạng thái: <strong><%= registeredCard.getStatus() %></strong>
            </div>
        <% } %>

        <h3>Chức năng dành cho Bạn đọc</h3>
        <div class="btn-row">
            <button type="button" id="subRegisterCard" class="btn"
                onclick="window.location.href='gdRegisterCardView2.jsp'">
                Đăng ký thẻ bạn đọc trực tuyến (subRegisterCard)
            </button>
            <a href="../user/gdLoginView2.jsp" class="btn btn-secondary">Thoát / Đổi tài khoản</a>
        </div>
    </div>
</body>
</html>
