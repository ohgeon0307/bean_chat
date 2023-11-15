<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="app.dto.UserDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 프로필 수정</title>

    <!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/mypage/my_profile_modify.css" rel="stylesheet" />

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
			fm.action = "<%=request.getContextPath()%>/mypage/myProfile.do"; //처리하기위해 이동하는 주소
			fm.submit();
			return;
		}else if(val == "1"){
			fm.method = "post";
			fm.action = "<%=request.getContextPath()%>/mypage/myModifyAction.do"; //처리하기위해 이동하는 주소
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
		
		<h2>내 프로필 수정하기</h2>

					
		<section id="posible">
		 	<form name="frm">
		 	<input type="hidden" name="uidx" id="uidx" value="${udto.uidx}">
		 		<section id="pro_image"><p>NO IMAGE</p></section>
		 		<section id="imposible">
					<div class="im_text">
						<h3>ID(Email) :</h3>
						<span>${udto.userId}</span>
					</div><!-- //.pro_text -->
					
					<div class="im_text">
						<h3>가입일 :</h3>
						<span>${udto.userDate}</span>
					</div><!-- //.pro_text -->
				</section>
				<section id="pro_info">
					<div class="pro_text">
						<label>닉네임</label>
						<input type="text" id="userNickname" name="userNickname" value="${udto.userNickname}" maxlength="10">
					</div><!-- //.pro_text -->
					
					
					<div class="pro_text">
						<label>이름 :</label>
						<input type="text" name="userName" id="userName" value="${udto.userName}">
					</div><!-- //.pro_text -->
					
					<div class="pro_text">
						<label>전화번호 :</label>
						<input type="text" name="userPhone" id="userPhone" value="${udto.userPhone}" maxlength="11">
					</div><!-- //.pro_text -->
					
					<div class="pro_text">
						<%
							UserDto udto = (UserDto) request.getAttribute("udto");
						        String userBirth = udto.getUserBirth();
						        String userYear = userBirth.substring(0, 4);
						        String userMonth = userBirth.substring(4, 6);
						        String userDay = userBirth.substring(6, 8);
						        
						        // 해당 연도와 월, 일의 값 확인하기
						        out.println("userYear: " + userYear); // 연도 출력
						        out.println("userMonth: " + userMonth); // 월 출력
						        out.println("userDay: " + userDay); // 일 출력
   						 %>
						<label>생년월일 :</label><br>
						
						<select name="userYear">
	        				<% 
	           				 for (int year = 1950; year <= 2023; year++) {
	       					 %>
	           				   <option value="<%= year %>" <%= (year == Integer.parseInt(userYear)) ? "selected" : "" %>><%= year %>년</option>
	        				<% } %>
    					</select>
    					<select name="userMonth">
	        				<% 
	            			for (int month = 1; month <= 12; month++) {
	       					 %>
	            			<option value="<%= month %>" <%= (month == Integer.parseInt(userMonth)) ? "selected" : "" %>><%= month %>월</option>
	       					 <% } %>
					    </select>
					    <select name="userDay">
					        <% 
					            for (int day = 1; day <= 31; day++) {
					        %>
					           <option value="<%= day %>" <%= (day == Integer.parseInt(userDay)) ? "selected" : "" %>><%= day %>일</option>
					        <% } %>
   						</select>

					</div><!-- //.pro_text -->
				</section>
				<input type="button" value="취소하기" onclick="changeForm(1)">
				<input type="button" value="수정하기" onclick="changeForm(0)">
			
<%-- 						<input type="text" name="userYear" value="<%= userYear %>"><p>년</p>
						<input type="text" name="userMonth" value="<%= userMonth %>"><p>월</p>
						<input type="text" name="userDay" value="<%= userDay %>"><p>일</p>
					</div><!-- //.pro_text --> --%>
	
		</form>
		</section>
		 	
		 		
	
	</main>
</body>
</html>