<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- 제이쿼리 연결 -->
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>

<!-- css연결 -->
<link href="../css/reset.css" rel="stylesheet" />
<link href="../css/mypage/my_main.css" rel="stylesheet" />
<title>마이페이지 메인</title>
</head>

<body>
	<header><!-- 헤더 시작 -->
		<div class="container"> 
			<img src="../images/indexImage/beanchat_text.png" alt="" class="beanchat_text">    
	        <div class="items">
	            <ul>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"><img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
	        				</c:when>
	            			<c:otherwise>
	            				<a href="<%=request.getContextPath()%>/user/userLogout.do"  onclick="return confirm('로그아웃 하시겠습니까?')"><img role="button" src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
	            			</c:otherwise>
	            		</c:choose>
	            	</li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="<%=request.getContextPath()%>/mypage/myMain.do"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
	                		</c:otherwise>
	                	</c:choose>
	                </li>
	                <li><a href="<%=request.getContextPath()%>/board/boardList.do"><img role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a></li>
	                 <li><a  href="<%=request.getContextPath()%>/notice/noticeList.do"><img role="button" src="../images/indexImage/announcement_icon.png" alt=""><span>공지사항</span></a></li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="<%=request.getContextPath()%>/chat/chatList.do"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
	                		</c:otherwise>
	                	</c:choose>
	                </li>	
	            </ul>
			</div><!-- //.items -->
		</div> <!-- //.container -->
	</header><!-- 헤더 종료 -->
	<main>
		<h1>My Page</h1>
		<hr>
		<div id="main_zone">
			<div class="main_button">
				<a href="<%=request.getContextPath() %>/mypage/myProfile.do">
				<img src="../images/logo/BeanchatChar1.png" alt="프로필 보기" />
					<p>나의 프로필 볼래요!</p> </a>
			</div><!--//.main_button-->
			<div class="main_button">
				<a href="<%=request.getContextPath() %>/mypage/myModify.do">
				<img src="../images/logo/BeanchatChar2.png" alt="프로필 수정하기" />
					<p>내 프로필 수정할래요!</p> </a>
			</div><!--//.main_button-->
			<div class="main_button">
				<a href="<%=request.getContextPath() %>/mypage/myFriend.do">
					<img src="../images/logo/BeanchatChar3.png" alt="친구 관리하기" />
					<p>친구를 확인 할래요!</p>
				</a>
			</div><!--//.main_button-->
			<div class="main_button">
				<a href="<%=request.getContextPath() %>/mypage/myList.do">
					<img src="../images/logo/BeanchatChar4.png" alt="내가 쓴 글 보기" />
					<p>내가 쓴 글을 볼래요!</p>
				</a>
			</div><!--//.main_button-->
		</div><!-- //#main_zone -->
	</main>
	<footer></footer>
</body>
</html>
