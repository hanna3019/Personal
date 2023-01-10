package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/board/boardUpdate")
public class BoardUpdate extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		BoardMgr bMgr = new BoardMgr();
		// 기존에 들어있는 bean값 가져오기
		BoardBean bean = (BoardBean)session.getAttribute("bean");
		String nowPage = request.getParameter("nowPage");
		
		// 사용자로부터 새롭게 받은 값 bean에 넣기 > 둘의 비밀번호를 비교할 수 있다
		BoardBean upBean = new BoardBean();
		upBean.setNum(Integer.parseInt(request.getParameter("num")));
		upBean.setName(request.getParameter("name"));
		upBean.setSubject(request.getParameter("subject"));
		upBean.setContent(request.getParameter("content"));
		
		String inPass = bean.getPass(); // 기존에 갖고 있던 pw
		String upPass = request.getParameter("pass"); // 새로운 pw
		// 둘을 비교! 다르면 업뎃 불가
		if(inPass.equals(upPass)) {
			bMgr.updateBoard(upBean);
			response.sendRedirect("read.jsp?nowPage=" + nowPage + "&num=" + upBean.getNum()); 
			// 넘겨줘야 하는 값이 아까 request로 받은 nowPage. 띄어쓰기 들어가면 안 됨! / upbean이든 bean이든 상관없음
		} else {
			out.print("<script>");
			out.print("alert('비밀번호가 일치하지 않습니다');");
			out.print("history.back();");
			out.print("</script>");
		}
	}

}
