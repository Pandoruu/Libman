package model;

import java.sql.Date;

public class Staff2 extends User2 {
    private String position;

    public Staff2() {
        super();
    }

    public Staff2(String username, String password, String fullName, Date dob, String address, String phone, String email, String role, String position) {
        super(username, password, fullName, dob, address, phone, email, role);
        this.position = position;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
