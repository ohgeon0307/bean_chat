<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>회원가입</title>
    <!-- 제이쿼리 연결 -->
    <script
      src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous">
    </script>
    <!-- css연결 -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/user/user_join.css" rel="stylesheet" />
  </head>
  <body>
	<header><!-- 헤더 시작 -->
		<div class="container"> 
			<a href="../index.jsp"><img role="button" src="../images/indexImage/beanchat_text.png" alt="" class="beanchat_text"></a> 
	        <div class="items">
	            <ul>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"><img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
	        				</c:when>
	            			<c:otherwise>
	            				<a href="<%=request.getContextPath()%>/user/userLogout.do" onclick="return confirm('로그아웃 하시겠습니까?')"><img role="button" src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
	            			</c:otherwise>
	            		</c:choose>
	            	</li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="<%=request.getContextPath()%>/mypage/myMain.do"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
	                		</c:otherwise>
	                	</c:choose>
	                </li>
	                <li><a href="<%=request.getContextPath()%>/board/boardList.do"><img role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a></li>
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

    <main><!-- 메인 시작 -->
		<div id="main_zone">
			<form name="frm" onsubmit="return allCheck()">
				<div id="title_text">
					<h1>회원가입</h1>
					<p>빈챗의 회원이 되어 우리 함께해요<i class="xi-emoticon-happy-o"></i></p>
				</div><!-- //#title_text -->
				
				<div id="user_input">
				<!-- 아이디 -->
				<div class="fake">
					<label for="userId">
						<img class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지">
						ID(이메일) :
					</label>
		
					<!-- 아이디 input창 -->
					<div class="input_area">
						<input type="text" id="userId" name="userId" placeholder="아이디(이메일)" maxlength="30" autocomplete="off" required/>
						<!-- autocomplete="off" : 자동 완성 미사용 -->
						<!-- required : 필수 작성 input 태그 -->
	
						<button type="button" class="custom-button">인증번호 받기</button>
	            	</div><!-- //.input_area -->
					<!-- 이메일 인증번호 -->
			</div>
				<!-- 아이디 message -->
				<span class="message" id="idMessage">
            		메일을 받을 수 있는 이메일을 입력해 주세요.
				</span >

				<!-- 인증번호 input창 -->
			<div class="fake">
					<label for="emailCheck">
						<img class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지">
						인증번호 :
	            	</label>
				<div class="input_area">
					<input type="text" id="emailCheck" placeholder="인증번호 입력" maxlength="6" autocomplete="off"/>
					<button type="button" class="custom-button">인증하기</button>
            	</div><!-- //.input_area -->
			</div>
				<!-- 인증번호 message -->
				<!-- <span class="message_success">인증되었습니다.</span> -->

				<!-- 비밀번호 -->
				<div class="fake">
					<label for="userPwd">
						<img class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지">
						비밀번호 :
					</label>
	
		            <!-- 비밀번호 input창 -->
		            <div class="input_area" id="userPwdInput">
		              <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호" maxlength="30"/>
		            </div><!-- //.input_area -->
				</div>
	
		            <!-- 비밀번호확인 input창 -->
		            <div class="input_area" id="userPwd2Input">
		              <input type="password" id="userPwd2"placeholder="비밀번호 확인" maxlength="30"/>
		            </div><!-- //.input_area -->
				
	            <!-- 비밀번호 message -->
				<span class="message" id="pwdMessage" >
						영어, 숫자, 특수문자(!,@,#,-,_) 6~30글자 사이로 작성해주세요.
				</span>

             
	            <!-- 이름 -->
	            <div class="fake">
		            
		            <label for="userName"> 
		            	<img class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지">
		            	이름 :
		            </label>
	
		            <!-- 이름 input창 -->
		            <div class="input_area">
		              <input type="text" name="userName" />
		            </div><!-- //.input_area -->
		        </div>

	            <!-- 닉네임 -->
	            <div class="fake">
	            
		            <label for="userNickname">
		              <img  class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지">
		              닉네임 :
		            </label>
	
		            <!-- 닉네임 input창 -->
		            <div class="input_area">
		              <input type="text" id="userNickname" name="userNickname" placeholder="닉네임" maxlength="10"/>
		            </div><!-- //.input_area -->
				</div>
				
	            <!-- 닉네임 message -->
	            <span class="message" id="nicknameMessage">
	            	영어/숫자/한글 2~10글자 사이로 작성해주세요.
	            </span>
	            
	            
	            <!-- 생년월일 -->
	            <div class="fake">
	            
		            <label for="userBirth">
		              <img  class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지">
		              생년월일 :
		            </label>
		            <!-- 생년월일  input창 -->
		            <div class="input_area">
						<select name="userYear" id="userYear">
	        				<% 
	           				 for (int year = 1950; year <= 2023; year++) {
	           					 String formattedYear = String.format("%04d", year); // 연도를 4자리로 표현
	       					 %>
	           				  <option value="<%= formattedYear %>" <%= (year == 2000) ? "selected" : "" %>><%= formattedYear %></option>
	  							<% } %>
	   					</select>
	   					<p>년</p>
	   					<select name="userMonth" id="userMonth">
	        				<% 
	            			for (int month = 1; month <= 12; month++) {
	            				 String formattedMonth = String.format("%02d", month); // 월을 2자리로 표현
	       					 %>
	            			 <option value="<%= formattedMonth %>" <%= (month == 1) ? "selected" : "" %>><%= formattedMonth %></option>
	  							<% } %>
					    </select>
					    <p>월</p>
					    <select name="userDay" id="userDay">
					        <% 
					            for (int day = 1; day <= 31; day++) {
					            	 String formattedDay = String.format("%02d", day); // 일을 2자리로 표현
					        %>
					        <option value="<%= formattedDay %>" <%= (day == 1) ? "selected" : "" %>><%= formattedDay %></option>
	  						<% } %>
	  					</select>
	  					<p>일</p>
		           	 </div><!-- //.input_area -->
				</div>
				
				
	            <!-- 성별 -->
	            <div class="fake">
		            
		            <label for="userGender">
		              <img class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지">
		              성별 :
		            </label>

		            <!-- 성별 input창 -->
		            <div class="input_area" id="genderInput">
		              <input type="radio" name="userGender" value="남성" style="width: 20px; height: 20px; border: 1px solid black; font-size: 14px; "/>
						남성
	
		              <input type="radio" name="userGender" value="여성" style="width: 20px;height: 20px; border: 1px solid black; font-size: 14px; margin-left: 40%;" checked/>
						여성
					</div> <!-- //.input_area -->
				</div>


	            <!-- 전화번호 -->
	            <div class="fake">
		            <label for="userPhone">
		              <img  class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지">
		              전화번호 :
		            </label>
	
		            <!-- 전화번호 input창 -->
		            <div class="input_area">
		              <input type="text" id="userPhone" name="userPhone" placeholder="(- 없이 숫자만 입력)" maxlength="11" />
		            </div><!-- //.input_area -->
		          </div>

	            <!-- 전화번호 message -->
					<span class="message" id="phoneMessage">전화번호를 입력해주세요.(- 제외)</span>
				</div>
				<div class="button_zone">
					<button type="submit" id="btn" value="가입">가입</button>
					<button type="button" class="backBtn" name="cancle" value="취소"onClick="history.back()">취소</button>
				</div>
          	</form>
		</div><!-- //#main_zone -->
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

    <script>
      const checkObj = {
        userId: false,
        userPwd: false,
        userPwd2: false,
        userNickname: false,
        userPhone: false,
      };

      var fm = document.frm;

      //전화번호 유효성 검사

      const userPhone = fm.userPhone;
      const phoneMessage = document.getElementById("phoneMessage");

      // ** input 이벤트 **
      // -> 입력과 관련된 모든 동작(key 관련, mouse 관련, 붙여넣기 등)
      userPhone.addEventListener("input", function () {
        // 입력이 되지 않은 경우
        if (userPhone.value.trim().length == 0) {
          phoneMessage.innerText = "전화번호를 입력해주세요.(- 제외)";
          // telMessage.classList.remove("error");
          // telMessage.classList.remove("success");
          phoneMessage.classList.remove("success", "error");

          return;
        }

        // 전화번호 정규식
        const regExp = /^0(1[01679]|2|[3-6][1-5]|70)\d{3,4}\d{4}$/;

        if (regExp.test(userPhone.value)) {
          // 유효한 경우
          phoneMessage.innerText = "유효한 전화번호 형식입니다.";
          phoneMessage.classList.add("success");
          phoneMessage.classList.remove("error");
          checkObj.userPhone = true;
        } else {
          // 유효하지 않은 경우
          phoneMessage.innerText = "전화번호 형식이 올바르지 않습니다.";
          phoneMessage.classList.add("error");
          phoneMessage.classList.remove("success");
          checkObj.userPhone = false;
        }
      });

      const userId = fm.userId;
      const idMessage = document.querySelector("#idMessage");

      userId.addEventListener("input", function () {
        // 입력이 되지 않은 경우
        if (userId.value.trim().length == 0) {
          idMessage.innerText = "메일을 받을 수 있는 이메일을 입력해 주세요.";
          idMessage.classList.remove("success", "error");

          checkObj.userId = false; // 유효 X 기록
          return;
        }

        // 입력된 경우
        const regExp =
          /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

        if (regExp.test(userId.value)) {
          let userId = $("#userId").val();

          $.ajax({
            type: "post",
            url: "./user_id_check.jsp",
            data: { userId: userId },
            dataType: "json",
            success: function (data) {
              //alert("성공");
              //alert(data.cnt);
              if (data.cnt == 1) {
                idMessage.innerText = "이미 사용 중인 이메일입니다.";
                idMessage.classList.add("error");
                idMessage.classList.remove("success");

                checkObj.userId = false;
              } else {
                idMessage.innerText = "사용 가능한 이메일입니다.";
                idMessage.classList.add("success");
                idMessage.classList.remove("error");

                checkObj.userId = true;
              }
            },
            error: function () {
              alert("실패");
            },
          });
        } else {
          // 유효하지 않은 경우
          idMessage.innerText = "이메일 형식이 유효하지 않습니다.";
          idMessage.classList.add("error");
          idMessage.classList.remove("success");
          checkObj.userId = false;
        }
      });

      // 닉네임 유효성 검사
      const userNickname = document.frm.userNickname;
      const nicknameMessage = document.getElementById("nicknameMessage");

      userNickname.addEventListener("input", function () {
        // 입력되지 않은 경우
        if (userNickname.value.trim().length == 0) {
          nicknameMessage.innerText =
            "영어/숫자/한글 2~10자 사이로 작성해주세요.";
          nicknameMessage.classList.remove("success", "error");

          return;
        }

        const regExp = /^[a-zA-Z0-9가-힣]{2,10}$/;

        if (regExp.test(userNickname.value)) {
          // 유효한 경우
          nicknameMessage.innerText = "유효한 닉네임 형식입니다.";
          nicknameMessage.classList.add("success");
          nicknameMessage.classList.remove("error");
          checkObj.userNickname = true;
        } else {
          nicknameMessage.innerText = "닉네임 형식이 유효하지 않습니다.";
          nicknameMessage.classList.add("error");
          nicknameMessage.classList.remove("success");
          checkObj.userNickname = false;
        }
      });

      const userPwd = document.frm.userPwd;
      const userPwd2 = document.frm.userPwd2;
      const pwdMessage = document.getElementById("pwdMessage");

      userPwd.addEventListener("input", function () {
        if (userPwd.value.trim().length == 0) {
          pwdMessage.innerText =
            "영어, 숫자, 특수문자(!,@,#,-,_) 6~30글자 사이로 작성해주세요.";
          pwdMessage.classList.remove("success", "error");

          checkObj.userPwd = false;

          return;
        }

        // const regExp = /^[a-zA-Z0-9!@#_-]{6,30}$/;
        const regExp = /^[\w!@#_-]{6,30}$/;

        if (regExp.test(userPwd.value)) {
          // 비밀번호 유효한 경우

          checkObj.userPwd = true;

          if (userPwd2.value.trim().length == 0) {
            // 비밀번호 유효, 비밀번호 확인 작성 X
            pwdMessage.innerText = "유효한 비밀번호 형식입니다.";
            pwdMessage.classList.add("success");
            pwdMessage.classList.remove("error");
          } else {
            // 비밀번호 유효, 확인 작성 O
            checkPwd(); // 비밀번호 일치 검사 함수 호출()
          }
        } else {
          pwdMessage.innerText = "비밀번호 형식이 유효하지 않습니다.";
          pwdMessage.classList.add("error");
          pwdMessage.classList.remove("success");
          checkObj.userPwd = false;
        }
      });

      userPwd2.addEventListener("input", checkPwd);
      // -> 이벤트가 발생되었을 때 정의된 함수를 호출하겠다.

      function checkPwd() {
        // 비밀번호 일치 검사

        // 비밀번호 / 비밀번호 확인이 같을 경우
        if (userPwd2.value == userPwd.value) {
          pwdMessage.innerText = "비밀번호가 일치합니다.";
          pwdMessage.classList.add("success");
          pwdMessage.classList.remove("error");
          checkObj.userPwd2 = true;
        } else {
          pwdMessage.innerText = "비밀번호가 일치하지 않습니다.";
          pwdMessage.classList.add("error");
          pwdMessage.classList.remove("success");
          checkObj.userPwd2 = false;
        }
      }

      function allCheck() {
        // checkObj에 있는 모든 속성을 반복 접근하여
        // false가 하나라도 있는 경우에는 form태그 기본 이벤트 제거

        let str;

        for (let key in checkObj) {
          // 객체용 향상된 for문

          // 현재 접근 중인 key의 value가 false인 경우
          if (!checkObj[key]) {
            switch (key) {
              case "userId":
                str = "이메일이";
                break;
              case "userPwd":
                str = "비밀번호가";
                break;
              case "userPwd2":
                str = "비밀번호 확인이";
                break;
              case "userNickname":
                str = "닉네임이";
                break;
              case "userPhone":
                str = "전화번호가";
                break;
            }

            str += " 유효하지 않습니다.";

            alert(str);

            document.getElementById(key).focus();

            return false;
          }
        }

        fm.action = "<%=request.getContextPath()%>/user/userJoinAction.do"; //처리하기위해 이동하는 주소
        fm.method = "post"; //이동하는 방식  get 노출시킴 post 감추어서 전달
        fm.submit(); //전송시킴
        return true;
      }
      
      $(".logo").click(function(){	
      	if(!confirm("메인으로 돌아가시겠습니까?")){
				return false;
      	}else{
      		location.href="<%=request.getContextPath()%>";
      	}
      	
       });
    </script>
  </body>
</html>
