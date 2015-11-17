package mcm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import mcm.db.DBConnector;
import mcm.dto.MemberDTO;

public class MemberDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private int resCnt = 0;
	private String sql = "";

	public MemberDTO signUp(MemberDTO memberDTO) {
		conn = DBConnector.connectMysql("mcm");
		if(isPresent(conn, memberDTO.getEmail())) {
			DBConnector.close(conn);
			return null;
		}
		sql = "INSERT INTO member(email, pw, name, auth) VALUES(?, ?, ?, 0)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getEmail());
			pstmt.setString(2, memberDTO.getPw());
			pstmt.setString(3, memberDTO.getName());
			resCnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				DBConnector.close(conn, pstmt);
			} catch (Exception e) { 
				e.printStackTrace(); 
			}
		}
		if(resCnt > 0) return signIn(memberDTO.getEmail());
		else return null;
	}

	public MemberDTO signIn(String email) {
		conn = DBConnector.connectMysql("mcm");
		sql = "SELECT * FROM member WHERE email=?";
		MemberDTO memberDTO = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memberDTO = new MemberDTO();
				memberDTO.setId(rs.getInt("id"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setPw(rs.getString("pw"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setAuth(rs.getInt("auth"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DBConnector.close(conn, pstmt, rs);
			} catch (Exception e) { 
				e.printStackTrace(); 
			}
		}
		return memberDTO;
	}
	
	public MemberDTO signIn(String email, String pw) {
		conn = DBConnector.connectMysql("mcm");
		sql = "SELECT * FROM member WHERE email=?";
		MemberDTO memberDTO = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memberDTO = new MemberDTO();
				memberDTO.setId(rs.getInt("id"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setPw(rs.getString("pw"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setAuth(rs.getInt("auth"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				DBConnector.close(conn, pstmt, rs);
			} catch (Exception e) { 
				e.printStackTrace(); 
			}
		}
		return memberDTO;
	}

	public boolean isPresent(Connection conn, String email) {
		sql = "SELECT * FROM member WHERE email=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			if(rs.next()) return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
