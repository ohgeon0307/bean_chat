<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<!-- 아이콘 연결 -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
	<link href="../css/user/user_find_id_pwd.css" rel="stylesheet" />
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
		                 <li>
	                	<c:choose>
	                		<c:when test="${uidx==null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"  onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="<%=request.getContextPath() %>/board/boardList.do"><img role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a>
	                		</c:otherwise>
	                	</c:choose>
	                </li>
	                <li>
	                <c:choose>
	                	<c:when test="${uidx==null }">
	                		<a href="<%=request.getContextPath()%>/user/userLogin.do"  onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/announcement_icon.png" alt=""><span>공지사항</span></a>
	                	</c:when>
	                	<c:otherwise>
	                		<a  href="<%=request.getContextPath()%>/notice/noticeList.do"><img role="button" src="../images/indexImage/announcement_icon.png" alt=""><span>공지사항</span></a>
	              		 </c:otherwise>
	                	</c:choose>
	                </li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"  onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="<%=request.getContextPath()%>/chat/chatIndex.do"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
	                		</c:otherwise>
	                	</c:choose>
	                </li>	
	            </ul>
			</div><!-- //.items -->
		</div> <!-- //.container -->
	</header><!-- 헤더 종료 -->

	<main>
		<!-- 아이디/비밀번호 탭 -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">아이디 찾기</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">비밀번호 찾기</button>
			</li>
		</ul>
		<!-- 위에 탭 종료 -->
		
		<!-- 탭 컨텐츠 -->
		<div class="tab-content" id="myTabContent">
		<!-- 아이디 찾기 -->
			<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
			
				<form name="frm">
					<div class = "search-title">
							<h1>아이디 찾기</h1>
							<p>가입할 때 입력 한 정보를 정확하게 입력해주셔야 찾을 수 있어요!</p>
					</div><!-- //.search-title -->
					
					<section class = "form-search">
						<div class = "find-name">
							
							<label><img class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지"> 이름 :</label>
							<div class="input_area">
								<input type="text" name="userName" id="userName" class = "btn-name" placeholder = "등록한 이름">
							</div>
						</div><!-- //.find-name -->
						
						<div class = "find-phone">
							
							<label><img class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지"> 전화번호 :</label>
							<div class="input_area">
								<input type="text" name="userPhone" id="userPhone" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력" maxlength="11">
							</div>
						</div><!-- //.find-phone -->
					</section><!-- form-search -->
					
					<!-- 아이디찾기 버튼 -->
					<div class ="btnSearch">
						<input type="button" class="findBtn" name="enter" value="찾기"  onClick="idSearch()">
						<input type="button"  class="backBtn" name="cancle" value="취소" onClick="history.back()">
				 	</div><!-- //.btnSearch -->
				</form><!-- end form frm -->
				
			</div><!-- .//tab-pane fade show active -->
			
			<!-- 비밀번호 찾기 -->
			<div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
			
				<form name="pfrm">
				
					<div class = "search-title">
						<h1>비밀번호 찾기</h1>
						<p>가입할 때 입력 한 이메일(ID)로 임시비밀번호를 발송해드려요!</p>
					</div><!-- //.search-title -->
					
					<section class = "form-search">
						<div class = "find-name">
							
							<label><img class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지"> 이름 :</label>
							<div class="input_area">
								<input type="text" name="userName" class = "btn-name" placeholder = "등록한 이름">
							</div>
						</div><!-- //.find-name -->
						
						<div class = "find-email">
							
							<label><img class="laBean" src="../images/indexImage/poorBean.png" alt="콩이미지"> 이메일(ID) :</label>
							<div class="input_area">
								<input type="text" name="userId" class = "btn-Email" placeholder = "메일주소를 정확히 입력해주세요">
							</div>
						</div><!-- //.find-email -->
					</section><!-- //.form-search -->
					
					<div class ="btnSearch">
						<input type="button" class="findBtn" name="enter" value="찾기"  onClick="pwdSearch()">
						<input type="button"  class="backBtn" name="cancle" value="취소" onClick="history.back()">
					</div><!-- //.btnSearch -->
				</form><!-- end form pfrm -->
				
			</div><!-- tab-pane fade -->
		</div><!-- //.tab-content -->
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
	
	<form name="frm">
		<!-- 아이디 찾기 성공 시 보여질 Modal -->
		<div class="modal" id="successModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
				
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">아이디 찾기 성공!</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div><!-- //.modal-header -->
					
					<!-- Modal body -->
					<div class="modal-body">
						<div class="found-success">
							<h4>회원님의 아이디는 <span id="userIdText" class="result_id"></span>  입니다</h4>
						</div><!-- //.found-success -->
						<div class="result_img">
							<img src="../images/logo/BeanChatPicLogo.png" />
						</div><!-- //.result_img -->
					</div><!-- //.modal-body -->
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<a href="<%=request.getContextPath()%>/user/userLogin.do"><button type="button" id="btnLogin">로그인 하러가기</button></a>
						<button type="button" id="clodelModalBtn" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div><!-- //.modal-footer -->

				</div><!-- //.modal-content -->
			</div><!-- //.modal-dialog modal-dialog-centered -->
		</div><!-- //#successModal -->
		
		
		<div class="modal" id="failModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
				
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">등록된 정보가 없습니다</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div><!-- //.modal-header -->

					<!-- Modal body -->
					<div class="modal-body">
						<div class="found-fail">
							<h4>아이디 찾기 실패ㅠ0ㅠ 다시 입력해주세요.</h4>
						</div><!-- //found-fail -->
						<div class="result_img">
							<img src="../images/indexImage/BeanchatNoAccess.png" />
						</div><!-- //.result_img -->
						
						
					</div><!-- //.modal-body -->
		
					<!-- Modal footer -->
					<div class="modal-footer">
						<a href="<%=request.getContextPath()%>/user/userJoin.do"><button type="button" id="btnJoin">회원가입 하러 가기</button></a>
						<button type="button" id="clodelModalBtn" class="btn btn-default" data-dismiss="modal">다시 찾기</button>
					</div><!-- //.modal-footer -->

				</div><!-- //.modal-content -->
					</div><!-- //.modal-dialog modal-dialog-centered -->
				</div><!-- //#delModal -->
					
		</form>
	
	
	
	<!-- 탭 활성화 스크립트 -->
	 <script>
	 document.addEventListener('DOMContentLoaded', function() {
		    var tabTriggerList = document.querySelectorAll('#myTab button[data-bs-toggle="tab"]');
		    tabTriggerList.forEach(function(tabTrigger) {
				tabTrigger.addEventListener('click', function(event) {
		            event.preventDefault();
		            var tabTarget = document.querySelector(this.getAttribute('data-bs-target'));
		            var activeTab = document.querySelector('.tab-pane.fade.show.active');
		            activeTab.classList.remove('show', 'active');
		            tabTarget.classList.add('show', 'active');
		            
		            // 탭 CSS 클래스 변경 선택 탭 강조
		            var activeTabBtn = document.querySelector('.nav-link.active');
		            activeTabBtn.classList.remove('active');
		            this.classList.add('active');
		        });
		    });
		});
	 </script>
	 
	 <!-- 아이디 찾기 유효성검사, 액션 -->
	 
	 <script>
    function idSearch() { 
		var userName = $('#userName').val();
		var userPhone = $('#userPhone').val();

        // 유효성 검사
        if (userName.length < 1) {
            alert("이름을 입력해주세요");
            return;
        }
        // 휴대폰 번호 형식 검사
        const regExp = /^0(1[01679]|2|[3-6][1-5]|70)\d{3,4}\d{4}$/;
        if (userPhone.length !== 11 || !regExp.test(userPhone)) {
            alert("유효한 휴대폰 번호를 입력해주세요");
            return;
        }

        // 서버로 요청을 보내기 위한 AJAX 요청
        $.ajax({
            type: "POST",
            url: '/bean_chat/user/userFindIdAction.do',
            data: {
            	userName: userName,
                userPhone: userPhone
            },
            success: function(data) {
            	 if (data.userIdFind != 'null') {
            		 openSuccessModal(); // 아이디가 존재하는 경우 성공 모달 띄우기
            	     $('#userIdText').text(data.userIdFind); // 찾은 아이디 표시
                } else if(data.userIdFind == 'null'){
                    openFailModal(); // 아이디가 존재하지 않는 경우 실패 모달 띄우기
                }
            },
            error: function() {
                // 에러 발생 시 처리
            }
        });
    }
	</script>
	 <script>
		<!-- 비밀번호 찾기 유효성검사, 액션 -->
		function pwdSearch() { 
			var pfm = document.pfrm;
			const regExp =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
			if (pfm.userName.value.length < 1) {
				alert("이름을 입력해주세요");
				return;
			}if (pfm.userId.value.length < 1) {
				alert("아이디를 입력해주세요");
				return;
			}if (!regExp.test(pfm.userId.value)) {
				alert("이메일 형식이 올바르지 않습니다");
				return;
			}
			
			pfm.method = "post";
			pfm.action = "<%=request.getContextPath()%>/user/userFindPwdAction.do";
			pfm.submit();  
			return true;
		 }
		
	 
 		// 모달 버튼에 이벤트를 건다.  
	   function openSuccessModal() {
	        $('#successModal').modal('show');
	    }

	    // 실패 모달 띄우기
	    function openFailModal() {
	        $('#failModal').modal('show');
	    }
	    
	    
	    
	    function userJoin(){
	    	var fm = document.frm;
	    	fm.action = "<%=request.getContextPath()%>/user/userJoin.do";
	    }
	    
	    function login(){
	    	var fm = document.frm;
	    	fm.action = "<%=request.getContextPath()%>/user/userLogin.do";
	    }
	</script>

</body>
</html>