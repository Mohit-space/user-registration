package com.abhiyantriki.project1.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class connectionBean {
	String url = "jdbc:mysql://localhost:3306/test1";
	String username  = "root";
	String password = "mohit9522";
	
	String driver = "com.mysql.cj.jdbc.Driver";

	public Connection getConnectionobj() {
		Connection conn =null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,username,password);
			System.out.println("Connected");
			
			}
		catch(Exception e) {
			System.out.println("exception in connection" +e);
			try {
				if(conn != null) {
					conn.close();
				}
				}catch(SQLException se) {
		}
			System.out.println("Good buy connection!");
			e.printStackTrace();
		}
		return conn;

	} 
	public static void main (String []args ) {
		connectionBean bean = new connectionBean();
		bean.getConnectionobj();
		}
}
