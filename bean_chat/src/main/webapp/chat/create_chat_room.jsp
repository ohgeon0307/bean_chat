<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Chat Room</title>
    <link href="../css/chat/create_chat_room.css" rel="stylesheet" />
</head>
<script>
    function check() {
        var fm = document.frm;

        if (fm.roomName.value == "") {
            alert("방 제목을 입력해주세요.");
            fm.roomName.focus();
            return false;
        }

        // 알림 메시지를 표시하고 3초 후에 폼 제출
        showNotification();
        setTimeout(function() {
            fm.action = "<%=request.getContextPath()%>/chat/createChatRoomAction.do";
            fm.method = "post";
            fm.submit();
        }, 2000);

        return false; // 폼 제출을 여기서 중단
    }

    // 알림 메시지 표시
    function showNotification() {
        var notification = document.getElementById('notification');
        notification.style.display = 'block';

        // 3초 후에 알림 숨김
        setTimeout(function () {
            notification.style.display = 'none';
        }, 6000);
    }
</script>
<body>

	
    <form name="frm" onsubmit="return check();">
        <h2>채팅방 생성</h2>

        <label for="roomName">채팅방 제목을 입력해주세요!</label>
        <input type="text" id="roomName" name="roomName" required>

        <button type="submit" id="submit_btn">방 생성하기</button>

        <!-- 알림 메시지 -->
        <div class="notification" id="notification" style="display: none;">
            방이 생성되었습니다. 채팅방 목록으로 이동합니다.
        </div>
    </form>
    <img src="../images/indexImage/beanchat_char.png" alt="" class="Beanchat_title2">
</body>
</html>