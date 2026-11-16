package model;

import java.sql.Date;

public class Librarian2 extends Staff2 {
    public Librarian2() {
        super();
    }

    public Librarian2(String username, String password, String fullName, Date dob, String address, String phone, String email, String position) {
        super(username, password, fullName, dob, address, phone, email, "librarian", position);
    }
}
