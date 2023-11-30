<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<!-- 제이쿼리 연결 -->
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"> </script>
<!-- 부트스트랩 연결 -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- css연결 -->
<link href="../css/reset.css" rel="stylesheet" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link href="../css/mypage/my_profile_modify.css" rel="stylesheet" />
</head>
<body>

	<ul class="nav nav-tabs">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="#">Active</a></li>
		<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
		<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
		<li class="nav-item"><a class="nav-link disabled"
			aria-disabled="true">Disabled</a></li>
	</ul>

	<main>



		<form name="frm">

			<c:choose>
				<c:when test="${userId != null }">


					<div class="container">
						<div class="found-success">
							<h4>회원님의 아이디는</h4>
							<div class="found-id">${userId}</div>
							<h4>입니다</h4>
						</div>
						<div class="found-login">
							<input type="button" id="btnLogin" value="로그인" onClick='login()' />
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="container">
						<div class="found-fail">
							<h4>등록된 정보가 없습니다</h4>
						</div>
						<div class="found-login">
							<input type="button" id="btnback" value="다시 찾기"
								onClick="history.back()" /> <input type="button" id="btnjoin"
								value="회원가입" onClick="joinin()" />
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="adcontainer">
				<img src="../images/indexImage/BeanChatWater.png" />
			</div>

		</form>
	</main>
</body>
</html>