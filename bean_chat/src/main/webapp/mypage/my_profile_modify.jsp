<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="app.dto.UserDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>내 프로필 수정</title>
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
	<header><!-- 헤더 시작 -->
		<div class="container"> 
			<img src="../images/indexImage/beanchat_text.png" alt="" class="beanchat_text">    
	        <div class="items">
	            <ul>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
	        				</c:when>
	            			<c:otherwise>
	            				<a href="<%=request.getContextPath()%>/user/userLogout.do" onclick="return confirm('로그아웃 하시겠습니까?')"><img role="button" src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
	            			</c:otherwise>
	            		</c:choose>
	            	</li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="<%=request.getContextPath()%>/mypage/myMain.do"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
	                		</c:otherwise>
	                	</c:choose>
	                </li>
	                <li><a href="<%=request.getContextPath()%>/board/boardList.do"><img role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a></li>
	                 <li><a  href="<%=request.getContextPath()%>/notice/noticeList.do"><img role="button" src="../images/indexImage/announcement_icon.png" alt=""><span>공지사항</span></a></li>
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
	<main>
		<h1>My Page</h1>
		<hr>

		<h2>내 프로필 수정하기</h2>

		<form name=pFrm enctype="multipart/form-data">
			<input type="hidden" name="uidx" id="uidx" value="${uidx}">
			<div id="posible">
				<section id="pro_image">
				
					<div class="pro_image_area">
<%-- 						<c:if test="${empty udto.userImage}">
							<img src="../images/noprofile.png" id="profile-image">
						</c:if> --%>

					<%-- 	<c:if test="${!empty udto.userImage}"> --%>
							<img src="../${udto.userImage}" id="profile-image">
<%-- 						</c:if> --%>
					</div><!-- //.pro_image_area -->

					<div class="pro_img_btn">
						<label for="userImage">이미지 선택</label> <input type="file"
							name="userImage" id="userImage" accept="image/*"> <input
							type="submit" value="변경하기" onclick="changeImg()">
					</div><!-- //.pro_img_btn -->
					
					<p><i class="xi-check-min"></i>이미지 선택 후 변경하기 버튼을 꼭 눌러주세요!</p>
					
				</section><!-- //#pro_image -->

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
						<button type="button" id="pwdBtn" data-value="${udto.uidx}">
							<i class="xi-touch"></i>비밀번호 변경할래요!<i class="xi-pen"></i>
						</button><!-- modalBox연결 버튼 -->
						<button type="button" id="delBtn" data-value="${udto.uidx}">
							<i class="xi-error"></i>우리 그만봐요..탈퇴할래요..<i class="xi-emoticon-sad-o"></i>
						</button><!-- delmodal연결 버튼 -->
					</div><!-- //.im_text -->
					
				</section><!-- //#imposible -->

			</div><!-- //#posible -->
		</form><!-- end pfm form -->
		
		<form name="frm">
		
			<input type="hidden" name="uidx" id="uidx" value="${uidx}"><!-- input value값 겹쳐도 오류안남 -->
			
			<section id="pro_info">
				<div class="pro_text">
					<label>닉네임 : </label>
					<input type="text" id="userNickname" name="userNickname" value="${udto.userNickname}" maxlength="10">
				</div><!-- //.pro_text -->

				<div class="pro_text">
					<label>이름 : </label> <input type="text" name="userName"
						id="userName" value="${udto.userName}">
				</div><!-- //.pro_text -->

				<div class="pro_text">
					<label>전화번호 : </label> <input type="text" name="userPhone"
						id="userPhone" value="${udto.userPhone}" maxlength="11">
				</div><!-- //.pro_text -->

				<div class="pro_text">
				<!-- userbirth잘라 가져오기위한 substring ex)19970813 0~4:1997 -->
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
								<option value="<%= formattedYear %>"<%= (formattedYear.equals(userYear)) ? "selected" : "" %>><%= formattedYear %></option>
								<% } %>
							</select>
							<p>년</p>
							<select name="userMonth" id="userMonth">
								<% 
			            			for (int month = 1; month <= 12; month++) {
			            				 String formattedMonth = String.format("%02d", month); // 월을 2자리로 표현
			       					%>
								<option value="<%= formattedMonth %>"<%= (formattedMonth.equals(userMonth)) ? "selected" : "" %>><%= formattedMonth %></option>
								<% } %>
							</select>
							<p>월</p>
							<select name="userDay" id="userDay">
								<% 
							    	for (int day = 1; day <= 31; day++) {
							        	String formattedDay = String.format("%02d", day); // 일을 2자리로 표현
							        %>
								<option value="<%= formattedDay %>"<%= (formattedDay.equals(userDay)) ? "selected" : "" %>><%= formattedDay %></option>
								<% } %>
							</select>
							<p>일</p>
					</div><!-- //#userBirth -->
				</div><!-- //.pro_text -->
			</section><!-- //#pro_info -->

			<section id="button_zone">
				<input type="button" id="modiBtn" value="변경하기" onclick="changeForm(0)">
				<input type="button" id="backBtn" value="취소하기" onclick="changeForm(1)">
			</section><!-- //#button_zone -->
			
		</form><!-- end frm form -->
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
	<!-- 모달은 position fixed,relative안에 있으면 동작안해서 메인밖으로 뺌 -->
	<!-- 모달시작 -->
	<form name="mFrm" enctype="multipart/form-data">
		<!-- 비밀번호 변경 클릭 시 -->
		<div class="modal" id="modalBox" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title" id="modalLabel">비밀번호 변경하기</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button><!-- 상단 닫기 x버튼 -->
					</div><!-- //.modal-header -->

					<!-- Modal body -->
					<div class="modal-body">
						<input type="hidden" name="uidx" id="uidx" value="${uidx}">
						
						<div class="myPage-row">
							<label>현재 비밀번호</label>
							<input type="password" name="userPwd" id="userPwd" placeholder="현재 비밀번호를 입력해주세요." maxlength="30">
						</div><!-- //.myPage-row -->

						<div class="myPage-row">
							<label class="newPwd">변경 할 비밀번호</label>
							<input type="password" name="newPwd" id="newPwd" placeholder="새롭게 설정 할 비밀번호를 입력해주세요." maxlength="30">
						</div><!-- //.myPage-row -->


						<div class="myPage-row">
							<label class="newPwd">새 비밀번호 확인</label>
							<input type="password" name="newPwd2" id="newPwd2" maxlength="30" placeholder="새로운 비밀번호를 한번 더 입력해주세요.">
						</div><!-- //.myPage-row -->

						<span class="message" id="pwdMessage">영어, 숫자, 특수문자(!,@,#,-,_) 6~30글자 사이로 작성해주세요.</span>

						<div class="modal-footer">
							<button type="submit" class="btn btn-danger" id="newPwdBtn" onclick="allCheck();">수정하기</button>
							<button type="button" id="closeModalBtn" class="btn btn-default" data-dismiss="modal">취소</button>
						</div><!-- //.modal-footer -->

					</div><!-- //.modal-body -->

				</div><!-- //.modal-content -->
			</div><!-- //.modal-dialog modal-dialog-centered -->
		</div><!-- //.modal -->
		<!-- 회원탈퇴 버튼 클릭 시 보여질 Modal -->
		<div class="modal" id="delModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">회원탈퇴</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div><!-- //.modal-header -->


					<!-- Modal body -->
					<div class="modal-body">
						<div id="main_text">
							탈퇴 후 복구는 불가능해요. <br>
							탈퇴한다면 개인정보는 삭제 할게요..<br>
							정말 탈퇴 할거에요ㅠ.ㅠ? <br>
						</div><!-- //#main_text -->
						<br>
						<label for="userPwd">Password : </label>
						<input type="password" placeholder="Enter Password" id="delUserPwd" name="delUserPwd">
					</div><!-- //.modal-body -->
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger" onclick="byeUser();">탈퇴하기</button>
						<button type="button" id="clodelModalBtn" class="btn btn-default" data-dismiss="modal">취소</button>
					</div><!-- //.modal-footer -->

				</div><!-- //.modal-content -->
			</div><!-- //.modal-dialog modal-dialog-centered -->
		</div><!-- //#delModal -->
	</form>
	<script>  // 모달 버튼에 이벤트를 건다.  
	$('#pwdBtn').on('click', function(){
		$('#modalBox').modal('show');  });  
	// 모달 안의 취소 버튼에 이벤트를 건다.  
	$('#closeModalBtn').on('click', function(){
		$('#modalBox').modal('hide');  });
	
	$('#delBtn').on('click', function(){
		$('#delModal').modal('show');  });  
	// 모달 안의 취소 버튼에 이벤트를 건다.  
	$('#clodelModalBtn').on('click', function(){
		$('#modalBox').modal('hide');  });
	
	</script>

	<script>
	function changeForm(val){
		
		var fm = document.getElementsByName("frm")[0];
		
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
	<script>
	
	function changeImg(){
	    
	    const userImage = document.getElementById("userImage");

	    if(userImage.value == ""){ // 빈 문자열 == 파일 선택 X
	        alert("이미지를 선택한 후 변경 버튼을 클릭해 주세요.");
	        return false;
	    }else{
	    
		var pfm = document.pFrm;
		
		pfm.method = "post";
		pfm.action = "<%=request.getContextPath()%>/mypage/myImage.do"; //처리하기위해 이동하는 주소
		pfm.submit();

	    return true;
	    }
	}
	
	
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
	
	
	/* document.getElementById('modal').addEventListener('shown.bs.modal', function () {
		  document.getElementById('userPwd').focus();
		}); */
	
	
	
		const checkObj = {
	        
	        newPwd: false,
	        newPwd2: false,
	        
	      };
	
        	// 비밀번호 유효성 검사
        	  const userPwd = document.getElementById("userPwd");
        	  const newPwd = document.getElementById("newPwd");
        	  const newPwd2 = document.getElementById("newPwd2");
        	  
        	  const pwdMessage = document.getElementById("pwdMessage");

        	  newPwd.addEventListener("input", function(){

        	      if(newPwd.value.trim().length == 0){
        	          pwdMessage.innerText = "영어, 숫자, 특수문자(!,@,#,-,_) 6~30글자 사이로 작성해주세요.";
        	          pwdMessage.classList.remove("success", "error");

        	          checkObj.newPwd = false; // 유효 X 기록
        	          return;
        	      }

        	      // const regExp = /^[a-zA-Z0-9!@#_-]{6,30}$/;
        	      const regExp = /^[\w!@#_-]{6,30}$/;

        	      if(regExp.test(newPwd.value)){ // 비밀번호 유효한 경우

        	          checkObj.newPwd = true; // 유효 O 기록

        	          if(newPwd.value.trim().length == 0){ // 비밀번호 유효, 비밀번호 확인 작성 X
        	              pwdMessage.innerText = "유효한 비밀번호 형식입니다.";
        	              pwdMessage.classList.add("success");
        	              pwdMessage.classList.remove("error");

        	          }else{ // 비밀번호 유효, 확인 작성 O
        	              checkPwd(); // 비밀번호 일치 검사 함수 호출()
        	          }

        	      } else{
        	          pwdMessage.innerText = "비밀번호 형식이 유효하지 않습니다.";
        	          pwdMessage.classList.add("error");
        	          pwdMessage.classList.remove("success");
        	          checkObj.newPwd = false; // 유효 X 기록
        	      }

        	  })
          

        	  // 비밀번호 확인 유효성 검사

        	  // 함수명() : 함수 호출(수행)
        	  // 함수명   : 함수에 작성된 코드 반환

        	  newPwd2.addEventListener("input", checkPwd);
        	  // -> 이벤트가 발생되었을 때 정의된 함수를 호출하겠다.

        	  function checkPwd(){ // 비밀번호 일치 검사

        	      // 비밀번호 / 비밀번호 확인이 같을 경우
        	      if(newPwd2.value == newPwd.value){
        	          pwdMessage.innerText = "비밀번호가 일치합니다.";
        	          pwdMessage.classList.add("success");
        	          pwdMessage.classList.remove("error");
        	          checkObj.newPwd2 = true; // 유효 O 기록

        	      }else{
        	          pwdMessage.innerText = "비밀번호가 일치하지 않습니다.";
        	          pwdMessage.classList.add("error");
        	          pwdMessage.classList.remove("success");
        	          checkObj.newPwd2 = false; // 유효 X 기록
        	      }
        	  }
        	  
          
        	  
        	 
        	  
        	  function allCheck(){

        		    // checkObj에 있는 모든 속성을 반복 접근하여
        		    // false가 하나라도 있는 경우에는 form태그 기본 이벤트 제거

        		    let str;

        		    for(let key in checkObj){ // 객체용 향상된 for문

        		        // 현재 접근 중인 key의 value가 false인 경우
        		        if(!checkObj[key]){

        		            switch(key){
        		                case "newPwd"         : str = "비밀번호가"; break;
        		                case "newPwd2"  : str = "비밀번호 확인이"; break;
        		            }

        		            str += " 유효하지 않습니다.";

        		            alert(str);

        		            document.getElementById(key).focus();

        		            return false; // form태그 기본 이벤트 제거
        		        }
        		    }
        		    var mfm = document.mFrm;
            		
            		mfm.method = "post";
            		mfm.action = "<%=request.getContextPath()%>/mypage/userUpdatePwd.do"; //처리하기위해 이동하는 주소
            		mfm.submit();
        		    return true; // form태그 기본 이벤트 수행

        		}


        	    

	function byeUser(){
		
		var mfm = document.mFrm;
		
		mfm.method = "post";
		mfm.action = "<%=request.getContextPath()%>/mypage/userBye.do"; //처리하기위해 이동하는 주소
		mfm.submit();
	    return true; // form태그 기본 이벤트 수행

		
		
	}
        	
          
          </script>

</body>
</html>