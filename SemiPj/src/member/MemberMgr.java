package member;

import DB.*;
import java.sql.*;

public class MemberMgr {
	
	private DBConnectionMgr pool;
	
	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean loginMember(String id, String pw) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "SELECT ID FROM MEMBER WHERE ID=? AND PW=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id); // 첫 번째 물음표는 사용자가 넣은 id랑 맞는지 
			pstmt.setString(2, pw); // 두 번째 물음표는 사용자가 넣은 pw랑 맞는지
			rs = pstmt.executeQuery();
			flag = rs.next(); // 값이 있을 때 next하면 true, 없을 때는 false
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	 public boolean checkId(String id) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      boolean flag = false;

	      try {
	         con = pool.getConnection();
	         sql = "SELECT ID FROM MEMBER WHERE ID=?";// 아이디와 패스워드가 사용자가 넣어준 것들
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, id);
	         rs = pstmt.executeQuery();
	         flag = rs.next();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt, rs);
	      }
	      return flag;

	  }
	 
	 public boolean insertMember(MemberBean bean) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      String sql = null;
	      boolean flag = false;

	      try {
	         con = pool.getConnection();
	         sql = "INSERT INTO MEMBER VALUES(?,?,?,?)";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, bean.getId());
	         pstmt.setString(2, bean.getPw());
	         pstmt.setString(3, bean.getEmail());
	         pstmt.setString(4, bean.getPhone());
	         
	         if(pstmt.executeUpdate() == 1){ // 1이 들어왔으면 업뎃이 잘 된 것
	        	 flag = true;
	         }; 
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt);
	      }
	      return flag;
	  }
	 
	 public MemberBean getInfo(String id, String pw) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      String sql = null;
	      ResultSet rs = null;
	      MemberBean bean = new MemberBean();

	      try {
	         con = pool.getConnection();
	         sql = "SELECT * FROM MEMBER WHERE ID=? AND PW=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, id);
	         pstmt.setString(2, pw);
	         rs = pstmt.executeQuery();
	      
	         
	         while(rs.next()) {
	        	 bean.setId(rs.getString(1));
	        	 bean.setPw(rs.getString(2));
	        	 bean.setEmail(rs.getString(3));
	        	 bean.setPhone(rs.getString(4));
	        	 
	         }
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt);
	      }
		return bean;
	   
	  }
	 
}
	

