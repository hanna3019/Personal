<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	boolean result = mMgr.checkId(id); // 값이 true or false로 들어오니까 boolean으로 설정
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resource/css/idCheck.css">
<title>Insert title here</title>
</head>
<body>
<%
	if(result){
		out.print("이미 존재하는 아이디예요😢<p/><br>");
	} else {
		out.print("사용가능한 아이디입니다😃<p/><br>");
	}
%>
	<button><a href="" onClick="self.close()">닫기</a></button>
</body>
</html>