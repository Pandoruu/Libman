<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.text.SimpleDateFormat,java.util.Date,model.*,dao.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    Reader2 sessionReader = (Reader2) session.getAttribute("reader");
    Reader2 reader = new Reader2();
    if (sessionReader != null) {
        reader.setId(sessionReader.getId());
        reader.setUsername(sessionReader.getUsername());
        reader.setPassword(sessionReader.getPassword());
    } else {
        reader.setUsername(request.getParameter("txtUsername"));
        reader.setPassword(request.getParameter("txtPassword"));
    }

    reader.setReaderCode(request.getParameter("txtReaderCode"));
    reader.setFullName(request.getParameter("txtFullName"));
    String dobStr = request.getParameter("txtDob");
    if (dobStr != null && !dobStr.isEmpty()) {
        reader.setDob(sdf.parse(dobStr));
    }
    reader.setAddress(request.getParameter("txtAddress"));
    reader.setPhone(request.getParameter("txtPhone"));
    reader.setEmail(request.getParameter("txtEmail"));
    reader.setRole("Reader");

    ReaderCard2 card = new ReaderCard2();
    card.setCardCode(request.getParameter("txtCardCode"));
    String issueStr = request.getParameter("txtIssueDate");
    if (issueStr != null && !issueStr.isEmpty()) {
        card.setIssueDate(sdf.parse(issueStr));
    } else {
        card.setIssueDate(new Date());
    }
    String expiryStr = request.getParameter("txtExpiryDate");
    if (expiryStr != null && !expiryStr.isEmpty()) {
        card.setExpiryDate(sdf.parse(expiryStr));
    }
    card.setStatus("Active");
    card.setReader(reader);

    ReaderCardDAO2 cardDAO = new ReaderCardDAO2();
    boolean success = cardDAO.registerReaderCard(card);

    if (success) {
        session.setAttribute("reader", reader);
        session.setAttribute("registeredCard", card);
%>
    <script type="text/javascript">
        alert("Đăng ký thẻ bạn đọc trực tuyến thành công! Mã thẻ: <%= card.getCardCode() %>");
        window.location.href = "gdReaderMainView2.jsp";
    </script>
<%
    } else {
%>
    <script type="text/javascript">
        alert("Lỗi đăng ký thẻ bạn đọc (Mã thẻ hoặc mã bạn đọc đã tồn tại hoặc lỗi kết nối CSDL)!");
        history.back();
    </script>
<%
    }
%>
