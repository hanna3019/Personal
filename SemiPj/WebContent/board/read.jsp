<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*"%>      
<jsp:useBean id="bMgr" class="board.BoardMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	bMgr.upCount(num);
	
	BoardBean bean = bMgr.getBoard(num);
	String date = bean.getRegdate().substring(0,11);
	session.setAttribute("bean", bean);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {background-color: lightgray; margin-top: 50px}
#ftr {background-color: black; color:white;}
#title {background-color: gray; color:white;}
a {text-decoration: none; color: black;}
a:hover{font-weight: bold;}
</style>
<script>
	function down(filename){
		downFrm.filename.value = filename;
		downFrm.submit();
	}
	function list(){
		listFrm.submit();
	}
</script>
</head>
<body align="center">
	<table width="800px" align="center" border="1">
		<tr id="ftr">
			<th colspan="4">글읽기</th>
		</tr>
		<tr>
			<td id="title">이름</td>
			<td><%=bean.getName() %></td>
			<td id="title">등록날짜</td>
			<td><%=date %></td>
		</tr>
		<tr>
			<td id="title">제목</td>
			<td colspan="3"><%=bean.getSubject() %></td>
		</tr>
		<tr>
			<td id="title">첨부파일</td>
			<td colspan="3">
			<%
				String filename = bean.getFilename();
				if(bean.getFilename() != null && !bean.getFilename().equals("")){
			%>
				<a href="javascript:down('<%=filename %>')"><%=filename %></a>&nbsp;
				<font color="blue">(<%=bean.getFilesize() %> Kbyte)</font>
			<%
				} else{
					out.print("등록된 파일이 없습니다");
				}
			%>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="left"><br/><pre><%=bean.getContent() %></pre><br/></td>
		</tr> <!-- pre는 jsp문서 내 줄바꿈을 인식하여 사이트에도 줄바꿈을 해 주는 신기방기한 태그 -->
		<tr>
			<td colspan="4" align="right"><%=bean.getIp() %>로부터 글을 남겼습니다 / 조회수 <%=bean.getCount() %></td>
		</tr> 
		<tr>
			<td colspan="4"><hr>
				<a href="javascript:list();">리스트</a> | 
				<!-- 조건(이름 등)을 걸고 검색했을 때 뒤로가기를 누르면 조건이 풀리는 것 방지(list.jsp는 조건 풀림)-->
				<a href="update.jsp?nowPage=<%=nowPage %>&num=<%=num%>">수 정</a> |
				<a href="reply.jsp?nowPage=<%=nowPage %>&num=<%=num%>">답 변</a> |
				<a href="delete.jsp?nowPage=<%=nowPage %>&num=<%=num%>">삭 제</a> |
			</td>
		</tr>
	</table>
		
	<form name="downFrm" method="post" action="download.jsp">
		<input type="hidden" name="filename">
	</form>
	
	<form name="listFrm" method="post" action="list.jsp">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
		<%
		if(!(keyWord==null || keyWord.equals(""))){
		%>
			<input type="hidden" name="keyField" value="<%=keyField %>">
			<input type="hidden" name="keyWord" value="<%=keyWord %>">
		<%
		}
		%>
	</form>
</body>
</html>