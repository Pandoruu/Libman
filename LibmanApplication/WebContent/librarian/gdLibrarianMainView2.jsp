<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ Nhân viên Thư viện (gdLibrarianMainView2)</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <%
        Librarian2 librarian = (Librarian2) session.getAttribute("librarian");
        if (librarian == null) {
            response.sendRedirect("../user/gdLoginView2.jsp?err=timeout");
            return;
        }
    %>
    <div class="container">
        <h2>Trang chủ Nhân viên Thư viện (gdLibrarianMainView2)</h2>
        <div class="info-box">
            Xin chào Nhân viên thư viện: <strong><%= librarian.getFullName() %></strong>
            (Tài khoản: <code><%= librarian.getUsername() %></code> | Chức vụ: <strong><%= librarian.getPosition() %></strong>)
        </div>

        <h3>Menu Nghiệp vụ Thư viện</h3>
        <div class="btn-row">
            <button type="button" id="subReturnDocument" class="btn"
                onclick="window.location.href='gdSearchReaderView2.jsp'">
                Nhận và trả tài liệu (subReturnDocument)
            </button>
            <a href="../user/gdLoginView2.jsp" class="btn btn-secondary">Đăng xuất</a>
        </div>
    </div>
</body>
</html>
