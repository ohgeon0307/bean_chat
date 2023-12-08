<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구요청수락</title>
	<!-- 제이쿼리 연결 -->
   <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"> </script>
  
   <script>
        // 요청 목록을 받아서 화면에 표시하는 함수
		function myRequestList() {
			$.ajax({
                url: '/bean_chat/mypage/myRequestList.do', 
                type: 'POST',
                dataType: 'json',
                success: function (data) {
                    var requestList = $('#requestList');
                    requestList.empty(); // 기존 목록 비워줌
                	
                    for (var i = 0; i < data.length; i++) {
                        var listItem = $('<li>');

                        var userInfo = $('<div>').html(
                            data[i].userId + '<br>' +
                            '친구 이름: ' + data[i].userName + '<br>' +
                            '친구 닉네임: ' + data[i].userNickname + '<br>' +
                            '친구 생일: ' + data[i].userBirth + '<br>'
                        );

                        var profileImage = $('<img>').attr('src', '../' + data[i].userImage).attr('id', 'profile-image');

                        var acceptBtn = $('<button>').text('수락');
                        
                        
                        
                        acceptBtn.click(function() {
                            var userId = data[i].userId;
                            var listItemRemove = $(this).closest('li'); // 클릭한 버튼의 부모 li 요소를 찾음
                            
                            myRequestAccept(userId, listItemRemove);
                        });
                        
                        listItem.append(userInfo, profileImage, acceptBtn);
	                     requestList.append(listItem);
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });
        }


        function myRequestAccept(userId, listItem) {
            return function () {
                $.ajax({
                    url: '/bean_chat/mypage/myRequestAccept.do?userId=' + userId,
                    type: 'POST',
                    dataType: 'json',
                    success: function (data) {

                        if (data.success) {
                        	alert('친구 요청을 수락했습니다.');
                        	listItem.remove(); // 해당 요청자에 대한 요소 삭제
                        } else {
                        	alert('친구 요청 수락에 실패했습니다.');
                        }
                    },
                    error: function (error) {
                        console.error(error);
                    }
                });
            };
        }


      // 페이지로드-> 요청 목록 화면에 표시
		window.onload = function() {
			myRequestList();
		};
	</script>
</head>
<body>
     <h1>친구 요청 수락</h1>

    <div id="main_zone">
        <h2>친구 요청 목록</h2>
        <div id="requestList">
           
        </div>
    </div>


    <div id="result"></div>

 
</body>
</html>