<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅요청수락</title>
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
	function chatRequestList() {
		
	    $.ajax({
	        url: '/bean_chat/chat/chatRequestList.do',
	        type: 'POST',
	        dataType: 'json',
	        success: function(data) {
	        	var receivedRequests = data.receivedRequests;
	            var friendNicknames = data.friendNicknames;
	            var requestList = $('#requestList');
	            requestList.empty(); // 기존 목록 비워줌

	            for (var i = 0; i < receivedRequests.length; i++) {
	                var listItem = $('<li>');

	                var roomInfo = $('<div>').html('Room Name: ' + receivedRequests[i].roomName); // 룸 이름 표시
	                var id = $('<div>').html('Room ID: ' + receivedRequests[i].id); // 룸 아이디 표시
	                var friendInfo = $('<div>').html('Friend Info: ' + friendNicknames[i]); // 프렌즈 정보 표시


	                var acceptBtn = $('<button>').text('수락');
	                var rejectBtn = $('<button>').text('거절');

	                createClickHandlers(acceptBtn, rejectBtn, receivedRequests[i].id);

	                listItem.append(roomInfo, id, friendInfo, acceptBtn, rejectBtn);
	                requestList.append(listItem);
	            }
	        },
	        error: function(error) {
	            console.error(error);
	        }
	    });
	}
	function createClickHandlers(acceptBtn, rejectBtn, id) {                
	                // 수락 버튼 클릭 시 이벤트 핸들러
	                acceptBtn.click(function () {

	                	/*  var currentUserId = $(this).parent().find('button').attr('data-userId'); // 해당 요청의 userId 가져오기*/
	                	 var listItemRemove = $(this).closest('li'); // 클릭한 버튼의 부모 li 요소를 찾음
	                        
	                	 $.ajax({
	                	        url: '/bean_chat/chat/chatRequestAccept.do',
	                	        type: 'POST',
	                	        dataType: 'json',
	                	        data: { id: id },
	                	        success: function(response) {
	                	            if (response.success) {
	                	                // 요청을 성공적으로 처리한 경우 실행할 코드
	                	                listItemRemove.remove();
	                	            } else {
	                	                console.log('요청을 처리하지 못했습니다.');
	                	            }
	                	        },
	                	        error: function(error) {
	                	            console.error('오류 발생:', error);
	                	        }
	                	    });
	                	});
	                
	                
	                
	         	 rejectBtn.click(function () {
					/* var currentUserId = $(this).parent().find('button').attr('data-userId'); // 해당 요청의 userId 가져오기*/
	         	    var listItemRemove = $(this).closest('li'); // 클릭한 버튼의 부모 li 요소를 찾음 
	                        
	                        $.ajax({
	                            url: '/bean_chat/chat/chatRequestReject.do',
	                            type: 'POST',
	                            dataType: 'json',
	                            data: { id: id },
	                            success: function (response) {
	                                if (response.success) {
	                                    alert('채팅 초대 요청을 거절했습니다.');
	                                    listItemRemove.remove();
	                                } else {
	                                    alert('채팅 초대 요청 거절에 실패했습니다.');
	                                }
	                            },
	                            error: function (error) {
	                                console.error(error);
	                            }
	                        });
	                    });
	                };	


	// 페이지 로드 시 요청 목록 표시
	window.onload = function () {
	    chatRequestList();
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
	<h1>채팅요청수락</h1>
	<hr>

			<!-- 받은요청-->
			<div  id="profile">
			
				
					<div class = "search-title">
							<h2>받은 채팅 요청목록</h2>
							<p>수락/거절을 눌러 채팅을 수락 해주세요.</p>
					</div><!-- //.search-title -->
					
					<div id="requestList">
           
        			</div>
					
					<div class ="button_zone">
						<input type="button"  class="backBtn" name="cancle" value="채팅목록 돌아가기" onClick="history.back()">
					</div><!-- //.btnSearch -->
				
			</div><!-- tab-pane fade -->



    
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


	
 
</body>
</html>