<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardBean" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	BoardBean bean = (BoardBean)session.getAttribute("bean");
	String subject = bean.getSubject();
	String name = bean.getName();
	String content = bean.getContent();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{background-color: lightgray; margin-top: 50px}
th{background-color:black; color:white;}
</style>
</head>
<body align="center">
	<form method="post" name="updateFrm" action="boardUpdate"> <!-- enctype="multipart/form-data" -->
		<table align="center" border="1" width="800">
			<tr>
				<th colspan="2" align="center">글쓰기</th>
			</tr>
			<tr>
				<td>성명</td>
				<td align="left"><input name="name" value="<%=name %>" required></td>
			</tr>
			<tr>
				<td>제목</td>
				<td align="left"><input name="subject" size="48" value="<%=subject %>" required></td>
			</tr>
			<tr>
				<td>내용</td>
				<td align="left"><textarea name="content" rows="10" cols="60" required><%=content %></textarea></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td align="left"><input type="password" name="pass" required>수정 시 비밀번호가 필요합니다</td>
			</tr>
			<!-- <tr>
				<td>파일첨부</td>
				<td align="left"><input type="file" name="filename"></td>
			</tr> -->
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정완료">&emsp;
					<input type="reset" value="초기화">&emsp;
					<input type="button" value="뒤로" onClick="history.go(-1);">
				</td>	
			</tr>
		</table>
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
		<input type="hidden" name="num" value="<%=num %>">
	</form>
</body>
</html>
