<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="app.dao.UserDao"%>
<%@ page import="app.dto.UserDto"%>

<%
    UserDto udto = (UserDto) session.getAttribute("udto");
%>

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
            <p>안녕하세요, <%=udto.getUserName()%>!</p>
        </div>
        <div id="chat-content" class="chat-content"></div>
        <form id="chatForm">
            <input id="input_msg" type="text" name="message" placeholder="Type your message..." />
            <input type="button" value="Send" onclick="send(event)" />
        </form>
    </div>

    <script type="text/javascript">
        var inputMsg = document.getElementById('input_msg');
        var userId = "<%=udto.getUserName()%>";

        function send(event) {
            var message = inputMsg.value;

            $.ajax({
                type: "POST",
                url: "<%= request.getContextPath() %>/chat/saveMessage.do",
                data: {
                    message: message,
                    userId: userId
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
            // 받아온 메시지 목록을 채팅 창에 표시
            var chatContent = document.getElementById('chat-content');
            chatContent.innerHTML = '<div class="message">' + messages.join('</div><div class="message">') + '</div>';

            // 채팅 창을 스크롤하여 최신 메시지가 보이도록 함
            chatContent.scrollTop = chatContent.scrollHeight;
        }
    </script>
</body>
</html>