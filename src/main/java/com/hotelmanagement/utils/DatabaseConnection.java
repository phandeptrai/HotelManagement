package com.hotelmanagement.utils;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DatabaseConnection {


    private static DatabaseConnection instance;

    private HikariDataSource dataSource;


    private DatabaseConnection() {
        try {
            HikariConfig config = new HikariConfig("/dbConfig.properties");
            dataSource = new HikariDataSource(config);
        } catch (Exception ex) {
            throw new RuntimeException("Error initializing HikariCP: " + ex.getMessage(), ex);
        }
    }


    public static synchronized DatabaseConnection getInstance() {
        if (instance == null) {
            instance = new DatabaseConnection();
        }
        return instance;
    }


    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

public static void main(String[] args) throws SQLException {
	System.out.println(DatabaseConnection.getInstance().getConnection());
}

}








