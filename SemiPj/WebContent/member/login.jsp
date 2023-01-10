<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.2.min.js" integrity="sha256-2krYZKh//PcchRtd+H+VyyQoZ/e3EcrkxhM8ycwASPA=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../resource/css/login.css">
<title>BearMoon</title>
</head>
<body>
	<div class="container">
	    <header>
	     <div class="welcome">
        <% if(id!=null){ %>
        🍩<%=id %>님, 환영합니다!🍩
        <% } else { %>
        	새로운 손님이네요. 어서오세요!
        	<% } %>
        </div>
	        <nav>
	            <div class="nav1">
	                <ul>
	                    <li><a href="#">Brand</a></li>
	                    <li><a href="#">Product</a></li>
	                    <li><a href="#">Notice</a></li>
	                </ul>
	            </div>
	            <div class="logo">
	                <a href="../index.jsp"><img src="../resource/img/logo.jpeg" alt="logo"></a>
	            </div>
	            <div class="nav2">
	                <ul>                    
                    <% if(id==null) { %>
						<li><a href="../member/login.jsp">Login</a></li>
                    <% } else {  %>
                    	<li><a href="../member/logout.jsp">Logout</a></li>
                    	<li><a href="#">MyPage</a></li>
                    <% } %>                                            
                    </ul>
	            </div>
	        </nav>
	    </header>
	    <main>
	        <div class="donut1">
	            <img src="../resource/img/donut8_2.png" alt="">
	        </div>
	        <!--donut1-->
	        <div class="form">
	            <form action="loginProc.jsp" method="post" name="loginfrm">
	                <div>
	                    <h1>로그인</h1>
	                </div>
	                <div class="input">
	                    <input type="text" id="id" name="id" placeholder="아이디"><br>
	                    <input type="password" id="pw" name="pw" placeholder="비밀번호">
	                </div>
	
	                <div class="find">
	                    <a href="#">아이디찾기</a> &nbsp; | &nbsp;
	                    <a href="#">비밀번호찾기</a>
	                </div>
	                <div class="btns">
	                    <input type="submit" value="로그인" id="btn1"><br>
	                    <input type="button" value="회원가입" id="btn2" onclick="location.href='member.jsp'">
	                </div>
	            </form>
	        </div>
	        <!--form-->
	        <div class="donut2">
	            <img src="../resource/img/donut8_1.png" alt="">
	        </div>
	        <!--donut2-->
	    </main>
	    <footer>
            <div>
                <a href="#">개인정보처리방침</a>
                <a href="#">1:1문의</a>
                <a href="#">자주묻는질문</a>
                <a href="#">이용약관</a>
            </div>
            <div>
                주소: 서울특별시 금천구 벚꽃로 도넛빌딩 | 사업자등록번호: 123-45-67890 | TEL: 02-111-222
            </div>
            <div>
                Copyright &copy; 2022 BearMoon Doughnuts. All Rights Reserved.
            </div>
        </footer>
    </div>
</body>
</html>