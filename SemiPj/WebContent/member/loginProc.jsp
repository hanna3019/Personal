<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="member.*, java.util.*" %>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	boolean result = mMgr.loginMember(id, pw);
	
	MemberBean bean = new MemberBean();
	
	String msg = "로그인에 실패했어요😢";
	String url = "login.jsp";
	
	if(result){
		bean = mMgr.getInfo(id, pw);		
		session.setAttribute("idKey1", bean);
		msg = "로그인 성공!😃";
		url = "../index.jsp";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	alert("<%=msg %>");
	location.href = "<%=url %>";
</script>
</body>
</html>