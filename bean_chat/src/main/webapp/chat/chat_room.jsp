<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="app.dao.UserDao"%>
<%@ page import="app.dto.UserDto"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <!-- 제이쿼리 연결 -->
   <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"> </script>
   <!-- 부트스트랩 연결 -->
   <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/chat/chat_room.css" rel="stylesheet" />
    
    <title>Chat Room</title>

    <!-- 추가된 부분 -->
    <script type="text/javascript">
        var lastTimestamp = null;  // 이전에 받은 마지막 메시지의 타임스탬프

        // EventSource for receiving SSE messages
        var eventSource = new EventSource('<%= request.getContextPath() %>/ChatSSEServlet?chatRoomId=<%= session.getAttribute("chatRoomId") %>');

        eventSource.onmessage = function (event) {
            var message = event.data;

            // 메시지를 파싱하여 타임스탬프 추출
            var timestamp = parseTimestampFromMessage(message);

            // 이전에 받은 마지막 메시지의 타임스탬프와 비교하여 중복 여부 확인
            if (!lastTimestamp || timestamp > lastTimestamp) {
                appendMessage(message);

                // 타임스탬프 업데이트
                lastTimestamp = timestamp;
            }
        };

        function parseTimestampFromMessage(message) {
            // 메시지에서 타임스탬프를 추출하는 로직 수정
            // (가정: 메시지에 "timestamp:" 뒤에 Unix 타임스탬프가 있는 경우)
            var timestampIndex = message.indexOf("timestamp:");
            if (timestampIndex !== -1) {
                // 타임스탬프를 제거하고 메시지 반환
                return message.substring(0, timestampIndex).trim();
            }
            // 만약 메시지에서 타임스탬프를 찾을 수 없다면 혹은 다른 형식이라면 적절한 처리를 수행해야 합니다.
            return message;
        }

        function appendMessage(message) {
            // 현재 채팅 창의 내용을 가져옴
            var chatContent = document.getElementById('chat-content');
            var currentContent = chatContent.innerHTML;

            // 새로운 메시지를 추가
            var updatedContent = currentContent + '<div class="message">' + message + '</div>';

            // 채팅 창에 업데이트된 내용을 설정
            chatContent.innerHTML = updatedContent;

            // 채팅 창을 스크롤하여 최신 메시지가 보이도록 함
            chatContent.scrollTop = chatContent.scrollHeight;
        }
    </script>
</head>
<body>
    <div class="chat-container">
        <div class="chat-header">
        <!-- 세션에서 담아줌 -->  
        <!-- 쉽게 말하면 action.do가 아니고 페이지 포워드 되는데서 udto를 세션에 담았음다
           원래 action.do같은데따 담아두셨음. -->
            <p>안녕하세요, ${udto.userName}님!</p>
            <button type="button" id="addFriend">
            <i class="xi-user-plus-o"></i>친구 초대하기
         </button><!-- modalBox연결 버튼 -->
        </div>
        <div id="chat-content" class="chat-content"></div>
        <form id="chatForm" onsubmit="send(event); return false;">
    		<input id="input_msg" type="text" name="message" placeholder="메세지를 입력해주세요!" />
    		<input type="submit" value="전송" />
		</form>
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
               </div><!--//.modal-header  -->


               <!--Modal body  -->
               <div class="modal-body">
                  <!-- 친구 검색 -->
                  <P>친구의 ID를 검색 후 초대 할 수 있어요!</P>
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
         
         // 친구 검색
          function searchAndAddFriend() {
              var friendId = $('#friendId').val();
              var friendId = $('#friendId').val().trim(); // 입력값 양쪽 공백 제거

              // 입력값이 공백인지 확인
              if (friendId === '') {
                  // 공백일 경우 알림을 띄우고 검색을 수행하지 않음
                  alert('공백으로는 검색할 수 없습니다.');
                  return;
              }
         
         
         
         
           $.ajax({
               url: '<%= request.getContextPath() %>/chat/chatSearchFriend.do?friendId=' + friendId,
               type: 'POST',
               dataType: 'json',
               success: function (data) {
                  
                  if (data && Object.keys(data).length > 0) {
                     if (data.isFriend) {
                     
                      // 검색 결과 표시
                       var searchResult = ('<img src="../' + data.userImage + '" id="profile-image"><br>' +
                                           'ID: ' + data.userId + '<br>' +
                                           '이름: ' + data.userName+'<br>' +
                                           '닉네임: ' + data.userNickname);
                       // 검색 결과를 표시할 요소에 내용 추가
                    $('#searchAndAddResult').html(searchResult);
                    

                    var addButton = $('<button>친구 초대</button>');
                    addButton.on('click', function() {
                        chatAddFriend(data.userId);
                    });

                    // 모달 푸터에 추가 버튼 추가
                    $('.modal-footer').empty().append(addButton);
                    }else {
                      // 검색 결과가 없을 때 표시할 메시지
                       $('#searchAndAddResult').html('<p>검색 결과가 없습니다.</p>');
                   }
              } else {
                    $('#searchAndAddResult').html('<p>검색 결과가 없습니다.</p>');
               } 
            },
               error: function (error) {
                   console.error(error);
               }
           });
         }
      </script>
      <script>
       // 친구 추가
       function chatAddFriend(friendId) {
           var addId = $('#addId').val();

           $.ajax({
               url: '<%= request.getContextPath() %>/chat/chatAddFriend.do?addId=' + friendId,
               type: 'POST',
               dataType: 'json',
               success: function (data) {
                  if(data.success){
                   // 추가 결과 표시
                  $('#addModal').modal('hide'); // 모달 닫기
                  alert('상대방에게 요청 메세지를 보냈어요!\n상대방이 수락 할 때까지 기다려 주세요.');
                  }else{
                     alert('이미 초대된 사용자입니다.')
                  }

               },
               error: function (error) {
                   console.error(error);
                   alert('친구 초대에 실패했습니다. 다시 시도해주세요.');
               }
           });
       }
      </script>
      
      
    <script type="text/javascript">
        var inputMsg = document.getElementById('input_msg');
        //여기는 그냥 유저네임이든 유아이디엑스든 유저정보 뽑아올수 있는거면 아무거나 괜찮은듯
        //어차피 데이터 저장만하는 스크립트라 sender랑 uidx로 다 저장하는데  뽑아쓸때 sender를 안씀.
        var userName = "${udto.userName}";

        function send(event) {
            var message = inputMsg.value;

            $.ajax({
                type: "POST",
                url: "<%= request.getContextPath() %>/chat/saveMessage.do",
                data: {
                    message: message,
                    userName: userName
                    //여기서 유저네임으로 전해주는가 싶었는데
                },
                success: function (response) {
                    getNewMessages();
                    inputMsg.value = ''; // Clear the input field after sending the message
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function getNewMessages() {
            // 서버로부터 새로운 메시지 목록을 받아와서 채팅 창에 표시
            $.ajax({
                type: "GET",
                url: "<%= request.getContextPath() %>/ChatSSEServlet?chatRoomId=<%= session.getAttribute("chatRoomId") %>",
                success: function (messages) {
                    // 받아온 메시지를 표시
                    appendMessages(messages);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function appendMessages(messages) {
            var chatContent = document.getElementById('chat-content');

            // 문자열인 경우 처리
            if (typeof messages === 'string') {
                // 받아온 메시지를 배열로 분할
                var messageArray = messages.split('\n').filter(Boolean);

                // 배열의 각 요소를 처리하여 채팅 창에 표시
                for (var i = 0; i < messageArray.length; i++) {
                    var message = messageArray[i];
                    chatContent.innerHTML += '<div class="message">' + message + '</div>';
                }
            } else if (Array.isArray(messages)) {
                // 배열인 경우 처리
                chatContent.innerHTML = '<div class="message">' + messages.join('</div><div class="message">') + '</div>';
            } else {
                // 그 외의 경우, 적절한 처리를 수행
                console.error('Messages is not a string or an array:', messages);
            }

            // 채팅 창을 스크롤하여 최신 메시지가 보이도록 함
            chatContent.scrollTop = chatContent.scrollHeight;
        }
    </script>
</body>
</html>