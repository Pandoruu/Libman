-- =============================================================================
-- CƠ SỞ DỮ LIỆU HỆ THỐNG QUẢN LÝ THƯ VIỆN ĐẠI HỌC (LIBMAN - SUBJECT NO. 02)
-- Thiết kế tuân thủ Báo cáo Pha Thiết kế (ERD & Sơ đồ lớp thực thể hậu tố 2)
-- =============================================================================

DROP DATABASE IF EXISTS libman_db2;
CREATE DATABASE libman_db2 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE libman_db2;

-- 1. Bảng tblUser2 (Lớp cha User2)
CREATE TABLE tblUser2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    fullName VARCHAR(255) NOT NULL,
    dob DATE,
    address VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(255),
    role VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Bảng tblStaff2 (Kế thừa tblUser2)
CREATE TABLE tblStaff2 (
    tblUser2id INT PRIMARY KEY,
    position VARCHAR(255) NOT NULL,
    CONSTRAINT fk_staff_user FOREIGN KEY (tblUser2id) REFERENCES tblUser2(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Bảng tblLibrarian2 (Kế thừa tblStaff2)
CREATE TABLE tblLibrarian2 (
    tblStaff2id INT PRIMARY KEY,
    CONSTRAINT fk_librarian_staff FOREIGN KEY (tblStaff2id) REFERENCES tblStaff2(tblUser2id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Bảng tblManager2 (Kế thừa tblStaff2)
CREATE TABLE tblManager2 (
    tblStaff2id INT PRIMARY KEY,
    CONSTRAINT fk_manager_staff FOREIGN KEY (tblStaff2id) REFERENCES tblStaff2(tblUser2id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Bảng tblReader2 (Kế thừa tblUser2)
CREATE TABLE tblReader2 (
    tblUser2id INT PRIMARY KEY,
    readerCode VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT fk_reader_user FOREIGN KEY (tblUser2id) REFERENCES tblUser2(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Bảng tblReaderCard2 (Thẻ bạn đọc)
CREATE TABLE tblReaderCard2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cardCode VARCHAR(50) NOT NULL UNIQUE,
    issueDate DATE NOT NULL,
    expiryDate DATE NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Active',
    tblReader2id INT NOT NULL,
    CONSTRAINT fk_card_reader FOREIGN KEY (tblReader2id) REFERENCES tblReader2(tblUser2id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Bảng tblSupplier2 (Nhà cung cấp tài liệu)
CREATE TABLE tblSupplier2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. Bảng tblImportDocumentInvoice2 (Hóa đơn nhập tài liệu)
CREATE TABLE tblImportDocumentInvoice2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    importDate DATE NOT NULL,
    note VARCHAR(255),
    tblSupplier2id INT NOT NULL,
    tblLibrarian2id INT NOT NULL,
    CONSTRAINT fk_import_supplier FOREIGN KEY (tblSupplier2id) REFERENCES tblSupplier2(id),
    CONSTRAINT fk_import_librarian FOREIGN KEY (tblLibrarian2id) REFERENCES tblLibrarian2(tblStaff2id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. Bảng tblDocument2 (Đầu mục tài liệu)
CREATE TABLE tblDocument2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    publisher VARCHAR(255),
    category VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 10. Bảng tblImportDocumentDetail2 (Chi tiết hóa đơn nhập tài liệu)
CREATE TABLE tblImportDocumentDetail2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    price FLOAT NOT NULL,
    tblImportDocumentInvoice2id INT NOT NULL,
    tblDocument2id INT NOT NULL,
    CONSTRAINT fk_importdetail_invoice FOREIGN KEY (tblImportDocumentInvoice2id) REFERENCES tblImportDocumentInvoice2(id) ON DELETE CASCADE,
    CONSTRAINT fk_importdetail_document FOREIGN KEY (tblDocument2id) REFERENCES tblDocument2(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 11. Bảng tblDocumentCopy2 (Bản sao tài liệu cụ thể có mã vạch)
CREATE TABLE tblDocumentCopy2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    barcode VARCHAR(100) NOT NULL UNIQUE,
    `condition` VARCHAR(255) NOT NULL DEFAULT 'Tốt (100%)',
    status VARCHAR(50) NOT NULL DEFAULT 'Available',
    tblDocument2id INT NOT NULL,
    CONSTRAINT fk_copy_document FOREIGN KEY (tblDocument2id) REFERENCES tblDocument2(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 12. Bảng tblBorrowRecord2 (Phiếu mượn tài liệu)
CREATE TABLE tblBorrowRecord2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    borrowDate DATE NOT NULL,
    returnDue DATE NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Borrowing',
    tblReaderCard2id INT NOT NULL,
    tblLibrarian2id INT NOT NULL,
    CONSTRAINT fk_borrow_card FOREIGN KEY (tblReaderCard2id) REFERENCES tblReaderCard2(id),
    CONSTRAINT fk_borrow_librarian FOREIGN KEY (tblLibrarian2id) REFERENCES tblLibrarian2(tblStaff2id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 13. Bảng tblBorrowDetail2 (Chi tiết phiếu mượn tài liệu)
CREATE TABLE tblBorrowDetail2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    note VARCHAR(255),
    status VARCHAR(50) NOT NULL DEFAULT 'Borrowing',
    tblBorrowRecord2id INT NOT NULL,
    tblDocumentCopy2id INT NOT NULL,
    CONSTRAINT fk_borrowdetail_record FOREIGN KEY (tblBorrowRecord2id) REFERENCES tblBorrowRecord2(id) ON DELETE CASCADE,
    CONSTRAINT fk_borrowdetail_copy FOREIGN KEY (tblDocumentCopy2id) REFERENCES tblDocumentCopy2(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 14. Bảng tblReturnInvoice2 (Hóa đơn trả tài liệu)
CREATE TABLE tblReturnInvoice2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    returnDate DATE NOT NULL,
    tblReaderCard2id INT NOT NULL,
    tblLibrarian2id INT NOT NULL,
    CONSTRAINT fk_return_card FOREIGN KEY (tblReaderCard2id) REFERENCES tblReaderCard2(id),
    CONSTRAINT fk_return_librarian FOREIGN KEY (tblLibrarian2id) REFERENCES tblLibrarian2(tblStaff2id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 15. Bảng tblReturnDetail2 (Chi tiết hóa đơn trả tài liệu)
CREATE TABLE tblReturnDetail2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    damageFine FLOAT NOT NULL DEFAULT 0,
    lateFine FLOAT NOT NULL DEFAULT 0,
    note VARCHAR(255),
    tblReturnInvoice2id INT NOT NULL,
    tblDocumentCopy2id INT NOT NULL,
    CONSTRAINT fk_returndetail_invoice FOREIGN KEY (tblReturnInvoice2id) REFERENCES tblReturnInvoice2(id) ON DELETE CASCADE,
    CONSTRAINT fk_returndetail_copy FOREIGN KEY (tblDocumentCopy2id) REFERENCES tblDocumentCopy2(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 16. Bảng tblPaymentSlip2 (Phiếu thanh toán tiền phạt)
CREATE TABLE tblPaymentSlip2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paymentDate DATE NOT NULL,
    tblReturnInvoice2id INT NOT NULL UNIQUE,
    CONSTRAINT fk_paymentslip_invoice FOREIGN KEY (tblReturnInvoice2id) REFERENCES tblReturnInvoice2(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================================================
-- DỮ LIỆU MẪU (SAMPLE DATA) PHỤC VỤ KIỂM THỬ MODULE 1 & MODULE 2
-- =============================================================================

-- 1. Người dùng: 1 Librarian, 1 Manager, 2 Reader
INSERT INTO tblUser2 (id, username, password, fullName, dob, address, phone, email, role) VALUES
(1, 'librarian1', '123456', 'Lê Thị Thu Thủy', '1990-03-12', 'Hà Đông, Hà Nội', '0901112233', 'thuy.ltt@ptit.edu.vn', 'Librarian'),
(2, 'manager1',   '123456', 'Phạm Quốc Hùng',  '1985-08-20', 'Cầu Giấy, Hà Nội', '0902223344', 'hung.pq@ptit.edu.vn', 'Manager'),
(3, 'reader1',    '123456', 'Nguyễn Văn An',   '2003-05-15', 'Thanh Xuân, Hà Nội', '0912345678', 'annv.b21dccn001@stu.ptit.edu.vn', 'Reader'),
(4, 'reader2',    '123456', 'Trần Thị Bình',   '2004-10-22', 'Đống Đa, Hà Nội', '0987654321', 'binhtt.b22dccn002@stu.ptit.edu.vn', 'Reader');

INSERT INTO tblStaff2 (tblUser2id, position) VALUES
(1, 'Librarian'),
(2, 'Manager');

INSERT INTO tblLibrarian2 (tblStaff2id) VALUES (1);
INSERT INTO tblManager2 (tblStaff2id) VALUES (2);

INSERT INTO tblReader2 (tblUser2id, readerCode) VALUES
(3, 'SV001'),
(4, 'SV002');

INSERT INTO tblReaderCard2 (id, cardCode, issueDate, expiryDate, status, tblReader2id) VALUES
(1, 'CARD001', '2024-09-01', '2028-09-01', 'Active', 3),
(2, 'CARD002', '2024-09-01', '2028-09-01', 'Active', 4);

-- 2. Nhà cung cấp & Tài liệu
INSERT INTO tblSupplier2 (id, name, address, phone, email) VALUES
(1, 'NXB Thông tin và Truyền thông', 'Trần Duy Hưng, Hà Nội', '02435772145', 'contact@nxbtttt.vn');

INSERT INTO tblDocument2 (id, name, author, publisher, category) VALUES
(1, 'Phân tích thiết kế đảm bảo chất lượng phần mềm', 'TS. Nguyễn Mạnh Hùng, TS. Đỗ Thị Bích Ngọc', 'Học viện Công nghệ BCVT', 'Giáo trình'),
(2, 'Nhập môn Công nghệ phần mềm', 'TS. Nguyễn Mạnh Hùng', 'Học viện Công nghệ BCVT', 'Giáo trình'),
(3, 'Cơ sở dữ liệu phân tán', 'PGS.TS. Hoàng Xuân Dậu', 'NXB Thông tin và Truyền thông', 'Sách chuyên khảo'),
(4, 'Lập trình hướng đối tượng với Java', 'Bộ môn CNPM - PTIT', 'Học viện Công nghệ BCVT', 'Giáo trình');

INSERT INTO tblDocumentCopy2 (id, barcode, `condition`, status, tblDocument2id) VALUES
(1, 'BC-CNPM-001', 'Mới 100%', 'Borrowed', 1),
(2, 'BC-CNPM-002', 'Tốt 95%',  'Borrowed', 2),
(3, 'BC-CSDL-001', 'Tốt 90%',  'Borrowed', 3),
(4, 'BC-JAVA-001', 'Mới 100%', 'Borrowed', 4),
(5, 'BC-CNPM-003', 'Mới 100%', 'Borrowed', 1),
(6, 'BC-JAVA-002', 'Mới 100%', 'Available', 4);

-- 3. Phiếu mượn của CARD001 (Nguyễn Văn An - SV001):
--    + Phiếu #1: Đã quá hạn 10 ngày (để kiểm thử tính phạt quá hạn tự động)
--    + Phiếu #2: Vẫn còn trong hạn trả
INSERT INTO tblBorrowRecord2 (id, borrowDate, returnDue, status, tblReaderCard2id, tblLibrarian2id) VALUES
(1, DATE_SUB(CURDATE(), INTERVAL 24 DAY), DATE_SUB(CURDATE(), INTERVAL 10 DAY), 'Borrowing', 1, 1),
(2, DATE_SUB(CURDATE(), INTERVAL 5 DAY),  DATE_ADD(CURDATE(), INTERVAL 9 DAY),  'Borrowing', 1, 1),
(3, DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 6 DAY),  'Borrowing', 2, 1);

INSERT INTO tblBorrowDetail2 (id, note, status, tblBorrowRecord2id, tblDocumentCopy2id) VALUES
(1, 'Mượn đọc tại nhà', 'Borrowing', 1, 1),
(2, 'Mượn làm bài tập lớn', 'Borrowing', 1, 2),
(3, 'Mượn tham khảo', 'Borrowing', 2, 3),
(4, 'Mượn ôn thi', 'Borrowing', 3, 4),
(5, 'Mượn đồ án', 'Borrowing', 3, 5);
