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
  
	<script>
    $(document).ready(function(){
        $.ajax({
        	url: '/bean_chat/friend/myFriendList.do',
            type: 'POST',
            dataType: 'json',
            // 받아온 JSON 데이터를 반복하여 화면에 표시
            success: function(data){
                $.each(data, function(index, udto){
                    var friendInfo = '<li>';
                    friendInfo += '<img src="../' + udto.userImage + '" alt="' + udto.userName + '의 프로필 사진">';
                    friendInfo += '<br>';
                    friendInfo += '이름: ' + udto.userName + ', 닉네임: ' + udto.userNickname;
                    friendInfo += '</li>';
                    $('#friendList').append(friendInfo);
                });
            },
            error: function(){
                alert('친구 리스트를 불러오는데 실패했습니다.');
            }
        });
    });
   
   
   
   
   
   
   
   
   
   
    // 친구 검색
    function searchFriend() {
        var friendId = $('#friendId').val();

        $.ajax({
            url: '/bean_chat/friend/searchFriend.do?friendId=' + friendId,
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                // 검색 결과 표시
                $('#searchResult').html('친구 ID: ' + data.userId + '<br>' +
                                        '친구 이름: ' + data.userName+'<br>' +
                                        '친구 닉네임: ' + data.userNickname+'<br>' +
                                        '친구 이미지: <img src="../' + data.userImage + '" id="profile-image"><br>' +
                                        '친구 생일: ' + data.userBirth);
            },
            error: function (error) {
                console.error(error);
            }
        });
    }

    // 친구 추가
    function addFriend() {
        var addId = $('#addId').val();

        $.ajax({
            url: '/bean_chat/friend/addFriend.do?addId=' + addId,
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                // 추가 결과 표시
                $('#addResult').html('상대방에게 요청메세지를 보냈어요!');
            },
            error: function (error) {
                console.error(error);
            }
        });
    }
   </script>

</head>
<body>

<main>

	<div id="add_friend">
	
		<h1>친구 목록</h1>
		<!-- 친구 검색 -->
		<label for="friendId">친구 ID:</label>
		<input type="text" id="friendId" name="friendId">
		<button onclick="searchFriend()">검색</button>
	
		<!-- 검색 결과 표시 -->
		<div id="searchResult"></div>
	
		<hr>
	
		<!-- 친구 추가 -->
		<label for="friendAdd">추가할 친구 ID:</label>
		<input type="text" id="addId" name="addId">
		<button onclick="addFriend()">추가</button>
	
		<!-- 추가 결과 표시 -->
		<div id="addResult"></div>
	
		<a href="<%=request.getContextPath()%>/friend/myFriendRequest.do">친구요청수락하러가기</a>
	</div>
	<div id="list_friend">
		
		<h1>친구 리스트</h1>
		<ul id="friendList"></ul>
	
	
	</div>




</main>











</body>
</html>