<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구리스트</title>
	<!-- 제이쿼리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"> </script>
	<!-- 부트스트랩 연결 -->
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link href="../css/mypage/my_friend_list.css" rel="stylesheet" /> 
	<script>
	
	// refreshFriendList 함수를 전역 스코프에 정의
	function refreshFriendList() {
	    loadFriendList(); // 친구 목록을 다시 불러옴
	}
	
	$(document).ready(function(){
		// 페이지 로딩 시 친구 목록 불러오기
	    loadFriendList();

	    // 친구 추가 또는 삭제 후 친구 목록 새로고침하는 예시
	    function refreshFriendList() {
	        loadFriendList(); // 친구 목록을 다시 불러옴
	    }
		
		
	});
	
	function loadFriendList() {
	    $.ajax({
	        url: '/bean_chat/friend/myFriendList.do',
	        type: 'POST',
	        dataType: 'json',
	        // 받아온 JSON 데이터를 반복하여 화면에 표시
	        success: function(data){
	            var table = '<table id="friendTable">'; // 테이블 시작
	            table += '<tr><th>프로필 사진</th><th>아이디</th><th>이름</th><th>닉네임</th><th>생일</th><th>삭제</th></tr>'; // 테이블 헤더

	            $.each(data, function(index, udto){
	                table += '<tr>';
	                table += '<td><img src="../' + udto.userImage + '" alt="' + udto.userName + '의 프로필 사진" width="50" height="50"></td>';
	                table += '<td>' + udto.userId + '</td>'; // 친구 아이디 열 추가
	                table += '<td>' + udto.userName + '</td>';
	                table += '<td>' + udto.userNickname + '</td>';
	                table += '<td>' + udto.userBirth + '</td>'; // 생일 열 추가
	                table += '<td><button class="deleteButton" data-userid="' + udto.userId + '">삭제</button></td>'; // 삭제 버튼 추가
	                table += '</tr>';
	            });

	            table += '</table>'; // 테이블 종료
	            $('#friendList').html(table); // HTML에 테이블 삽입
	            // 삭제 버튼 클릭 이벤트 처리
	            $('.deleteButton').on('click', function() {
	                var userIdToDelete = $(this).data('userid');
	                confirmDelete(userIdToDelete); // 삭제 확인 함수 호출
	            });
	        },
	        error: function(){
	            alert('친구 리스트를 불러오는데 실패했습니다.');
	        }
	    });
	}
	    
	    // 친구 삭제 확인 함수
	    function confirmDelete(friendId) {
	        // 삭제를 한번 더 확인하는 알림 메시지
	        if (confirm(friendId + '님을 친구에서 삭제하시겠습니까?')) {
	            deleteFriend(friendId); // 친구 삭제 함수 호출
	        }
	    }

	 // 친구 삭제 함수
	    function deleteFriend(friendId) {
	        $.ajax({
	            url: '/bean_chat/friend/deleteFriend.do?friendId=' + friendId,
	            type: 'POST',
	            dataType: 'json',
	            success: function (data) {
	            	alert('친구가 삭제되었습니다.');
	            	console.log('deleteFriend 함수 내부: 친구 삭제 성공 후 refreshFriendList() 호출 전'); // 성공 후 콜백 전에 로그 추가
	                refreshFriendList(); // 친구 삭제 후 목록 새로고침
	                console.log('deleteFriend 함수 내부: 친구 삭제 성공 후 refreshFriendList() 호출 후'); // 성공 후 콜백 후에 로그 추가
	            },
	            error: function (error) {
	                console.error(error);
	            }
	        });
	    }

	    
    // 친구 검색
    function searchAndAddFriend() {
        var friendId = $('#friendId').val();
        var friendId = $('#friendId').val().trim(); // 입력값 양쪽 공백 제거

        // 입력값이 공백인지 확인
        if (friendId === '') {
            // 공백일 경우 알림을 띄우고 검색 하지 않음
            alert('공백으로는 검색할 수 없습니다.');
            return;
        }

        $.ajax({
            url: '/bean_chat/friend/searchFriend.do?friendId=' + friendId,
            type: 'POST',
            dataType: 'json',
            success: function (data) {
            	if (data && Object.keys(data).length > 0) {
            		
                // 검색 결과 표시
              	var searchResult = ('<img src="../' + data.userImage + '" id="profile-image"><br>' +
                                        'ID: ' + data.userId + '<br>' +
                                        '이름: ' + data.userName+'<br>' +
                                        '닉네임: ' + data.userNickname);
           		// 검색 결과를 표시할 요소에 내용 추가
              $('#searchAndAddResult').html(searchResult);
           		
           		
              var isFriend = data.isFriend; // 서버에서 전달된 친구 여부 값
              var isRequestSent = data.isRequestSent;
              var addButton = $('<button>친구 추가</button>');
              
              if (isFriend) {
                  // 이미 친구인 경우
                  alert('이미 친구인 사용자입니다.');
                  addButton.hide(); // 친구 추가 버튼 숨기기
                  $('#clodelModalBtn').show(); // 취소 버튼 보이기
              } else if (isRequestSent) {
                  // 이미 요청을 보낸 상태이므로 추가 버튼 비활성화
            	  alert('요청 대기 중인 사용자입니다.');
            	  addButton.hide(); // 친구 추가 버튼 숨기기
            	  $('#clodelModalBtn').show(); // 취소 버튼 보이기
              }else {
              // 추가 버튼 생성 및 이벤트 설정
             
              addButton.on('click', function() {
                  addFriend(data.userId);
              });

              // 모달 푸터에 추가 버튼 추가
              $('.modal-footer').empty().append(addButton);
              }
            	} else {
            		 // 검색 결과가 없을 때 표시할 메시지
                    $('#searchAndAddResult').html('<p>검색 결과가 없습니다.</p>');
                }
            },
            error: function (error) {
                console.error(error);
            }
        });
    }    //

    // 친구 추가
    function addFriend(friendId) {
        var addId = $('#addId').val();

        $.ajax({
            url: '/bean_chat/friend/addFriend.do?addId=' + friendId,
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                // 추가 결과 표시
            	$('#searchAndAddResult').html('');
            	alert('상대방에게 요청 메세지를 보냈어요!\n상대방이 수락 할 때까지 기다려 주세요.');
            },
            error: function (error) {
                console.error(error);
            }
        });
    }
    
  </script>
   

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
	<h1>My Page</h1>
	<hr>
	<h2>나의 친구 목록</h2>
	<button type="button" id="addFriend">
		<i class="xi-user-plus-o"></i>친구 추가하기
	</button><!-- modalBox연결 버튼 -->


		<div id="list_friend">
			<ul id="friendList"></ul>
		</div><!-- //#list_friend -->



	<div id="button_zone">
		<a href="<%=request.getContextPath()%>/friend/myFriendRequest.do" class="myButton primary">친구요청수락하러가기</a>
		<a href="<%=request.getContextPath()%>/mypage/myMain.do" class="myButton secondary">목록 돌아가기</a>
	</div>

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


		<div class="modal" id="addModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">친구추가</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div><!--//.modal-header  -->


					<!--Modal body  -->
					<div class="modal-body">
						<!-- 친구 검색 -->
						<P>친구의 ID를 검색 후 추가 할 수 있어요!</P>
						<label for="friendId">친구 ID:</label>
						<input type="text" id="friendId" name="friendId">
						<button onclick="searchAndAddFriend()">검색</button>
						
						<!-- 검색 및 추가 결과 표시 -->
						<div id="searchAndAddResult"></div>

					</div><!--//.modal-body  -->
					
					<!--Modal footer  -->
					<div class="modal-footer">
						<!-- 추가버튼 추가 될 자리 -->
						<button type="button" id="clodelModalBtn" class="btn btn-default" data-dismiss="modal">취소</button>
					</div><!-- //.modal-footer -->

				</div><!--//.modal-content  -->
			</div><!-- //.modal-dialog modal-dialog-centered -->
		</div><!-- //#delModal -->
		  <script>  // 모달 버튼에 이벤트를 건다.  
		  $('#addFriend').on('click', function(){
			    $('#addModal').modal('show');
			});

			// 모달 안의 취소 버튼 클릭 시 모달 닫기
			$('#clodelModalBtn').on('click', function(){
			    $('#addModal').modal('hide');
			    
			});
		</script>
</body>
</html>