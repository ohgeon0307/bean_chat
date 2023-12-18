<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>채팅방 목록</title>
    <link href="../css/reset.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/chat/chat_room_list.css">
    <style>
        
    </style>
</head>
<body> 
    <h2>내 채팅방 목록</h2>
	<img src="../images/indexImage/beanchat_char.png" alt="" class="Beanchat_title2 logo">
   
   
   <a href="<%=request.getContextPath()%>/chat/chatRequest.do" class="myButton primary">채팅수락하러가기</a>
    <div id="chatList">
        <c:if test="${not empty chatRooms}">
            <c:forEach var="chatRoom" items="${chatRooms}">
                <a data-chatroomid="${chatRoom.id}">${chatRoom.roomName}</a>
            </c:forEach>
        </c:if>

        <c:if test="${empty chatRooms}">
            <p>참여 중인 채팅방이 없습니다.</p>
        </c:if>
    </div>

    <p>채팅방 목록이 여기에 표시됩니다.</p>

    <script>
        // 채팅방 목록 클릭 시 해당 채팅방으로 이동
        document.getElementById("chatList").addEventListener("click", function(event) {
            var target = event.target;
            if (target.tagName === "A") {
                var chatRoomId = target.getAttribute("data-chatroomid");
                if (chatRoomId) {
                    window.location.href = "<%= request.getContextPath() %>/chat/selectChatRoom.do?selectedChatRoomId=" + chatRoomId;
                }
            }
        });
        
        $(".logo").click(function(){	
        	if(!confirm("메인으로 돌아가시겠습니까?")){
        		return false;
        	}else{
        		location.href="<%=request.getContextPath()%>";
        			}

        		});
    </script>
</body>
</html>