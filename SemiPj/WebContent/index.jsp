<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.*, java.util.*" %>
<%  
MemberBean bean = new MemberBean();
String id = null;
Enumeration<String> e = session.getAttributeNames();
while(e.hasMoreElements()){
   if(e.nextElement().equals("idKey1")){
	   bean=(MemberBean)session.getAttribute("idKey1");
      id= bean.getId();  
   }
}
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"/>
<script src="https://code.jquery.com/jquery-3.6.2.min.js" integrity="sha256-2krYZKh//PcchRtd+H+VyyQoZ/e3EcrkxhM8ycwASPA=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>
<link rel="stylesheet" href="resource/css/home.css">
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
                    <a href="index.jsp"><img src="resource/img/logo.jpeg" alt="logo"></a>
                </div>
                <div class="nav2">
                    <ul>                    
                    <% if(id==null) { %>
						<li><a href="member/login.jsp">Login</a></li>
                    <% } else {  %>
                    	<li><a href="member/logout.jsp">Logout</a></li>
                    	<li><a href="#">MyPage</a></li>
                    <% } %>                                            
                    </ul>
                </div>
            </nav>
        </header>
        <main>
             <!-- Swiper -->
		    <div class="swiper mySwiper slider">
		      <div class="swiper-wrapper">
		        <div class="swiper-slide"><img src="resource/img/banner1.jpg" alt=""></div>
		        <div class="swiper-slide"><img src="resource/img/banner2.jpeg" alt=""></div>
		        <div class="swiper-slide"><img src="resource/img/banner3.jpg" alt=""></div>
		        <div class="swiper-slide"><img src="resource/img/banner4.jpeg" alt=""></div>
		        <div class="swiper-slide"><img src="resource/img/banner5.jpg" alt=""></div>
		      	<div class="swiper-slide"><img src="resource/img/banner6.jpeg" alt=""></div>
		      </div>
		      <div class="swiper-button-next" style="color:white"></div>
		      <div class="swiper-button-prev" style="color:white"></div>
		      <div class="swiper-pagination"></div>
		    </div>
		    <!-- Swiper JS -->
		    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
		    <!-- Initialize Swiper -->
		    <script>
		      var swiper = new Swiper(".mySwiper", {
		        spaceBetween: 30,
		        centeredSlides: true,
		        autoplay: {
		          delay: 2500,
		          disableOnInteraction: false,
		        },
		        pagination: {
		          el: ".swiper-pagination",
		          clickable: true,
		        },
		        navigation: {
		          nextEl: ".swiper-button-next",
		          prevEl: ".swiper-button-prev",
		        },
		      });
		    </script>
            <section class="new">
                <div class="newtitle">
                    <h3 id="whatsnew">What's new? <span> &nbsp; | &nbsp; 베어문 신제품</span></h4>
                </div>
                <div class="newimg">
                    <div class="newimg1">
                        <p id="info1">민트초코도넛<br>3,500</p>
                        <img src="resource/img/3.jpeg" alt="">
                    </div>
                    <div class="newimg2">
                        <p id="info2">딸기 크루아상<br>4,500</p>
                        <img src="resource/img/9.jpeg" alt="">
                    </div>
                    <div class="newimg3">
                        <p id="info3">브라운베어<br>16,000</p>
                        <img src="resource/img/4.jpeg" alt="">
                    </div>
                    <div class="newimg4">
                        <p id="info4">해피 버니 케이크<br>18,000</p>
                        <img src="resource/img/19.jpeg" alt="">
                    </div>
                </div> <!-- newimg -->
                <div class="seemoremenu">
                	<input type="button" onclick="#" value="See more ▷▷">
                </div>
            </section>
            <section class="sns">
                <div class="snstitle">
                    <h3 id="bearmoonsns">BearMoon & SNS <span> &nbsp; | &nbsp; 베어문과 SNS</span></h4>
                </div>
                <div class="snsimg">
                    <a href="#"><img src="resource/img/instagram.svg" alt="instagram"></a>
                    <a href="#"><img src="resource/img/facebook.svg" alt="facebook"></a>
                    <a href=""><img src="resource/img/youtube.svg" alt="youtube"></a>
                    <a href=""><img src="resource/img/twitter.svg" alt="twitter"></a>
                </div>
            </section>
        </main>
        <hr>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>