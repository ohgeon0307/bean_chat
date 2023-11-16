<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<header>
		<div></div>
	</header>
	<main>
		<h1>My Page</h1>
		<hr />
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
