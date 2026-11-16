<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ Nhân viên Quản lý (gdManagerMainView2)</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <%
        Manager2 manager = (Manager2) session.getAttribute("manager");
        if (manager == null) {
            response.sendRedirect("../user/gdLoginView2.jsp?err=timeout");
            return;
        }
    %>
    <div class="container">
        <h2>Trang chủ Nhân viên Quản lý (gdManagerMainView2)</h2>
        <div class="info-box">
            Xin chào Nhân viên quản lý: <strong><%= manager.getFullName() %></strong>
            (Tài khoản: <code><%= manager.getUsername() %></code> | Chức vụ: <strong><%= manager.getPosition() %></strong>)
        </div>
        <div class="btn-row">
            <a href="../user/gdLoginView2.jsp" class="btn btn-secondary">Đăng xuất</a>
        </div>
    </div>
</body>
</html>
