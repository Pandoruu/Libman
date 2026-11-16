<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    * { box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    body { margin: 0; padding: 0; background-color: #f4f6f9; color: #2c3e50; }
    .navbar {
        background-color: #1e3a8a;
        color: #ffffff;
        padding: 12px 28px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 6px rgba(0,0,0,0.15);
    }
    .navbar .brand { font-size: 20px; font-weight: 700; letter-spacing: 0.5px; }
    .navbar .nav-links a {
        color: #e0e7ff;
        text-decoration: none;
        margin-left: 16px;
        font-size: 14px;
        padding: 6px 12px;
        border-radius: 4px;
        background: rgba(255,255,255,0.12);
    }
    .navbar .nav-links a:hover { background: rgba(255,255,255,0.25); color: #fff; }
    .container {
        max-width: 980px;
        margin: 28px auto;
        background: #ffffff;
        padding: 28px 34px;
        border-radius: 8px;
        box-shadow: 0 3px 12px rgba(0,0,0,0.08);
    }
    h2 { color: #1e3a8a; margin-top: 0; border-bottom: 2px solid #e5e7eb; padding-bottom: 10px; }
    h3 { color: #334155; margin-top: 18px; }
    .form-group { margin-bottom: 14px; display: flex; align-items: center; }
    .form-group label { width: 200px; font-weight: 600; color: #374151; }
    .form-group input, .form-group select {
        flex: 1;
        padding: 8px 12px;
        border: 1px solid #cbd5e1;
        border-radius: 5px;
        font-size: 14px;
    }
    .btn-row { margin-top: 22px; display: flex; gap: 12px; }
    .btn {
        padding: 9px 20px;
        border: none;
        border-radius: 5px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        background-color: #2563eb;
        color: #ffffff;
    }
    .btn:hover { background-color: #1d4ed8; }
    .btn-secondary { background-color: #64748b; color: #ffffff; }
    .btn-secondary:hover { background-color: #475569; }
    .btn-success { background-color: #16a34a; color: #ffffff; }
    .btn-success:hover { background-color: #15803d; }
    table.data-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 14px;
        font-size: 14px;
    }
    table.data-table th, table.data-table td {
        border: 1px solid #cbd5e1;
        padding: 10px 12px;
        text-align: left;
    }
    table.data-table th {
        background-color: #eff6ff;
        color: #1e3a8a;
        font-weight: 700;
    }
    table.data-table tr:nth-child(even) { background-color: #f8fafc; }
    .info-box {
        background-color: #f8fafc;
        border-left: 4px solid #2563eb;
        padding: 12px 16px;
        margin-bottom: 18px;
        border-radius: 4px;
    }
    .alert-error {
        background-color: #fef2f2;
        border-left: 4px solid #dc2626;
        color: #991b1b;
        padding: 10px 14px;
        margin-bottom: 16px;
        border-radius: 4px;
    }
    .alert-success {
        background-color: #f0fdf4;
        border-left: 4px solid #16a34a;
        color: #166534;
        padding: 10px 14px;
        margin-bottom: 16px;
        border-radius: 4px;
    }
    @media print {
        .no-print { display: none !important; }
        body { background: #fff; }
        .container { box-shadow: none; margin: 0; width: 100%; max-width: 100%; }
    }
</style>
<div class="navbar no-print">
    <div class="brand">HỆ THỐNG QUẢN LÝ THƯ VIỆN ĐẠI HỌC (LIBMAN - SUBJECT NO. 02)</div>
    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/user/gdLoginView2.jsp">Đăng nhập / Đổi tài khoản</a>
    </div>
</div>
