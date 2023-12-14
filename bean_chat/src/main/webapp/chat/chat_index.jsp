<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="app.dao.UserDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String userId = (String) session.getAttribute("userId");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="../css/chat/chat_index.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>Chat Room</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
	<header><!-- 헤더 시작 -->
	<div class="container">
		<img src="../images/indexImage/beanchat_text.png" alt=""
			class="beanchat_text">
		<div class="items">
			<ul>
				<li><c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do"><img
								role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/user/userLogout.do"
								onclick="return confirm('로그아웃 하시겠습니까?')"><img role="button"
								src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
						</c:otherwise>
					</c:choose></li>
				<li><c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do"><img
								role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/mypage/myMain.do"><img
								role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
						</c:otherwise>
					</c:choose></li>
				<li><a href="<%=request.getContextPath()%>/board/boardList.do"><img
						role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a></li>
				<li><a
					href="<%=request.getContextPath()%>/notice/noticeList.do"><img
						role="button" src="../images/indexImage/announcement_icon.png"
						alt=""><span>공지사항</span></a></li>
				<li><c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do"><img
								role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/chat/chatIndex.do"><img
								role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
						</c:otherwise>
					</c:choose></li>
			</ul>
		</div>
		<!-- //.items -->
	</div>
	<!-- //.container --> 
	</header>
	<!-- 헤더 종료 -->
	<main>
	<h1>채팅 서비스</h1>
	<hr>
	<div id="main_zone">
		<div class="chat_button one">
			<a href="${pageContext.request.contextPath}/chat/createChatRoom.do">
				<img src="../images/logo/BeanchatChar1.png" alt="방 생성하기" />
				<p>채팅방 생성하기!</p>
			</a>

		</div>
		<div class="chat_button second">
			<a href="${pageContext.request.contextPath}/chat/viewChatRoomList.do">
				<img src="../images/logo/BeanchatChar2.png" alt="방 정보보기" />
				<p>채팅방 목록보기!</p>
			</a>

		</div>
	</div>
	</main>
	
</body>
</html>