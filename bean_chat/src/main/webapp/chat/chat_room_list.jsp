<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="UTF-8">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>beanchat</title>
<link rel="stylesheet" href="../css/chat/chat_room_list.css">
<link href="../images/indexImage/beanchat_char.png" rel="shortcut icon" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

</head>
<body>
	<!-- 헤더 시작 -->
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
							<a href="<%=request.getContextPath()%>/user/userLogout.do"><img
								role="button" src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
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
				<li><c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do"><img
								role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/chat/chatRoomList.do"><img
								role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
						</c:otherwise>
					</c:choose></li>
			</ul>
		</div>
	</div>
	<!-- 헤더 종료 -->
	<!-- 메인 -->
	<main>
		<h1>채팅방 목록</h1>
		<div id="inner">
			<div class="chatList">
				<ul>
					<c:forEach items="${alist }" var="bdto">
						<li><a
							href="${pageContext.request.contextPath}/chat/chatContents.do?cidx=${cdto.cidx}">${cdto.ridx }</a>
							<div class="chatContent">
								<p>닉네임 : ${cdto.cTo} 메시지내용 : ${cdto.cContents } 시간 :
									${cdto.cTime }</p>

							</div> <!--end: chatContent--></li>
					</c:forEach>
				</ul>
			</div>
			<!-- end: chatList -->
		</div>



	</main>
</body>
</html>