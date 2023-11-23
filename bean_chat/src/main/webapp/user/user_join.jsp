<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>회원가입</title>
    <!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/user/user_join.css" rel="stylesheet" />
    <!-- 제이쿼리 연결 -->
    <script
      src="https://code.jquery.com/jquery-3.6.1.min.js"
      integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
      crossorigin="anonymous">
    </script>
     <script>
     function userLoginNull(){
 	    
  	   
	        alert("로그인 후 이용해주세요.");
     }
     </script>
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
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="userLoginNull()"><img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
	        				</c:when>
	            			<c:otherwise>
	            				<a href="<%=request.getContextPath()%>/user/userLogout.do" onclick="return confirm('로그아웃 하시겠습니까?')"><img role="button" src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
	            			</c:otherwise>
	            		</c:choose>
	            	</li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="userLoginNull()"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
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
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="userLoginNull()"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
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
          
				<!-- 아이디 -->
				<label for="userId">
					<span class="required">*</span> 
					아이디(이메일)
				</label>

				<!-- 아이디 input창 -->
				<div class="input_area">
					<input type="text" id="userId" name="userId" placeholder="아이디(이메일)" maxlength="30" autocomplete="off" required/>
					<!-- autocomplete="off" : 자동 완성 미사용 -->
					<!-- required : 필수 작성 input 태그 -->

					<button type="button" class="custom-button">인증번호 받기</button>
            	</div><!-- //.input_area -->

				<!-- 아이디 message -->
				<span class="message" id="idMessage">
            		메일을 받을 수 있는 이메일을 입력해 주세요.
				</span >
				<br />

				<!-- 이메일 인증번호 -->
				<label for="emailCheck">
					<span class="required">*</span>
					인증번호
            	</label>

				<!-- 인증번호 input창 -->
				<div class="input_area">
					<input type="text" id="emailCheck" placeholder="인증번호 입력" maxlength="6" autocomplete="off"/>
					<button type="button" class="custom-button">인증하기</button>
            	</div><!-- //.input_area -->

				<!-- 인증번호 message -->
				<!-- <span class="message_success">인증되었습니다.</span> -->

				<!-- 비밀번호 -->
				<label for="userPwd">
					<span class="required">*</span>
					비밀번호
				</label>

	            <!-- 비밀번호 input창 -->
	            <div class="input_area">
	              <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호" maxlength="30"/>
	            </div><!-- //.input_area -->

	            <!-- 비밀번호확인 input창 -->
	            <div class="input_area">
	              <input type="password" id="userPwd2"placeholder="비밀번호 확인" maxlength="30"/>
	            </div><!-- //.input_area -->

	            <!-- 비밀번호 message -->
				<span class="message" id="pwdMessage" >
						영어, 숫자, 특수문자(!,@,#,-,_) 6~30글자 사이로 작성해주세요.
				</span>
				<br />
             
	            <!-- 이름 -->
	            <label for="userName"> 
	            	<span class="required">*</span> 
	            	이름 
	            </label>

	            <!-- 이름 input창 -->
	            <div class="input_area">
	              <input type="text" name="userName" />
	            </div><!-- //.input_area -->

	            <!-- 닉네임 -->
	            <label for="userNickname">
	              <span class="required">*</span>
	              닉네임
	            </label>

	            <!-- 닉네임 input창 -->
	            <div class="input_area">
	              <input type="text" id="userNickname" name="userNickname" placeholder="닉네임" maxlength="10"/>
	            </div><!-- //.input_area -->

	            <!-- 닉네임 message -->
	            <span class="message" id="nicknameMessage">
	            	영어/숫자/한글 2~10글자 사이로 작성해주세요.
	            </span>
	            <br />
	            
	            <!-- 생년월일 -->
	            
	            <label for="userBirth">
	              <span class="required">*</span>
	              생년월일
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
		            			<option value="<%= formattedMonth %>" <%= (formattedMonth.equals(userMonth)) ? "selected" : "" %>><%= formattedMonth %></option>
		       					 <% } %>
						    </select>
						    <p>월</p>
						    <select name="userDay" id="userDay">
						        <% 
						            for (int day = 1; day <= 31; day++) {
						            	 String formattedDay = String.format("%02d", day); // 일을 2자리로 표현
						        %>
						           <option value="<%= formattedDay %>" selected" : " %>><%= formattedDay %></option>
						        <% } %>
	   						</select>
	   						<p>일</p>
						</div><!-- //#userBirth -->
	              <select name="userYear">
	                <option value="1960">1960</option>
	                <option value="1961">1961</option>
	                <option value="1962">1962</option>
	                <option value="1963">1963</option>
	                <option value="1964">1964</option>
	                <option value="1965">1965</option>
	                <option value="1966">1966</option>
	                <option value="1967">1967</option>
	                <option value="1968">1968</option>
	                <option value="1969">1969</option>
	                <option value="1970">1970</option>
	                <option value="1971">1971</option>
	                <option value="1972">1972</option>
	                <option value="1973">1973</option>
	                <option value="1974">1974</option>
	                <option value="1975">1975</option>
	                <option value="1976">1976</option>
	                <option value="1977">1977</option>
	                <option value="1978">1978</option>
	                <option value="1979">1979</option>
	                <option value="1980">1980</option>
	                <option value="1981">1981</option>
	                <option value="1982">1982</option>
	                <option value="1983">1983</option>
	                <option value="1984">1984</option>
	                <option value="1985">1985</option>
	                <option value="1986">1986</option>
	                <option value="1987">1987</option>
	                <option value="1988">1988</option>
	                <option value="1989">1989</option>
	                <option value="1990">1990</option>
	                <option value="1991">1991</option>
	                <option value="1992">1992</option>
	                <option value="1993">1993</option>
	                <option value="1994">1994</option>
	                <option value="1995">1995</option>
	                <option value="1996">1996</option>
	                <option value="1997" selected>1997</option>
	                <option value="1998">1998</option>
	                <option value="1999">1999</option>
	                <option value="2001">2001</option>
	                <option value="2002">2002</option>
	                <option value="2003">2003</option>
	                <option value="2004">2004</option>
	                <option value="2005">2005</option>
	                <option value="2006">2006</option>
	                <option value="2007">2007</option>
	                <option value="2008">2008</option>
	                <option value="2009">2009</option>
	                <option value="2010">2010</option>
	                <option value="2011">2011</option>
	                <option value="2012">2012</option>
	                <option value="2013">2013</option>
	                <option value="2014">2014</option>
	                <option value="2015">2015</option>
	                <option value="2016">2016</option>
	                <option value="2017">2017</option>
	                <option value="2018">2018</option>
	                <option value="2019">2019</option>
	                <option value="2020">2020</option>
	                <option value="2021">2021</option>
	                <option value="2022">2022</option>
	                <option value="2023">2023</option>
	              </select>
	              <p>년</p>
	              <select name="userMonth">
	                <option value="01"  selected>01</option>
	                <option value="02">02</option>
	                <option value="03">03</option>
	                <option value="04">04</option>
	                <option value="05">05</option>
	                <option value="06">06</option>
	                <option value="07">07</option>
	                <option value="08">08</option>
	                <option value="09">09</option>
	                <option value="10">10</option>
	                <option value="11">11</option>
	                <option value="12">12</option>
	              </select>
	              <p>월</p>
	              <select name="userDay">
	                <option value="01" selected>01</option>
	                <option value="02">02</option>
	                <option value="03">03</option>
	                <option value="04">04</option>
	                <option value="05">05</option>
	                <option value="06">06</option>
	                <option value="07">07</option>
	                <option value="08">08</option>
	                <option value="09">09</option>
	                <option value="10">10</option>
	                <option value="11">11</option>
	                <option value="12">12</option>
	                <option value="13">13</option>
	                <option value="14">14</option>
	                <option value="15">15</option>
	                <option value="16">16</option>
	                <option value="17">17</option>
	                <option value="18">18</option>
	                <option value="19">19</option>
	                <option value="20">20</option>
	                <option value="21">21</option>
	                <option value="22">22</option>
	                <option value="23">23</option>
	                <option value="24">24</option>
	                <option value="25">25</option>
	                <option value="26">26</option>
	                <option value="27">27</option>
	                <option value="28">28</option>
	                <option value="29">29</option>
	                <option value="30">30</option>
	                <option value="31">31</option>
	              </select>
	              <p>일</p>
	            </div><!-- //.input_area -->

	            <!-- 성별 -->
	            <label for="userGender">
	              <span class="required">*</span>
	              성별
	            </label>

	            <!-- 성별 input창 -->
	            <div class="input_area">
	              <input type="radio" name="userGender" value="남성" style="width: 20px; height: 20px; border: 1px solid black; font-size: 120%; "/>
					남성

	              <input type="radio" name="userGender" value="여성" style="width: 20px;height: 20px; border: 1px solid black; font-size: 120%; margin-left: 40%;" checked/>
					여성
				</div> <!-- //.input_area -->


	            <!-- 전화번호 -->
	            <label for="userPhone">
	              <span class="required">*</span>
	              전화번호
	            </label>

	            <!-- 전화번호 input창 -->
	            <div class="input_area">
	              <input type="text" id="userPhone" name="userPhone" placeholder="(- 없이 숫자만 입력)" maxlength="11" />
	            </div><!-- //.input_area -->

	            <!-- 전화번호 message -->
	            <span class="message" id="phoneMessage">전화번호를 입력해주세요.(- 제외)</span>

				<button type="submit" id="btn">가입하기</button>
          	</form>
		</div><!-- //#main_zone -->
	</main>
    <footer>
		<div>푸터입니당</div>
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
    </script>
  </body>
</html>
