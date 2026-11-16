package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO2 {
    public static Connection con;

    public DAO2() {
        if (con == null) {
            String dbUrl = System.getProperty("LIBMAN_DB_URL",
                    "jdbc:mysql://localhost:3306/libman_db2?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8");
            String dbUser = System.getProperty("LIBMAN_DB_USER", "root");
            String dbPass = System.getProperty("LIBMAN_DB_PASS", "123456");

            try {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                } catch (ClassNotFoundException ex) {
                    Class.forName("com.mysql.jdbc.Driver");
                }
                con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
