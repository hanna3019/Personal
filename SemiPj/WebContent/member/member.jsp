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
<title>BearMoon</title>
<script src="https://code.jquery.com/jquery-3.6.2.min.js" integrity="sha256-2krYZKh//PcchRtd+H+VyyQoZ/e3EcrkxhM8ycwASPA=" crossorigin="anonymous"></script>
<script type="text/javascript" src="../resource/js/member.js" charset="utf-8"></script>
<link rel="stylesheet" href="../resource/css/member.css">
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
            <div class="con1">
                <img src="../resource/img/donut6.jpeg" alt="">
            </div>
            <div class="con2">
                <h1>회원가입</h1>
                <div class="form">
                    <form action="memberProc.jsp" method="post" name="regFrm">
                        <table>
                            <tr>
                                <th><label for="id">아이디</label></th>
                                <td><input name="id" placeholder="15자 이내 영소문자 또는 숫자" onkeydown="inputIdChk();"></td>
                                <td><input type="button" onclick="idCheck(this.form.id.value);" class="idbtncheck" value="ID중복확인">
                                	<input type="hidden" name="idbtncheck" value="idUncheck"></td>
                            </tr>
                            <tr>
                                <th><label for="pw">비밀번호</label></th>
                                <td><input type="password" id="pw" name="pw" placeholder="15자 이내 영소문자 또는 숫자"></td>
                            </tr>
                            <tr>
                                <th><label for="cpw">비밀번호 확인</label></th>
                                <td><input type="password" id="cpw" name="cpw" placeholder="비밀번호 재입력"></td>
                            </tr>
                            <tr>
                                <th><label for="email">이메일</label></th>
                                <td><input type="email" id="email" name="email" placeholder="moonbear@naver.com"></td>
                            </tr>
                            <tr>
                                <th><label for="phone">연락처</label></th>
                                <td><input type="tel" id="phone" name="phone" placeholder="010-1234-5678"></td>
                            </tr>
                        </table>
                        <input type="button" value="확인" onclick="signup();" class="btn1">&nbsp;&nbsp;&nbsp;
                        <input type="reset" class="btn2">
                    </form>
                </div>
                <!--form-->
            </div>
            <!--con2-->
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
    <!--container-->
</body>
</html>