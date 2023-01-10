<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.*, java.util.*"%>
<%@ page import = "member.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>   
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	int totalRecord = 0; // 전체 레코드 수
	int numPerPage = 10; // 1페이지 당 레코드 수
	int pagePerBlock = 5; // 블록 당 페이지 수 ex) [1][2][3][4][5]
	
	int totalPage = 0; // 전체 페이지 수  ex) 레코드 54개일 시 페이지 6개
	int totalBlock = 0; // 전체 블록 수 ex) 레코드 54개일 시 블록 2개

	int nowPage = 1; // 현재 페이지
	int nowBlock = 1; // 현재 해당하는 블록
	
	int start = 0;	// DB테이블의 SELECT 시작번호(해당 페이지의 시작과 끝 레코드 번호만 가져오기 위함)
	int end = 0;	// 10개씩 가져오기
	int listSize = 0; // 현재 읽어 온 게시물의 수
	
	String keyField = "", keyWord = "";
	ArrayList<BoardBean> alist = null;
	if(request.getParameter("keyWord") != null){
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	
	/* [처음으로] 누르면 하단 hidden을 reload */
	if(request.getParameter("reload")!=null){
		if(request.getParameter("reload").equals("true")){
			keyWord="";
			keyField="";
		}
	}
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage * numPerPage) - numPerPage + 1; // 각 페이지의 시작번호
	end = (nowPage * numPerPage); // 각 페이지의 끝번호
	totalRecord = bMgr.getTotalCount(keyField, keyWord); // 전체 레코드 수
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage); // 전체 페이지 수
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock); // 현재 블록
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock); // 전체 블록 수
%>
<script type="text/javascript">
	function read(num){
		readFrm.num.value = num;
		readFrm.action = "read.jsp";
		readFrm.submit();
	}
	function pageing(page){
		readFrm.nowPage.value = page;
		readFrm.submit();
	}
	function block(value){
		readFrm.nowPage.value = <%=pagePerBlock %> * (value-1)+1;
		readFrm.submit();
	}
	function list(){
		listFrm.aciton = "list.jsp";
		listFrm.submit();
	}
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.2.min.js" integrity="sha256-2krYZKh//PcchRtd+H+VyyQoZ/e3EcrkxhM8ycwASPA=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../resource/css/board.css">
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
			<h1 onClick="location.href='list.jsp'">브랜드 소식</h1>
			<h4>베어문의 새로운 소식을 알려드려요</h3>
				<table width="800px" align="center" border="0" style="border-collapse:collapse">
					<tr bgcolor="black" align="center">
						<td width="10%">번호</td>
						<td width="40%">제목</td>
						<td width="15%">이름</td>
						<td width="25%">날짜</td>
						<td width="10%">조회수</td>
					</tr>
					<%
					alist = bMgr.getBoardList(keyField, keyWord, start, end);
					listSize = alist.size();
					if(alist.isEmpty()){
						out.print("<tr><td colspan='5' align='center'>등록된 게시물이 없습니다.</td></tr>");
					} else{
						for(int i=0; i<end; i++){
							if(i == listSize)
								break;
							BoardBean bean = alist.get(i);
							int num = bean.getNum();
							String subject = bean.getSubject();
							String name =bean.getName();
							String regdate = bean.getRegdate().substring(0,11);
							int count = bean.getCount();
							int depth = bean.getDepth();
					%>
						<tr>
							<td align="center"><%=i+1 %></td>
							<td align="left">
								<%
								if(depth > 0){
									for(int j=0; j<depth; j++){
										out.print("&emsp;");
									}
								}
								%>
								<a href="javascript:read('<%=num %>')"><%=subject %></a>
							</td>
							<td align="center"><%=name %></td>
							<td align="center"><%=regdate %></td>
							<td align="center"><%=count %></td>
						</tr>
					<%
						}
					}
					%>
					<tr><td colspan="5"></td></tr>
					<tr>
						<!-- 페이징 처리 시작 -->
						<td colspan="3" align="center">
						<%
							// 1블록 페이지 시작:1, 2블록 페이지 시작:6
							int pageStart = (nowBlock-1) * pagePerBlock + 1;
							int pageEnd = (pageStart  + pagePerBlock <= totalPage) ? (pageStart + pagePerBlock) : totalPage+1;
							
							if(totalPage != 0){
								if(nowBlock > 1){
						%>
									<a href = "block('<%=nowBlock-1 %>')">prev...</a>
						<%			
								}
								out.print("&nbsp;");
								for(;pageStart < pageEnd; pageStart++){
						%>				
									<a href="pageing('<%=pageStart%>')">
									<%if(pageStart == nowPage){ %>
										<font color="blue">
									<% } %>
									[<%=pageStart %>]
									<%if(pageStart == nowPage){ %>
										</font>
									<%} %>
									</a>
						<%
								} // for문 닫기
								out.print("&nbsp");
								if(totalBlock > nowBlock){ 
						%>
									<a href="block('<%=nowBlock+1 %>')">...next</a>
						<%
								}
							} // if문 닫기
						%>
						</td>
						<!-- 페이징 처리 끝 -->
						<td colspan = "2" align="right">
							<a href="javascript:list();">[처음으로]</a>&nbsp;
							<a href="post.jsp">[글쓰기]</a>
							<a href="../index.jsp">[홈으로]</a>
						</td>
					</tr>
				</table>
				<hr width="700" />
			<form name="searchFrm" method ="get" action ="list.jsp">
				<table align="center" width="700">
					<tr>
						<td align="center">
							<select name="keyField">
								<option value="name">이름</option>
								<option value="subject">제목</option>
								<option value="content">내용</option>
							</select>
							<input name="keyWord">
							<input type="submit" value="찾기" required>
							<input type="hidden" name="nowPage" value="1">
						</td>
					</tr>
				</table>
			</form>
			<!-- 처음으로 누르면 화면을 reload하기 -->
		   	<form name="listFrm" method="post">
		      <input type="hidden" name="reload" value="true">
		      <input type="hidden" name="nowPage" value="1">
		   	</form>
		   <!-- 제목을 누르면 상세보기 페이지 보기 -->
			<form name ="readFrm" method="get">
				<input type="hidden" name="num">
				<input type="hidden" name="nowPage" value="<%=nowPage %>">
				<input type="hidden" name="keyField" value="<%=keyField %>">
				<input type="hidden" name="keyWord" value="<%=keyWord %>">
				<!-- 사용자가 변경하면 안 되는 값을 hidden으로 하여 사용자값+hidden값을 request하게 만든다 -->
			</form>
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
	</div> <!-- container -->
</body>
</html>
