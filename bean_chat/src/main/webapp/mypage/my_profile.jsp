<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 프로필 보기</title>
    <!-- 제이쿼리 연결 -->
    <script
      src="https://code.jquery.com/jquery-3.6.1.min.js"
      integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
      crossorigin="anonymous">
    </script>
<script>
	function changeForm(val){
		
		var fm = document.frm;
		
		if(val == "0"){
			fm.method = "post";
			fm.action = "<%=request.getContextPath()%>/mypage/userJoinAction.do"; //처리하기위해 이동하는 주소
			fm.submit();
			return;
		}else if(val == "1"){
			fm.method = "post";
			fm.action = "<%=request.getContextPath()%>/mypage/userJoinAction.do"; //처리하기위해 이동하는 주소
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
					<li><a href="<%=request.getContextPath()%>/user/userLogin.do"><img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a></li>
					<li><a href="<%=request.getContextPath()%>/mypage/myMain.do"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a></li>
					<li><a href="<%=request.getContextPath()%>/board/boardList.do"><img role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a></li>
					<li><a href="<%=request.getContextPath()%>/chat/chatList.do"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a></li>
				</ul>
			</div><!-- //.items -->
		</div> <!-- //.container -->
	</header><!-- 헤더 종료 -->
    <main>
		<h1>My Page</h1>
		<hr>
		<h2>나의 프로필</h2>
		 <form name="frm">
			 <div id="main_view">
				<section id="pro_image"><p>NO IMAGE</p></section>
				<section id="pro_info">
					<div class="pro_text">
						<label>닉네임</label>
						<span>${uidx.nickname}</span>
					</div><!-- //.pro_text -->
					
					<div class="pro_text">
						<label>ID(Email) :</label>
						<span>${uidx.id}</span>
					</div><!-- //.pro_text -->
					
					<div class="pro_text">
						<label>이름 :</label>
						<span>${uidx.name}</span>
					</div><!-- //.pro_text -->
					
					<div class="pro_text">
						<label>전화번호 :</label>
						<span>${uidx.phone}</span>
					</div><!-- //.pro_text -->
					
					<div class="pro_text">
						<label>생년월일 :</label>
						<span>${uidx.birth}</span>
					</div><!-- //.pro_text -->
					
					<div class="pro_text">
						<label>가입일 :</label>
						<span>${uidx.udate}</span>
					</div><!-- //.pro_text -->
				</section>
				<input type="button" value="정보수정하기" onclick="changeForm(0)">
				<input type="button" value="탈퇴하기" onclick="changeForm(1)">
			</div>
	
		</form>

</main>
</body>
</html>