<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="app.dao.UserDao"%>

<%
    String userId = (String) session.getAttribute("userId");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/chat/chat_room.css" rel="stylesheet" />
    <meta charset="UTF-8">
    <title>Chat Room</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
    <div class="chat-container">
        <div class="chat-header">
            <p>Welcome, <%= userId %>!</p>
        </div>
        <div id="chat-content" class="chat-content"></div>
        <form id="chatForm">
            <input id="input_msg" type="text" name="message" placeholder="Type your message..." />
            <input type="button" value="Send" onclick="send(event)" />
        </form>
    </div>

    <script type="text/javascript">
        var chatContent = document.getElementById('chat-content');
        var inputMsg = document.getElementById('input_msg');
        var userId = "<%= userId %>";

        // EventSource for receiving SSE messages
        var eventSource = new EventSource('<%= request.getContextPath() %>/ChatSSEServlet?chatRoomId=<%= session.getAttribute("chatRoomId") %>');

        eventSource.onmessage = function (event) {
            var message = event.data;
            appendMessage(message);
        };

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

        function appendMessage(message) {
            // 현재 채팅 창의 내용을 가져옴
            var currentContent = chatContent.innerHTML;

            // 새로운 메시지를 추가
            var updatedContent = currentContent + '<div class="message">' + message + '</div>';

            // 채팅 창에 업데이트된 내용을 설정
            chatContent.innerHTML = updatedContent;

            // 채팅 창을 스크롤하여 최신 메시지가 보이도록 함
            chatContent.scrollTop = chatContent.scrollHeight;
        }

        function appendMessages(messages) {
            // 받아온 메시지 목록을 채팅 창에 표시
            chatContent.innerHTML = '<div class="message">' + messages.join('</div><div class="message">') + '</div>';

            // 채팅 창을 스크롤하여 최신 메시지가 보이도록 함
            chatContent.scrollTop = chatContent.scrollHeight;
        }
    </script>
</body>
</html>