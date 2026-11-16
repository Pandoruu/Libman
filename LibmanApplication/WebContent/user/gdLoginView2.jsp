<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống LibMan (gdLoginView2)</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="container" style="max-width: 560px;">
        <h2>Đăng nhập Hệ thống Thư viện (LibMan)</h2>

        <%
            String err = request.getParameter("err");
            if ("timeout".equals(err)) {
        %>
            <div class="alert-error">Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại!</div>
        <%
            } else if ("fail".equals(err)) {
        %>
            <div class="alert-error">Sai tên đăng nhập hoặc mật khẩu!</div>
        <%
            }
        %>

        <form name="frmLogin" action="doLogin2.jsp" method="post">
            <div class="form-group">
                <label for="txtUsername">Tên đăng nhập (txtUsername):</label>
                <input type="text" id="txtUsername" name="txtUsername" required placeholder="VD: librarian1 hoặc reader1" />
            </div>
            <div class="form-group">
                <label for="txtPassword">Mật khẩu (txtPassword):</label>
                <input type="password" id="txtPassword" name="txtPassword" required placeholder="Nhập mật khẩu (VD: 123456)" />
            </div>
            <div class="btn-row">
                <button type="submit" id="btnLogin" class="btn">Đăng nhập</button>
                <a href="../reader/gdReaderMainView2.jsp" class="btn btn-success">Bạn đọc đăng ký thẻ trực tuyến</a>
            </div>
        </form>

        <div class="info-box" style="margin-top: 24px; font-size: 13px;">
            <strong>Tài khoản mẫu trong CSDL (Mật khẩu: <code>123456</code>):</strong>
            <ul style="margin: 6px 0 0 18px; padding: 0;">
                <li><strong>Nhân viên thư viện (Module 2):</strong> <code>librarian1</code> / <code>123456</code></li>
                <li><strong>Bạn đọc (Module 1):</strong> <code>reader1</code> / <code>123456</code> (hoặc nhấn trực tiếp <em>"Bạn đọc đăng ký thẻ trực tuyến"</em>)</li>
                <li><strong>Nhân viên quản lý:</strong> <code>manager1</code> / <code>123456</code></li>
            </ul>
        </div>
    </div>
</body>
</html>
