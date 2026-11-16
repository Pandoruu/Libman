<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.text.SimpleDateFormat,java.util.Calendar,java.util.Date,model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký thẻ bạn đọc trực tuyến (gdRegisterCardView2)</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <%
        Reader2 reader = (Reader2) session.getAttribute("reader");
        SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
        Date today = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(today);
        cal.add(Calendar.YEAR, 4);
        Date defaultExpiry = cal.getTime();

        String defaultCodeSuffix = String.valueOf(System.currentTimeMillis() % 100000);
        String defaultReaderCode = (reader != null && reader.getReaderCode() != null)
                ? reader.getReaderCode() : ("SV" + defaultCodeSuffix);
        String defaultCardCode = "CARD" + defaultCodeSuffix;
    %>
    <div class="container">
        <h2>Đăng ký Thẻ Bạn đọc Trực tuyến (gdRegisterCardView2)</h2>
        <div class="info-box">
            Vui lòng nhập đầy đủ thông tin cá nhân của bạn đọc và thông tin thẻ bạn đọc cần đăng ký, sau đó nhấn <strong>Lưu (btnSave)</strong>.
        </div>

        <form name="frmRegisterCard" action="doSaveRegisterCard2.jsp" method="post">
            <h3>1. Thông tin Bạn đọc (Reader2)</h3>
            <% if (reader == null) { %>
                <div class="form-group">
                    <label for="txtUsername">Tên đăng nhập (txtUsername):</label>
                    <input type="text" id="txtUsername" name="txtUsername" value="<%= "sv" + defaultCodeSuffix %>" required />
                </div>
                <div class="form-group">
                    <label for="txtPassword">Mật khẩu (txtPassword):</label>
                    <input type="password" id="txtPassword" name="txtPassword" value="123456" required />
                </div>
            <% } %>
            <div class="form-group">
                <label for="txtReaderCode">Mã bạn đọc / SV (txtReaderCode):</label>
                <input type="text" id="txtReaderCode" name="txtReaderCode" value="<%= defaultReaderCode %>" required />
            </div>
            <div class="form-group">
                <label for="txtFullName">Họ và tên (txtFullName):</label>
                <input type="text" id="txtFullName" name="txtFullName"
                       value="<%= (reader != null && reader.getFullName() != null) ? reader.getFullName() : "" %>"
                       placeholder="VD: Nguyễn Văn An" required />
            </div>
            <div class="form-group">
                <label for="txtDob">Ngày sinh (txtDob):</label>
                <input type="date" id="txtDob" name="txtDob"
                       value="<%= (reader != null && reader.getDob() != null) ? sdfInput.format(reader.getDob()) : "2003-05-15" %>"
                       required />
            </div>
            <div class="form-group">
                <label for="txtAddress">Địa chỉ (txtAddress):</label>
                <input type="text" id="txtAddress" name="txtAddress"
                       value="<%= (reader != null && reader.getAddress() != null) ? reader.getAddress() : "" %>"
                       placeholder="VD: Km10 Đường Nguyễn Trãi, Hà Đông, Hà Nội" required />
            </div>
            <div class="form-group">
                <label for="txtPhone">Số điện thoại (txtPhone):</label>
                <input type="text" id="txtPhone" name="txtPhone"
                       value="<%= (reader != null && reader.getPhone() != null) ? reader.getPhone() : "" %>"
                       placeholder="VD: 0912345678" required />
            </div>
            <div class="form-group">
                <label for="txtEmail">Email (txtEmail):</label>
                <input type="email" id="txtEmail" name="txtEmail"
                       value="<%= (reader != null && reader.getEmail() != null) ? reader.getEmail() : "" %>"
                       placeholder="VD: nguyenvanan@stu.ptit.edu.vn" required />
            </div>

            <h3>2. Thông tin Thẻ Bạn đọc (ReaderCard2)</h3>
            <div class="form-group">
                <label for="txtCardCode">Mã thẻ bạn đọc (txtCardCode):</label>
                <input type="text" id="txtCardCode" name="txtCardCode" value="<%= defaultCardCode %>" required />
            </div>
            <div class="form-group">
                <label for="txtIssueDate">Ngày cấp thẻ (txtIssueDate):</label>
                <input type="date" id="txtIssueDate" name="txtIssueDate" value="<%= sdfInput.format(today) %>" required />
            </div>
            <div class="form-group">
                <label for="txtExpiryDate">Ngày hết hạn (txtExpiryDate):</label>
                <input type="date" id="txtExpiryDate" name="txtExpiryDate" value="<%= sdfInput.format(defaultExpiry) %>" required />
            </div>

            <div class="btn-row">
                <button type="submit" id="btnSave" name="btnSave" class="btn btn-success">Lưu đăng ký (btnSave)</button>
                <button type="button" id="btnBack" name="btnBack" class="btn btn-secondary"
                        onclick="window.location.href='gdReaderMainView2.jsp'">Quay lại (btnBack)</button>
            </div>
        </form>
    </div>
</body>
</html>
