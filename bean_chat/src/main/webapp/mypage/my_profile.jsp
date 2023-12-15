<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>내 프로필 보기</title>
	<!-- 제이쿼리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"> </script>
	<!-- 아이콘 연결 -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
	<link href="../css/mypage/my_profile.css" rel="stylesheet"/>
	<script>
		function changeForm(val) {
			var fm = document.frm;
			if (val == "0") {
				fm.method = "post";
				fm.action = "<%=request.getContextPath()%>/mypage/myModify.do"; //처리하기위해 이동하는 주소
				fm.submit();
				return;
			} else if (val == "1") {
				fm.method = "post";
				fm.action = "<%=request.getContextPath()%>/mypage/myMain.do"; //처리하기위해 이동하는 주소
				fm.submit();
				return;
			}

		}
	</script>

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
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
	        				</c:when>
	            			<c:otherwise>
	            				<a href="<%=request.getContextPath()%>/user/userLogout.do" onclick="return confirm('로그아웃 하시겠습니까?')"><img role="button" src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
	            			</c:otherwise>
	            		</c:choose>
	            	</li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
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
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
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
		<h2>나의 프로필</h2>
                                        
		<form name="frm" id="frm">
			<div id="main_view">
				<section id="pro_image_area">
					<img src="../${udto.userImage}" id="profile-image">
				</section><!-- //#pro_image_area -->
               	<section id="pro_info">
               		<div class="pro_title">
						<label id="nickName">닉네임</label>
							<span>${udto.userNickname}</span>
        			</div><!-- //.pro_text -->

					<div class="pro_text">
						<label>ID(Email) :</label>
							<span>${udto.userId}</span>
					 </div><!-- //.pro_text -->

					<div class="pro_text">
						<label>이름 :</label>
							<span>${udto.userName}</span>
					</div><!-- //.pro_text -->

					<div class="pro_text">
						<label>전화번호 :</label>
							<span>${udto.userPhone}</span>
					</div><!-- //.pro_text -->

					<div class="pro_text">
						<label>생년월일 :</label>
							<span>${udto.userBirth}</span>
					</div><!-- //.pro_text -->

					<div class="pro_text">
						<label>가입일 :</label>
							<span>${udto.userDate}</span>
					</div><!-- //.pro_text -->
				</section><!-- //#pro_info -->
				<button type="button" id="modiBtn" onclick="changeForm(0)"><i class="xi-pen"></i>내 정보 수정하러 갈래요! <i class="xi-long-arrow-right"></i></button>
			</div><!-- //#main_view -->
			<input type="button" id="backBtn" value="목록 돌아가기" onclick="changeForm(1)">
		</form>
	</main>
	<footer>
		<div id="slogan">
	        <img src="../images/indexImage/beanchat_char.png" width="200px" />
	        <p>Beanchat, the collaborative chat web application System.</p>
		</div><!--end: #slogan-->
		
		<div id="footerMenu">
			<ul>
				<li><a href="#">팀 소개</a></li>
					<p>&#124;</p>
				<li><a href="#">개인정보처리방침</a></li>
					<p>&#124;</p>
				<li><a href="#">이용약관</a></li>
					<p>&#124;</p>
				<li><a href="#">도움말</a></li>
					<p>&#124;</p>
				<li><a href="#">공지사항</a></li>
			</ul>
	        <p class="companyInfo">빈챗 &#124; 팀원 : 최다혜 안기현 임세현 오 건 <br/>
	        	Beanchat &#124; 전주시 덕진구 백제대로 572 4층 이젠컴퓨터아트서비스학원<br />
				© 2023 Beanchat Ltd. All rights reserved.
			</p><!--end: .companyInfo-->
		</div><!--end: #footerMenu-->
		<div id="sns">
			<ul>
				<li><a href="#"><i class="xi-instagram xi-2x"></i></a></li>
				<li><a href="#"><i class="xi-facebook xi-2x"></i></a></li>
				<li><a href="#"><i class="xi-kakaotalk xi-2x"></i></a></li>
			</ul>
		</div><!--end: #sns-->

	</footer>
</body>
</html>