<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="app.dto.UserDto" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 프로필 수정</title>

    <!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/mypage/my_profile_modify.css" rel="stylesheet" />
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <!-- 제이쿼리 연결 -->
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"> </script>
    <script>
	function changeForm(val){
		
		var fm = document.frm;
		
		if(val == "1"){
			fm.method = "post";
			fm.action = "<%=request.getContextPath()%>/mypage/myProfile.do"; //처리하기위해 이동하는 주소
			fm.submit();
			return;
		}else if(val == "0"){
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
		 	<form name="frm" enctype="multipart/form-data">
		 	<input type="hidden" name="uidx" id="uidx" value="${udto.uidx}">
		 	<div id="high_zone">	
            <section id="pro_image">
		 			<div class="pro_image_area">
		 				<c:if test="${empty udto.userImage}">
                            <img src="../images/noprofile.png" id="profile-image">
                        </c:if>
                            
                        <c:if test="${!empty udto.userImage}">
                            <img src="${contextPath}${udto.userImage}" id="profile-image">
                        </c:if>	
		 			
		 			</div>

		 		 	<div class="pro_img_btn">
                        <label for="userImage">이미지 선택</label>
                        <input type="file" name="userImage" id="userImage" accept="image/*">
                        <input type="submit" value="변경하기" onclick="changeImg()">
                    </div>
		 		</section>

		 		<section id="imposible">
					<div class="im_text">
						<h3>ID(Email)</h3>
						<span>: ${udto.userId}</span>
					</div><!-- //.pro_text -->
					
					<div class="im_text">
						<h3>가입일</h3>
                        <span>: ${udto.userDate}</span>
					</div><!-- //.pro_text -->
                    <div class="im_text">
                        <button id="pwdBtn"><i class="xi-touch"></i>비밀번호 변경할래요!<i class="xi-pen"></i></button>
                        <button id="delBtn"><i class="xi-error"></i>우리 그만봐요..탈퇴할래요..<i class="xi-emoticon-sad-o"></i></button>
                    </div>
				</section>
            </div>
				<section id="pro_info">
					<div class="pro_text">
						<label>닉네임 : </label>
						<input type="text" id="userNickname" name="userNickname" value="${udto.userNickname}" maxlength="10">
					</div><!-- //.pro_text -->
					
					
					<div class="pro_text">
						<label>이름 : </label>
						<input type="text" name="userName" id="userName" value="${udto.userName}">
					</div><!-- //.pro_text -->
					
					<div class="pro_text">
						<label>전화번호 : </label>
						<input type="text" name="userPhone" id="userPhone" value="${udto.userPhone}" maxlength="11">
					</div><!-- //.pro_text -->
					
					<div class="pro_text">
						<%
							UserDto udto = (UserDto) request.getAttribute("udto");
						        String userBirth = udto.getUserBirth();
						        String userYear = userBirth.substring(0, 4);
						        String userMonth = userBirth.substring(4, 6);
						        String userDay = userBirth.substring(6, 8);
   						 %>
   						 <div id="userBirth">
						<label>생년월일 : </label>
						
						<select name="userYear" id="userYear">
	        				<% 
	           				 for (int year = 1950; year <= 2023; year++) {
	           					 String formattedYear = String.format("%04d", year); // 연도를 4자리로 표현
	       					 %>
	           				   <option value="<%= formattedYear %>" <%= (formattedYear.equals(userYear)) ? "selected" : "" %>><%= formattedYear %></option>
	        				<% } %>
    					</select><p>년</p>
    					<select name="userMonth" id="userMonth">
	        				<% 
	            			for (int month = 1; month <= 12; month++) {
	            				 String formattedMonth = String.format("%02d", month); // 월을 2자리로 표현
	       					 %>
	            			<option value="<%= formattedMonth %>" <%= (formattedMonth.equals(userMonth)) ? "selected" : "" %>><%= formattedMonth %></option>
	       					 <% } %>
					    </select><p>월</p>
					    <select name="userDay" id="userDay">
					        <% 
					            for (int day = 1; day <= 31; day++) {
					            	 String formattedDay = String.format("%02d", day); // 일을 2자리로 표현
					        %>
					           <option value="<%= formattedDay %>" <%= (formattedDay.equals(userDay)) ? "selected" : "" %>><%= formattedDay %></option>
					        <% } %>
   						</select><p>일</p>
						</div><!-- //#userBirth -->
					</div><!-- //.pro_text -->
					
					
				</section>
                <section id="button_zone">
                    <input type="button" id="modiBtn" value="변경하기" onclick="changeForm(0)">
                    <input type="button" id="backBtn" value="취소하기" onclick="changeForm(1)">
                    
			    </section>
		</form>
		</section>
		 	
		 		
	
	</main>
	<script>
	function changeImg(){
	    
	    const userImage = document.getElementById("userImage");

	    if(userImage.value == ""){ // 빈 문자열 == 파일 선택 X
	        alert("이미지를 선택한 후 변경 버튼을 클릭해 주세요.");
	        return false;
	    }
	    
		var fm = document.frm;
		
		fm.method = "post";
		fm.action = "<%=request.getContextPath()%>/mypage/myImage.do"; //처리하기위해 이동하는 주소
		fm.submit();

	    return true;
	}
	
	
	
	</script>
	<script>
	const userImage = document.getElementById("userImage");
	if(userImage != null){ // inputImage 요소가 화면에 존재할 때
	
		userImage.addEventListener("change", function(){
			
			if(this.files[0] != undefined){ // 파일이 선택되었을 때
				const reader = new FileReader();
				// 자바스크립트의 FileReader
	            // - 웹 애플리케이션이 비동기적으로 데이터를 읽기 위하여 사용하는 객체
	            
				reader.readAsDataURL(this.files[0]);
		        // FileReader.readAsDataURL(파일)
		       	// - 지정된 파일의 내용을 읽기 시작함
		       	
		        // - 읽어오는 게 완료되면 result 속성 data:에
		        //   읽어온 파일의 위치를 나타내는 URL이 포함됨
		        // -> 해당 URL을 이용해서 브라우저에 이미지를 볼 수 있다.
  				// FileReader.onload = function(){}
           		//  - FileReader가 파일을 다 읽어온 경우 함수를 수행
            	reader.onload = function(e){ // 고전 이벤트 모델
            		// e : 이벤트 발생 객체
                    // e.target : 이벤트가 발생한 요소 -> FileReader
                    // e.target.result : FileReader가 읽어온 파일의 URL
            		 // 프로필 이미지에 src 속성의 값을 FileReader가 읽어온 파일을 URL로 변경
                    const profileImage = document.getElementById("profile-image");
                    profileImage.setAttribute("src", e.target.result);
                    // -> setAttribute() 호출 시 중복되는 속성이 존재하면 덮어쓰기
           		}
		}
    })
}
	
	</script>
</body>
</html>