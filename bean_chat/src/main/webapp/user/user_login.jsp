<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
	<!-- 제이쿼리 연결 -->	
	<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"> </script>
	<!-- 부트스트랩 연결 -->
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- 아이콘 연결 -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
	<link href="../css/user/user_login.css" rel="stylesheet" />
</head>


<body>
	<header><!-- 헤더 시작 -->
		<div class="container"> 
			<a href="../index.jsp"><img role="button" src="../images/indexImage/beanchat_text.png" alt="" class="beanchat_text"></a>     
	        <div class="items">
	            <ul>
		           <li> 
	            		<c:if test="${admin == 'admin' }">
	            			<a href="<%=request.getContextPath()%>/admin/userList.do"><i class="xi-crown xi-4x" style="color:gold;"></i></a>
	            		</c:if>
	            	</li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"><img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
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
	<ul class="nav nav-tabs">
		<li class="nav-item">
			<a class="nav-link" href="<%=request.getContextPath()%>/user/userJoin.do" id="userJoinBtn">회원가입하기</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="<%=request.getContextPath()%>/user/userFindIdPwd.do" id="userFindBtn">ID/PW 찾기</a>
		</li>
	</ul>
	<main>
	<form name="frm">
	<div id="title_zone">
		<img src="../images/indexImage/beanchat.png">
		<div id="title_text">
			<h1>로그인</h1>
			<p>로그인하여 빈챗의 서비스를 이용하세요!</p>
		</div>
	</div>
		<div id="input_zone">
			<div class="user_input">
				<label for="userId">ID(이메일) :</label> 
				<div class="input_area">
					<input type="text" id="userId" name="userId" placeholder="아이디(이메일)" maxlength="30" autocomplete="off" required>
				</div><!-- //.input_area -->
			</div><!-- //.user_input(아이디) -->
			
			<div class="user_input" id="input2">
				<label for="userPwd">비밀번호 :</label> 
				<div class="input_area">
					<input type="password" name="userPwd" name="userPwd" placeholder="비밀번호" maxlength="30">
				</div><!-- //.input_area -->
			</div><!-- //.user_input(비밀번호) -->
		</div><!-- //#input_zone -->
		
		<div id="button_zone">
			<input type="button" id="smtBtn" name="smt" value="확인" onclick="check();">
			<input type="button" class="backBtn" name="cancle" value="취소"onClick="history.back()">
		</div><!-- //#button_zone -->
		
		<%-- <div id="join_find_area">
			<a href="<%=request.getContextPath()%>/user/userJoin.do">>회원가입</a>
			<a href="<%=request.getContextPath()%>/user/userFindIdPwd.do">>ID/PW 찾기</a>
		</div><!-- //#join_find_area --> --%>
		
		<!-- <div>	
			<label>
				<input type="checkbox">아이디 저장 
			</label>
		</div> -->
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
	<script type="text/javascript">
		function check(){
			//alert("체크함수들어옴");
			
			//let memberId = document.frm.memberId.value;
			//alert("입력된 아이디는?"+memberId);
			var fm = document.frm; //문서객체안의 폼객체이름
			if(fm.userId.value ==""){
				alert("아이디를 입력하세요");
				fm.userId.focus();
				return;
			}else if (fm.userPwd.value ==""){
				alert("비밀번호를 입력하세요");
				fm.userPwd.focus();
				return;		
			}
		
			fm.action ="<%=request.getContextPath()%>/user/userLoginAction.do";  //처리하기위해 이동하는 주소
			fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
			fm.submit(); //전송시킴
			return true;	
		}
<<<<<<< HEAD
=======
		
>>>>>>> branch 'master' of https://github.com/ohgeon0307/bean_chat.git
	        	
	
	</script>

</body>
</html>