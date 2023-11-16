<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>
<body>
<main>
	<h1>비밀번호 변경</h1>
	<span>현재 비밀번호가 일치하는 경우 새 비밀번호로 변경할 수 있습니다.</span>
		<form action="" method="POST" name="frm">

			<div class="pro-text">
				<label>현재 비밀번호</label>
				<input type="password" name="nowPwd" id="nowPwd" maxlength="30">
			</div>
			
			<div class="pro-text">
				<label>새 비밀번호</label>
				<input type="password" name="newPwd" maxlength="30">
			</div>
			
			<div class="pro-text">
				<label>새 비밀번호 확인</label>
				<input type="password" name="newPwd2" maxlength="30">
			</div>
			
			<button id="modifyBtn">수정하기</button>

		</form>



</main>

</body>
</html>