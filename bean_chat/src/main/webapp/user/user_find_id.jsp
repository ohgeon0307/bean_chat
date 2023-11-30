<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<link href="../css/mypage/my_profile_modify.css" rel="stylesheet" />
</head>
<body>

	<ul class="nav nav-tabs">
		<li class="nav-item"><a class="nav-link active"	aria-current="page" href="#">Active</a></li>
		<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
	</ul>
<main>
<form name="frm">
			<div class = "search-title">
				<h3>휴대폰 본인확인</h3>
			</div>
		<section class = "form-search">
			<div class = "find-name">
				<label>이름</label>
				<input type="text" name="userName" class = "btn-name" placeholder = "등록한 이름">
			<br>
			</div>
			<div class = "find-phone">
				<label>번호</label>
				<input type="text" name="userPhone" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
			</div>
			<br>
	</section>
	<div class ="btnSearch">
		<input type="button" name="enter" value="찾기"  onClick="idSearch()">
		<input type="button" name="cancle" value="취소" onClick="history.back()">
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