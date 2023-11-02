<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빈챗 게시글 목록</title>
</head>
<body>
	<h1>게시판 목록</h1>
	<form name="frm"
	action="${pageContext.request.contextPath}/board/board_list.do" method="post">
	<table border=0 style="width: 600px">
		<tr>
		<td style="width: 500px"></td>
		<td><select name="searchType">
						<option value="subject">제목</option>
						<option value="writer">작성자</option>
				</select></td>
				<td><input type="text" name="keyword" size=10></td>
				<td><input type="submit" name="sbt" value="검색"></td>
			</tr>
		</table>
	</form>
	<table border=1 style="width: 600px">
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<%
			// for (BoardVo bv : list) {
			%>
			<c:forEach var="bdto" items="${alist}">
				<tr>
					<td>
						<%
						//=bv.getBidx()
						%>${bdto.bidx}</td>
					<td class="subject">
						<%
						// for(int i=1;i<=bv.getLevel_();i++){
						//	out.print("&nbsp;&nbsp;");
						//	if (i == bv.getLevel_()){
						//		out.print("ㄴ");
						//	}			
						//}
						%> <c:forEach var="i" begin="1" end="${bd.level_}" step="1">
		 &nbsp;&nbsp;
						</c:forEach> <a
						href="${pageContext.request.contextPath}/board/boardContents.do?bidx=${bdto.bidx}">
							<%
							//=bv.getSubject()
							%> ${bdto.subject}
					</a>
					</td>
					<td>
						<%
						//=bv.getWriter()
						%>${bdto.writer}</td>
					<td>
						<%
						//=bv.getViewcnt()
						%>${bdto.viewcnt}</td>
					<td>
						<%
						//=bv.getWriteday()
						%>${bdto.writedate}</td>
				</tr>
			</c:forEach>
			<%
			//}
			%>

		</tbody>
	</table>
	<c:set var="keyword" value="${pm.scri.keyword}" />
	<c:set var="parm"
		value="&searchType=${pm.scri.searchType}&keyword=${pm.scri.keyword}" />

	<table border=0 style="width: 600px; text-align: center;">
		<tr>
			<td style="width: 100px; text-align: right;">
				<%
				// if (pm.isPrev()==true) {
				%> <c:if test="${pm.prev == true}">
					<a
						href="${pageContext.request.contextPath}/board/boardList.do?page=${pm.startPage-1}${parm}">
						◀ </a>
				</c:if> <%
 //}
 %>
			</td>
			<td>
				<%
				//for(int i=pm.getStartPage();i<=pm.getEndPage();i++){
				%> <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}"
					step="1">

					<a
						href="${pageContext.request.contextPath}/board/boardList.do?page=${i}${parm}">${i}</a> &nbsp;
<%
//}
%>
				</c:forEach>
			</td>
			<td style="width: 100px; text-align: left;">
				<%
				//if(pm.isNext() ==true && pm.getEndPage()>0){
				%> <c:if
					test="${pm.next == true&&pm.endPage>0}">
					<a
						href="${pageContext.request.contextPath}/board/boardList.do?page=${pm.endPage+1}${parm}">
						▶ </a>
					<%//} %>
				</c:if>
			</td>
		</tr>
	</table>

	<a href="${pageContext.request.contextPath}/board/board_write.do">글쓰기</a>
	
	
</body>
</html>