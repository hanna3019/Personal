<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardBean"%> 
<jsp:useBean id="bMgr" class="board.BoardMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{background-color: lightgray; margin-top: 50px}
th{background-color: black; color: white;}
</style>
<%
	request.setCharacterEncoding("UTF-8");
	boolean result;
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	if(request.getParameter("pass") != null){ // 경우1. 패스워드를 넣고 수정완료를 눌렀을 때
		String inPass = request.getParameter("pass"); // 이 페이지에서 입력한 비밀번호
		BoardBean bean = (BoardBean)session.getAttribute("bean");
		String dbPass = bean.getPass(); // 세션에 들어있는 비밀번호
		if(inPass.equals(dbPass)){
			result = bMgr.deleteBoard(num);
			if(result){ // 삭제가 잘 된 경우
				String url = "list.jsp?nowPage=" + nowPage;
				response.sendRedirect(url);
			}else{ // 댓글이 있어서 삭제가 안 될 경우
			%>
				<script>
					alert("답변이 있는 게시글은 삭제할 수 없습니다")
					history.go(-2);
				</script>
			<%	
			}
		} else { // 비밀번호가 틀렸을 때
		%>
			<script>
				alert("비밀번호가 맞지 않습니다");
				history.go(-1);
			</script>
		<%	
		}
	} else { // 경우2. 패스워드가 안 들어왔을 때
%>
</head>
<body align="center">
	<form method="post" name="delFrm" action="delete.jsp">
		<table width="800px" align="center" border="0">
			<tr>
				<th>사용자의 비밀번호를 입력 해 주세요</th>
			</tr>
			<tr>
				<td><input type="password" name="pass" required></td>
			</tr>
			<tr>
				<td><hr></td>
			</tr>
			<tr>
				<td align="center">
					<input type="submit" value="삭제완료">&emsp;
					<input type="button" value="뒤로" onClick="history.go(-1);">
				</td>
			</tr>
		</table>
		<input type="hidden" name="num" value="<%=num %>">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
	</form>
<%	
}
%>
</body>
</html>
