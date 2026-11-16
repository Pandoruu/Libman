package model;

import java.sql.Date;

public class Reader2 extends User2 {
    private String readerCode;

    public Reader2() {
        super();
    }

    public Reader2(String username, String password, String fullName, Date dob, String address, String phone, String email, String readerCode) {
        super(username, password, fullName, dob, address, phone, email, "reader");
        this.readerCode = readerCode;
    }

    public String getReaderCode() {
        return readerCode;
    }

    public void setReaderCode(String readerCode) {
        this.readerCode = readerCode;
    }
}
