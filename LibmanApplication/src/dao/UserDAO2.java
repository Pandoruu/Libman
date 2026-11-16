package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User2;

public class UserDAO2 extends DAO2 {

    public UserDAO2() {
        super();
    }

    public boolean checkLogin(User2 user) {
        boolean result = false;
        if (user == null || con == null) {
            return false;
        }
        String sql = "SELECT id, username, fullName, dob, address, phone, email, role "
                   + "FROM tblUser2 WHERE username = ? AND password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("fullName"));
                user.setDob(rs.getDate("dob"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                result = true;
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
