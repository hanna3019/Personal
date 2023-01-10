<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<form method="post" name="postFrm" action="boardPost" enctype="multipart/form-data">
		<table align="center" border="1" width="800">
			<tr>
				<th colspan="2" align="center">글쓰기</th>
			</tr>
			<tr>
				<td>성명</td>
				<td align="left"><input name="name" required></td>
			</tr>
			<tr>
				<td>제목</td>
				<td align="left"><input name="subject" size="48" required></td>
			</tr>
			<tr>
				<td>내용</td>
				<td align="left"><textarea name="content" rows="10" cols="60" required></textarea></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td align="left"><input type="password" name="pass" required>수정 시 비밀번호가 필요합니다</td>
			</tr>
			<tr>
				<td>파일첨부</td>
				<td align="left"><input type="file" name="filename"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="등록">&emsp;
					<input type="reset" value="다시쓰기">&emsp;
					<input type="button" value="리스트" onClick="location.href='list.jsp'">
				</td>	
			</tr>
		</table>
		<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>">
	</form>
</body>
</html>
