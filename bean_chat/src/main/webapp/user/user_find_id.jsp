<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>아이디 찾기</title>
	<!-- 제이쿼리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"> </script>
	<!-- 부트스트랩 연결 -->
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link href="../css/user/user_find_id.css" rel="stylesheet" />
</head>
<body>
	<header>
		<!-- 헤더 시작 -->
		<div class="container">
			<img src="../images/indexImage/beanchat_text.png" alt="" class="beanchat_text">
			<div class="items">
				<ul>
					<li>
					<c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do">
								<img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span>
							</a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/user/userLogout.do">
								<img role="button" src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span>
							</a>
						</c:otherwise>
					</c:choose>
					</li>
					<li>
					<c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do">
								<img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span>
							</a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/mypage/myMain.do">
								<img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span>
							</a>
							</c:otherwise>
						</c:choose>
					</li>
					<li>
						<a href="<%=request.getContextPath()%>/board/boardList.do">
							<img role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span>
						</a>
					</li>
					<li>
					<c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do">
								<img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span>
							</a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/chat/chatList.do">
								<img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span>
							</a>
						</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</div><!-- //.items -->
		</div><!-- //.container -->
	</header>
	<!-- 헤더 종료 -->


<main>
	<ul class="nav nav-tabs">
		<li class="nav-item"><a class="nav-link active"	aria-current="page" href="#">Active</a></li>
		<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
	</ul>
	<form name="frm">
				<div class = "search-title">
					<h1>아이디 찾기</h1>
					<p>가입할 때 입력 한 정보를 정확하게 입력해주셔야 찾을 수 있어요!</p>
				</div>
			<section class = "form-search">
				<div class = "find-name">
					<label>이름</label>
					<input type="text" name="userName" class = "btn-name" placeholder = "등록한 이름">
				</div>
				<div class = "find-phone">
					<label>전화번호</label>
					<input type="text" name="userPhone" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
				</div>
		</section>
		<div class ="btnSearch">
			<input type="button" id="findBtn" name="enter" value="찾기"  onClick="idSearch()">
			<input type="button"  id="backBtn" name="cancle" value="취소" onClick="history.back()">
	 	</div>
	 </form>
	 <script>
	 function idSearch() { 
		 	var fm = document.frm;
	
		 	if (fm.userName.value.length < 1) {
			  alert("이름을 입력해주세요");
			  return;
			 }
	
			 if (fm.userPhone.value.length != 11) {
				  alert("핸드폰번호를 정확하게 입력해주세요");
				  return;
			 }
	
		 fm.method = "post";
		 fm.action = "<%=request.getContextPath()%>/user/userFindIdAction.do";
		 fm.submit();  
		 return true;
		 }
	 </script>
</main>

</body>
</html>