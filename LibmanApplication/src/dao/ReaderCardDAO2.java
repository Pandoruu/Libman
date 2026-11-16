package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.Reader2;
import model.ReaderCard2;

public class ReaderCardDAO2 extends DAO2 {

    public ReaderCardDAO2() {
        super();
    }

    /**
     * Module 1: Bạn đọc đăng ký thẻ bạn đọc trực tuyến.
     * Lưu thông tin bạn đọc (tblUser2, tblReader2) và thẻ bạn đọc (tblReaderCard2)
     * trong cùng một giao dịch (Transaction).
     */
    public boolean registerReaderCard(ReaderCard2 card) {
        if (card == null || card.getReader() == null || con == null) {
            return false;
        }
        boolean result = false;
        Reader2 reader = card.getReader();

        String sqlCheckCard = "SELECT id FROM tblReaderCard2 WHERE cardCode = ?";
        String sqlCheckReaderCode = "SELECT tblUser2id FROM tblReader2 WHERE readerCode = ? AND tblUser2id <> ?";
        String sqlInsertUser = "INSERT INTO tblUser2(username, password, fullName, dob, address, phone, email, role) "
                             + "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        String sqlUpdateUser = "UPDATE tblUser2 SET fullName = ?, dob = ?, address = ?, phone = ?, email = ? WHERE id = ?";
        String sqlCheckExistingReader = "SELECT tblUser2id FROM tblReader2 WHERE tblUser2id = ?";
        String sqlInsertReader = "INSERT INTO tblReader2(tblUser2id, readerCode) VALUES(?, ?)";
        String sqlUpdateReader = "UPDATE tblReader2 SET readerCode = ? WHERE tblUser2id = ?";
        String sqlInsertCard = "INSERT INTO tblReaderCard2(cardCode, issueDate, expiryDate, status, tblReader2id) "
                             + "VALUES(?, ?, ?, ?, ?)";

        try {
            con.setAutoCommit(false);

            // 1. Kiểm tra trùng mã thẻ
            PreparedStatement psCheckCard = con.prepareStatement(sqlCheckCard);
            psCheckCard.setString(1, card.getCardCode());
            ResultSet rsCard = psCheckCard.executeQuery();
            if (rsCard.next()) {
                rsCard.close();
                psCheckCard.close();
                con.rollback();
                return false;
            }
            rsCard.close();
            psCheckCard.close();

            // 2. Kiểm tra trùng mã bạn đọc
            PreparedStatement psCheckReader = con.prepareStatement(sqlCheckReaderCode);
            psCheckReader.setString(1, reader.getReaderCode());
            psCheckReader.setInt(2, reader.getId());
            ResultSet rsReaderCode = psCheckReader.executeQuery();
            if (rsReaderCode.next()) {
                rsReaderCode.close();
                psCheckReader.close();
                con.rollback();
                return false;
            }
            rsReaderCode.close();
            psCheckReader.close();

            // 3. Lưu hoặc cập nhật thông tin tblUser2 & tblReader2
            int userId = reader.getId();
            if (userId <= 0) {
                PreparedStatement psUser = con.prepareStatement(sqlInsertUser, Statement.RETURN_GENERATED_KEYS);
                String username = (reader.getUsername() != null && !reader.getUsername().trim().isEmpty())
                        ? reader.getUsername().trim()
                        : reader.getReaderCode();
                String password = (reader.getPassword() != null && !reader.getPassword().trim().isEmpty())
                        ? reader.getPassword()
                        : "123456";
                psUser.setString(1, username);
                psUser.setString(2, password);
                psUser.setString(3, reader.getFullName());
                psUser.setDate(4, reader.getDob() != null ? new Date(reader.getDob().getTime()) : null);
                psUser.setString(5, reader.getAddress());
                psUser.setString(6, reader.getPhone());
                psUser.setString(7, reader.getEmail());
                psUser.setString(8, "Reader");
                psUser.executeUpdate();

                ResultSet rsKeys = psUser.getGeneratedKeys();
                if (rsKeys.next()) {
                    userId = rsKeys.getInt(1);
                    reader.setId(userId);
                }
                rsKeys.close();
                psUser.close();

                PreparedStatement psReader = con.prepareStatement(sqlInsertReader);
                psReader.setInt(1, userId);
                psReader.setString(2, reader.getReaderCode());
                psReader.executeUpdate();
                psReader.close();
            } else {
                PreparedStatement psUser = con.prepareStatement(sqlUpdateUser);
                psUser.setString(1, reader.getFullName());
                psUser.setDate(2, reader.getDob() != null ? new Date(reader.getDob().getTime()) : null);
                psUser.setString(3, reader.getAddress());
                psUser.setString(4, reader.getPhone());
                psUser.setString(5, reader.getEmail());
                psUser.setInt(6, userId);
                psUser.executeUpdate();
                psUser.close();

                PreparedStatement psExist = con.prepareStatement(sqlCheckExistingReader);
                psExist.setInt(1, userId);
                ResultSet rsExist = psExist.executeQuery();
                boolean existsInReader = rsExist.next();
                rsExist.close();
                psExist.close();

                if (existsInReader) {
                    PreparedStatement psUpdReader = con.prepareStatement(sqlUpdateReader);
                    psUpdReader.setString(1, reader.getReaderCode());
                    psUpdReader.setInt(2, userId);
                    psUpdReader.executeUpdate();
                    psUpdReader.close();
                } else {
                    PreparedStatement psInsReader = con.prepareStatement(sqlInsertReader);
                    psInsReader.setInt(1, userId);
                    psInsReader.setString(2, reader.getReaderCode());
                    psInsReader.executeUpdate();
                    psInsReader.close();
                }
            }

            // 4. Lưu thông tin thẻ bạn đọc vào tblReaderCard2
            PreparedStatement psCard = con.prepareStatement(sqlInsertCard, Statement.RETURN_GENERATED_KEYS);
            psCard.setString(1, card.getCardCode());
            psCard.setDate(2, card.getIssueDate() != null ? new Date(card.getIssueDate().getTime()) : new Date(System.currentTimeMillis()));
            psCard.setDate(3, card.getExpiryDate() != null ? new Date(card.getExpiryDate().getTime()) : null);
            psCard.setString(4, card.getStatus() != null ? card.getStatus() : "Active");
            psCard.setInt(5, userId);
            psCard.executeUpdate();

            ResultSet rsCardKeys = psCard.getGeneratedKeys();
            if (rsCardKeys.next()) {
                card.setId(rsCardKeys.getInt(1));
            }
            rsCardKeys.close();
            psCard.close();

            con.commit();
            result = true;
        } catch (Exception e) {
            try {
                con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            result = false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

    /**
     * Module 2: Tìm kiếm thẻ bạn đọc theo mã thẻ (cardCode) hoặc mã bạn đọc (readerCode).
     */
    public ReaderCard2 findReaderCard(String keyword) {
        ReaderCard2 card = null;
        if (keyword == null || keyword.trim().isEmpty() || con == null) {
            return null;
        }
        String sql = "SELECT rc.id AS cardId, rc.cardCode, rc.issueDate, rc.expiryDate, rc.status AS cardStatus, "
                   + "r.readerCode, u.id AS userId, u.username, u.fullName, u.dob, u.address, u.phone, u.email, u.role "
                   + "FROM tblReaderCard2 rc "
                   + "INNER JOIN tblReader2 r ON rc.tblReader2id = r.tblUser2id "
                   + "INNER JOIN tblUser2 u ON r.tblUser2id = u.id "
                   + "WHERE rc.cardCode = ? OR r.readerCode = ? "
                   + "ORDER BY rc.id DESC LIMIT 1";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, keyword.trim());
            ps.setString(2, keyword.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Reader2 reader = new Reader2();
                reader.setId(rs.getInt("userId"));
                reader.setUsername(rs.getString("username"));
                reader.setFullName(rs.getString("fullName"));
                reader.setDob(rs.getDate("dob"));
                reader.setAddress(rs.getString("address"));
                reader.setPhone(rs.getString("phone"));
                reader.setEmail(rs.getString("email"));
                reader.setRole(rs.getString("role"));
                reader.setReaderCode(rs.getString("readerCode"));

                card = new ReaderCard2();
                card.setId(rs.getInt("cardId"));
                card.setCardCode(rs.getString("cardCode"));
                card.setIssueDate(rs.getDate("issueDate"));
                card.setExpiryDate(rs.getDate("expiryDate"));
                card.setStatus(rs.getString("cardStatus"));
                card.setReader(reader);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return card;
    }
}
