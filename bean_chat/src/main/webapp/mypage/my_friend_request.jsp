<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구요청수락</title>
	<!-- 제이쿼리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"> </script>
	<!-- 부트스트랩 연결 -->
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link href="../css/mypage/my_friend_request.css" rel="stylesheet" /> 
	
	<script type="text/javascript">
	function myRequestList() {
	    $.ajax({
	        url: '/bean_chat/friend/myRequestList.do',
	        type: 'POST',
	        dataType: 'json',
	        success: function (data) {
	            var requestList = $('#requestList');
	            var sendRequestList = $('#sendRequestList');
	            var receivedRequests = data.receivedRequests; // 받은 요청 목록
	            var sentRequests = data.sentRequests; // 보낸 요청 목록
	            
	            requestList.empty(); // 기존 목록 비워줌
	            sendRequestList.empty(); // 기존 목록 비워줌

	            for (var i = 0; i < receivedRequests.length; i++) {
	                var listItem = $('<li>');

	                var userInfo = $('<div>').html(
	                		receivedRequests[i].userId + '<br>' +
	                    '친구 이름: ' + receivedRequests[i].userName + '<br>' +
	                    '친구 닉네임: ' + receivedRequests[i].userNickname + '<br>' +
	                    '친구 생일: ' + receivedRequests[i].userBirth + '<br>'
	                );

	                var profileImage = $('<img>').attr('src', '../' + receivedRequests[i].userImage).attr('id', 'profile-image');

	                var acceptBtn = $('<button>').text('수락');
	                var rejectBtn = $('<button>').text('거절');
	                
	                createClickHandlers(acceptBtn, rejectBtn, receivedRequests[i].userId);

	                listItem.append(profileImage, userInfo, acceptBtn, rejectBtn);
	                requestList.append(listItem);
	            }
		         // 보낸 요청 목록 처리
	            for (var j = 0; j < sentRequests.length; j++) {
	            
	                var listItem = $('<li>');

	                var userInfo = $('<div>').html(
	                	sentRequests[i].userId + '<br>' +
	                    '친구 이름: ' + sentRequests[i].userName + '<br>' +
	                    '친구 닉네임: ' + sentRequests[i].userNickname + '<br>' +
	                    '친구 생일: ' + sentRequests[i].userBirth + '<br>'
	                );

	                var profileImage = $('<img>').attr('src', '../' + sentRequests[i].userImage).attr('id', 'profile-image');

	                listItem.append(profileImage, userInfo);
	                sendRequestList.append(listItem);
	            }

	        },
	       
	        error: function (error) {
	            console.error(error);
	        }
	    });
	}      
	function createClickHandlers(acceptBtn, rejectBtn, currentUserId) {                
	                // 수락 버튼 클릭 시 이벤트 핸들러
	                acceptBtn.click(function () {

	                	/*  var currentUserId = $(this).parent().find('button').attr('data-userId'); // 해당 요청의 userId 가져오기*/
	                	 var listItemRemove = $(this).closest('li'); // 클릭한 버튼의 부모 li 요소를 찾음
	                        
	                        $.ajax({
	                            url: '/bean_chat/friend/myRequestAccept.do?userId=' + currentUserId,
	                            type: 'POST',
	                            dataType: 'json',
	                            success: function (data) {
	                                if (data.success) {
	                                    alert('친구 요청을 수락했습니다.');
	                                    listItemRemove.remove();
	                                } else {
	                                    alert('친구 요청 수락에 실패했습니다.');
	                                }
	                            },
	                            error: function (error) {
	                                console.error(error);
	                            }
	                        });
	                });
	                
	                
	                
	         	 rejectBtn.click(function () {
					/* var currentUserId = $(this).parent().find('button').attr('data-userId'); // 해당 요청의 userId 가져오기*/
	         	    var listItemRemove = $(this).closest('li'); // 클릭한 버튼의 부모 li 요소를 찾음 
	                        
	                        $.ajax({
	                            url: '/bean_chat/friend/myRequestReject.do?userId=' + currentUserId,
	                            type: 'POST',
	                            dataType: 'json',
	                            success: function (data) {
	                                if (data.success) {
	                                    alert('친구 요청을 거절했습니다.');
	                                    listItemRemove.remove();
	                                } else {
	                                    alert('친구 요청 거절에 실패했습니다.');
	                                }
	                            },
	                            error: function (error) {
	                                console.error(error);
	                            }
	                        });
	                    });
	                }


	// 페이지 로드 시 요청 목록 표시
	window.onload = function () {
	    myRequestList();
	};

	
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
    <!-- 아이디/비밀번호 탭 -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">보낸 요청목록</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">받은 요청목록</button>
			</li>
		</ul>
		<!-- 위에 탭 종료 -->
		 
		<!-- 탭 컨텐츠 -->
		<div class="tab-content" id="myTabContent">
		<!-- 보낸요청-->
			<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
			
					<div class = "search-title">
							<h2>보낸 친구 요청목록</h2>
							<p>아직 친구가 수락해 주지 않았어요.</p>
					</div><!-- //.search-title -->
					<div id="sendRequestList">
           
        			</div>

					<!-- 버튼 -->
					<div class ="button_zone">
						<input type="button"  class="backBtn" name="cancle" value="친구목록 돌아가기" onClick="history.back()">
				 	</div><!-- //.btnSearch -->
				
			</div><!-- .//tab-pane fade show active -->
			
			<!-- 받은요청-->
			<div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
			
				
					<div class = "search-title">
							<h2>받은 친구 요청목록</h2>
							<p>수락/거절을 눌러 친구를 추가 해주세요.</p>
					</div><!-- //.search-title -->
					
					<div id="requestList">
           
        			</div>
					
					<div class ="button_zone">
						<input type="button"  class="backBtn" name="cancle" value="친구목록 돌아가기" onClick="history.back()">
					</div><!-- //.btnSearch -->
				
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
 
</body>
</html>