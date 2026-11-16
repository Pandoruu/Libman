<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="model.*,dao.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("txtUsername");
    String password = request.getParameter("txtPassword");

    User2 user = new User2();
    user.setUsername(username);
    user.setPassword(password);

    UserDAO2 userDAO = new UserDAO2();
    boolean ok = userDAO.checkLogin(user);

    if (ok && user.getRole() != null) {
        session.setAttribute("user", user);
        if (user.getRole().equalsIgnoreCase("Reader")) {
            Reader2 reader = new Reader2();
            reader.setId(user.getId());
            reader.setUsername(user.getUsername());
            reader.setFullName(user.getFullName());
            reader.setDob(user.getDob());
            reader.setAddress(user.getAddress());
            reader.setPhone(user.getPhone());
            reader.setEmail(user.getEmail());
            reader.setRole(user.getRole());
            session.setAttribute("reader", reader);
            response.sendRedirect("../reader/gdReaderMainView2.jsp");
        } else if (user.getRole().equalsIgnoreCase("Librarian")) {
            Librarian2 librarian = new Librarian2();
            librarian.setId(user.getId());
            librarian.setUsername(user.getUsername());
            librarian.setFullName(user.getFullName());
            librarian.setDob(user.getDob());
            librarian.setAddress(user.getAddress());
            librarian.setPhone(user.getPhone());
            librarian.setEmail(user.getEmail());
            librarian.setRole(user.getRole());
            librarian.setPosition("Librarian");
            session.setAttribute("librarian", librarian);
            response.sendRedirect("../librarian/gdLibrarianMainView2.jsp");
        } else if (user.getRole().equalsIgnoreCase("Manager")) {
            Manager2 manager = new Manager2();
            manager.setId(user.getId());
            manager.setUsername(user.getUsername());
            manager.setFullName(user.getFullName());
            manager.setDob(user.getDob());
            manager.setAddress(user.getAddress());
            manager.setPhone(user.getPhone());
            manager.setEmail(user.getEmail());
            manager.setRole(user.getRole());
            manager.setPosition("Manager");
            session.setAttribute("manager", manager);
            response.sendRedirect("../manager/gdManagerMainView2.jsp");
        } else {
            response.sendRedirect("gdLoginView2.jsp?err=fail");
        }
    } else {
        response.sendRedirect("gdLoginView2.jsp?err=fail");
    }
%>
