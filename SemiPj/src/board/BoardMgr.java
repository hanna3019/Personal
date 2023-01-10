package board;

import DB.*;
import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import org.apache.catalina.util.ResourceSet;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardMgr {
	private static DBConnectionMgr pool;
	private static final String SAVEFOLDER = "D:\\JSP_workspace\\semi\\src\\board\\fileupload";
	private static final String ENCTYPE="UTF-8";
	private static final int MAXSIZE = 5*1024*1024;
	
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public void sample() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql =null;
		ResultSet rs =null;
		
		try {
			con = pool.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	public void insertBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql =null;
		MultipartRequest multi =null;
		int filesize = 0;
		String filename = null;
		
		
		try {
			con = pool.getConnection();
			File file = new File(SAVEFOLDER);
			if(!file.exists())
				file.mkdir();
			
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, 
					new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			
			sql = "INSERT INTO board VALUES(SEQ_BOARD.NEXTVAL,?,?,?,0,SEQ_BOARD.CURRVAL,0,SYSDATE,?,?,0,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, multi.getParameter("subject"));
			pstmt.setString(3, multi.getParameter("content"));
			pstmt.setString(4, multi.getParameter("pass"));
			pstmt.setString(5, multi.getParameter("ip"));
			pstmt.setString(6, filename);
			pstmt.setInt(7, filesize);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs=null;
		int totalCount = 0;
		
		try {
			con = pool.getConnection();
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "SELECT COUNT(*) FROM board";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "SELECT COUNT(*) FROM board WHERE " + keyField + " like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			
			rs = pstmt.executeQuery();
			if(rs.next())
				totalCount = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	public ArrayList<BoardBean> getBoardList(String keyField, String keyWord, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs=null;
		ArrayList<BoardBean> alist = new ArrayList<BoardBean>();
		
		try {
			con = pool.getConnection();
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "SELECT BT2.* FROM (SELECT ROWNUM R1, BT1.* "
						+ "FROM (SELECT * FROM board ORDER BY ref DESC, pos)BT1)BT2 "
						+ "WHERE R1 >= ? AND R1 <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);				
			} else {
				sql = "SELECT BT2.* FROM (SELECT ROWNUM R1, BT1.* "
						+ "FROM (SELECT * FROM board ORDER BY ref DESC, pos)BT1 WHERE "
						+keyField+" like ?)BT2 WHERE R1 >= ? AND R1 <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setSubject(rs.getString("subject"));
				bean.setName(rs.getString("name"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				alist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	
	public void upCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "UPDATE board	SET count = count+1 WHERE NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public BoardBean getBoard(int num){ // 내가 선택한 것만 보는 거라서 arraylist로 하지 않아도 됨
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		BoardBean bean = new BoardBean();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM BOARD WHERE NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setSubject(rs.getString(3));
				bean.setContent(rs.getString(4));
				bean.setPos(rs.getInt(5));
				bean.setRef(rs.getInt(6));
				bean.setDepth(rs.getInt(7));
				bean.setRegdate(rs.getString(8));
				bean.setPass(rs.getString(9));
				bean.setIp(rs.getString(10));
				bean.setCount(rs.getInt(11));
				bean.setFilename(rs.getString(12));
				bean.setFilesize(rs.getInt(13));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 이거 외우는 사람 없음. 하나의 형식이라 파일 다운로드 해야 할 땐 이거 전체 가져다가 사용
	public void downLoad(HttpServletRequest request, HttpServletResponse response, JspWriter out, PageContext pageContext) {
		try { // file은 try~catch문 해 줘야 함.
			String filename = request.getParameter("filename");
			File file = new File(UtilMgr.con(SAVEFOLDER+File.separator+filename)); 
			// con메서드로 파일이 저장된 위치 알려주기
			byte b[] = new byte[(int)file.length()]; 
			// 다운로드는 기존 파일을 모두 읽어서 내 컴퓨터에 그대로 붙여넣기 하는 것. 그래서 배열로 가져온다
			response.setHeader("Accept-Ranges", "bytes"); 
			// 다운로드 받는 유저에게 돌려줄 때 이어받기 가능하게 함
			String strClient = request.getHeader("User-Agent"); 
			// 유저가 접속하는 버전 알려 줌
			if(strClient.indexOf("MSIE6.0") != -1){	
				response.setContentType("application/smnet; charset=UTF-8"); 
				// 토씨하나 틀리지 않고 입력~
				response.setHeader("Content-Disposition", "filename=" + filename + ";");
			} else {
				response.setContentType("application/smnet; charset=UTF-8"); 
				// 토씨하나 틀리지 않고 입력~
				response.setHeader("Content-Disposition", "attachment;filename=" + filename + ";");
				// 예전 버전은 파일만 넣어주면 되지만 6버전 이상은 attachment로 set해줘야 함. 파일 자체를 부착해서 넘겨주는 것
			}
			out.clear();
			out = pageContext.pushBody();
			if(file.isFile()) {
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
				int read = 0;
				while((read= fin.read(b)) != -1) {
					outs.write(b, 0, read);
				}
				outs.close();
				fin.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateBoard(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "UPDATE BOARD SET NAME=?, SUBJECT=?, CONTENT=? WHERE NUM=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public boolean deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM BOARD WHERE REF=?";
			// ref는 부모의 num과 같음
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				int result = rs.getInt(1);
				if(result == 1) { // 댓글이 있는 경우 result가 0 → flag false 되고 게시글 삭제 못 함
					flag = true;
					sql = "SELECT FILENAME FROM BOARD WHERE NUM=?"; 
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					if(rs.next() && rs.getString(1) != null) { // 파일이름이 있는 경우 파일 삭제
						File file = new File(SAVEFOLDER + "/" + rs.getString(1)); // 경로명 / 파일명
						if(file.exists())
							UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
					}
					sql = "DELETE FROM BOARD WHERE NUM=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
}
