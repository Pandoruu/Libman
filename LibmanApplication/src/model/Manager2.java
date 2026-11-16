package model;

import java.sql.Date;

public class Manager2 extends Staff2 {
    public Manager2() {
        super();
    }

    public Manager2(String username, String password, String fullName, Date dob, String address, String phone, String email, String position) {
        super(username, password, fullName, dob, address, phone, email, "manager", position);
    }
}
