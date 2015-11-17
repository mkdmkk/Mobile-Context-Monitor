package mcm.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnector {
	public static Connection connectMysql(String db) {
		Connection conn = null;
		String url = "jdbc:mysql://127.0.0.1:3306/"+db;
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, "root", "0000");
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return conn;
	}

	public static void close(Connection conn) {
		try {
			if(conn != null) conn.close();
		} catch(Throwable e) {
			System.out.println();
		} finally {
			try {
				if(conn != null) conn.close();
			} catch(Exception e) {
				System.out.println(e.toString());
			}
		}
	}

	public static void close(Connection conn, PreparedStatement pstmt) {
		try {
			if(pstmt !=null) pstmt.close();
			if(conn !=null) conn.close();
		} catch(Throwable e) {
			System.out.println(e.toString());
		} finally {
			try {
				if(pstmt != null) pstmt.close(); 
				if(conn != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
	}

	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(rs != null ) rs.close();  
			if(pstmt !=null) pstmt.close();
			if(conn !=null) conn.close();
		} catch(Throwable e) {
			System.out.println(e.toString());
		} finally {
			try {
				if(rs != null) rs.close();   
				if(pstmt != null) pstmt.close(); 
				if(conn != null) conn.close();  
			} catch ( Exception e ) {
			}
		}
	}
}
