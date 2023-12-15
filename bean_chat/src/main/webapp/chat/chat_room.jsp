<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="app.dao.UserDao"%>
<%@ page import="app.dto.UserDto"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/chat/chat_room.css" rel="stylesheet" />
    <meta charset="UTF-8">
    <title>Chat Room</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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
            // 메시지에서 타임스탬프를 추출하는 로직 (가정: 메시지에 "timestamp:" 뒤에 Unix 타임스탬프가 있는 경우)
            var timestampIndex = message.indexOf("timestamp:");
            if (timestampIndex !== -1) {
                var timestampString = message.substring(timestampIndex + "timestamp:".length).trim();
                return parseInt(timestampString, 10);
            }
            // 만약 메시지에서 타임스탬프를 찾을 수 없다면 혹은 다른 형식이라면 적절한 처리를 수행해야 합니다.
            return null;
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
        </div>
        <div id="chat-content" class="chat-content"></div>
        <form id="chatForm">
            <input id="input_msg" type="text" name="message" placeholder="Type your message..." />
            <input type="button" value="Send" onclick="send(event)" />
        </form>
    </div>

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
                    //여기 메세지가 sse컨트롤러에 있던데 결국 sse의 writer를 보여주는거였음
                    //sse의 writer는 dao에서 이너조인써서 위에 savemessage에서 저장한 유저정보의 usertable의 uidx 이용해서
                    //아무거나 뽑아올수 있었는데 건이가 userId를 뽑아오고있었어여
                    //챗dao  getRecentChatMessages 메소드 수정하면 닉네임, 이름, 아이디중 암꺼나 뽑아올수 있어요.
                    appendMessages(messages);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function appendMessages(messages) {
            // 받아온 메시지 목록을 채팅 창에 표시
            var chatContent = document.getElementById('chat-content');
            chatContent.innerHTML = '<div class="message">' + messages.join('</div><div class="message">') + '</div>';

            // 채팅 창을 스크롤하여 최신 메시지가 보이도록 함
            chatContent.scrollTop = chatContent.scrollHeight;
        }
    </script>
</body>
</html>