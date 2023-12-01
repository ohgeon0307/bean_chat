<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="frm">
<div class = "search-title">
					<h1>비밀번호 찾기</h1>
					<p>가입할 때 입력 한 정보를 정확하게 입력해주셔야 찾을 수 있어요!</p>
				</div>
			<section class = "form-search">
				<div class = "find-name">
					<label>이름 :</label><input type="text" name="userName" class = "btn-name" placeholder = "등록한 이름">
				</div>
				<div class = "find-email">
					<label>이메일(ID) :</label><input type="text" name="userId" class = "btn-Email" placeholder = "메일주소를 정확히 입력해주세요">
				</div>
		</section>
		<div class ="btnSearch">
			<input type="button" id="findBtn" name="enter" value="찾기"  onClick="pwdSearch()">
			<input type="button"  id="backBtn" name="cancle" value="취소" onClick="history.back()">
	 	</div>
</form>
	 <script>
	 function pwdSearch() { 
		 	var fm = document.frm;
	
		 	if (fm.userName.value.length < 1) {
			  alert("이름을 입력해주세요");
			  return;
			 }
	
			 /* if (fm.user.value.length != 11) {
				  alert("핸드폰번호를 정확하게 입력해주세요");
				  return;
			 } */
	
		 fm.method = "post";
		 fm.action = "<%=request.getContextPath()%>/user/userFindPwdAction.do";
		 fm.submit();  
		 return true;
		 }
	 </script>

</body>
</html>