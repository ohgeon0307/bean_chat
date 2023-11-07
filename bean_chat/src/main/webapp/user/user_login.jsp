<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>


</head>


<body>
	<h2>로그인페이지</h2>
	
	<form name="frm">
		<div>
			<label for="userId">
				<span class="required">*</span> 아이디(이메일)
			</label> 
			
			<input type="text" id="userId" name="userId" placeholder="아이디(이메일)" maxlength="30" autocomplete="off" required>

			<label for="userPwd"> 
				<span class="required">*</span> 비밀번호
			</label> 
			
			<input type="password" name="userPwd" name="userPwd" placeholder="비밀번호" maxlength="30">
		</div>
			<input type="button" name="smt" value="확인" onclick="check();">

		<div id="join_find_area">
			<a href="<%=request.getContextPath()%>/user/userJoin.do">>회원가입</a>
			<a href="<%=request.getContextPath()%>/user/userFindIdpwd.do">>ID/PW 찾기</a>
		</div>
		
		<div>	
			<label>
				<input type="checkbox">아이디 저장 
			</label>
		</div>
	</form>
	
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

</script>

</body>
</html>