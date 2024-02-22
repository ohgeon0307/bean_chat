package app.dbconn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConn {
	/* 
	private String url ="jdbc:mysql://192.168.0.132:3306/beanchat?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
	
	private String user="root";
	private String password="1234"; */
	private String url ="jdbc:mysql://jjezen.cafe24.com:3307/aws0803_c?autoReconnect=true&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
	private String user="aws0803_c_user";
	private String password="user1234!!";
	
	public Connection getConnection() {
		Connection conn = null;
		
		try {
			Class clz = Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {			
			e.printStackTrace();
		}		
		
		return conn;
	}
	
	
	
	
	
	

}
