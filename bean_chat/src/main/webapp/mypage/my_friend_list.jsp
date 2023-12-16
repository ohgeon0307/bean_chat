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
 	<!-- css연결 -->
	<link href="../css/reset.css" rel="stylesheet" />
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link href="../css/mypage/my_friend_list.css" rel="stylesheet" /> 
	<script>
	$(document).ready(function(){
	    $.ajax({
	        url: '/bean_chat/friend/myFriendList.do',
	        type: 'POST',
	        dataType: 'json',
	        // 받아온 JSON 데이터를 반복하여 화면에 표시
	        success: function(data){
	            var table = '<table id="friendTable">'; // 테이블 시작
	            table += '<tr><th>프로필 사진</th><th>아이디</th><th>이름</th><th>닉네임</th><th>생일</th></tr>'; // 테이블 헤더

	            $.each(data, function(index, udto){
	                table += '<tr>';
	                table += '<td><img src="../' + udto.userImage + '" alt="' + udto.userName + '의 프로필 사진" width="50" height="50"></td>';
	                table += '<td>' + udto.userId + '</td>'; // 친구 아이디 열 추가
	                table += '<td>' + udto.userName + '</td>';
	                table += '<td>' + udto.userNickname + '</td>';
	                table += '<td>' + udto.userBirth + '</td>'; // 생일 열 추가
	                table += '</tr>';
	            });

	            table += '</table>'; // 테이블 종료
	            $('#friendList').html(table); // HTML에 테이블 삽입
	        },
	        error: function(){
	            alert('친구 리스트를 불러오는데 실패했습니다.');
	        }
	    });
	});
    // 친구 검색
    function searchAndAddFriend() {
        var friendId = $('#friendId').val();

        $.ajax({
            url: '/bean_chat/friend/searchFriend.do?friendId=' + friendId,
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                // 검색 결과 표시
              var searchResult = ('친구 ID: ' + data.userId + '<br>' +
                                        '친구 이름: ' + data.userName+'<br>' +
                                        '친구 닉네임: ' + data.userNickname+'<br>' +
                                        '친구 이미지: <img src="../' + data.userImage + '" id="profile-image"><br>' +
                                        '친구 생일: ' + data.userBirth);
             // 추가 버튼
                var addButton = '<button onclick="addFriend(\'' + data.userId + '\')">친구 추가</button>';
                // 검색 결과 및 추가 버튼 표시
                $('#searchAndAddResult').html(searchResult + '<br>' + addButton);
            },
            error: function (error) {
                console.error(error);
            }
        });
    }

    // 친구 추가
    function addFriend(friendId) {
        var addId = $('#addId').val();

        $.ajax({
            url: '/bean_chat/friend/addFriend.do?addId=' + friendId,
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                // 추가 결과 표시
            	 $('#searchAndAddResult').html('상대방에게 요청 메세지를 보냈어요!');
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
	<button type="button" id="addFriend">
		<i class="xi-user-plus-o"></i>친구 추가하기
	</button><!-- modalBox연결 버튼 -->
	<h2>나의 친구 목록</h2>


		<div id="list_friend">
			<ul id="friendList"></ul>
		</div><!-- //#list_friend -->




</main>

	<div id="add_friend">
	
		<!-- 친구 검색 -->
		<label for="friendId">친구 ID:</label>
		<input type="text" id="friendId" name="friendId">
		<button onclick="searchAndAddFriend()">검색 후 추가</button>
		
		<!-- 검색 및 추가 결과 표시 -->
		<div id="searchAndAddResult"></div>
	
		<a href="<%=request.getContextPath()%>/friend/myFriendRequest.do">친구요청수락하러가기</a>
	</div>


		<div class="modal" id="addModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">친구추가</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div><!--  -->//.modal-header


					Modal body
					<div class="modal-body">
						<label for="friendId">친구 ID:</label>
							<input type="text" id="friendId" name="friendId">
						<button onclick="searchFriend()">검색</button>
					
					
					
					</div>//.modal-body
					
					Modal footer
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger" onclick="byeUser();">탈퇴하기</button>
						<button type="button" id="clodelModalBtn" class="btn btn-default" data-dismiss="modal">취소</button>
					</div>//.modal-footer

				</div>//.modal-content
			</div>//.modal-dialog modal-dialog-centered
		</div>//#delModal
</body>
</html>