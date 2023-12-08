<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Chat Room</title>
    <link rel="stylesheet" href="styles.css">
</head>
<script>
	function check() {
		var fm = document.frm;
		
		if(fm.roomName.value =="") {
			alert("방 제목을 입력해주세요.");
			fm.roomName.focus();
			return false;
		}
		
		fm.action = "<%=request.getContextPath()%>/chat/createChatRoomAction.do";
		fm.method = "post";
		fm.submit();
		return;
	}
</script>
<body>
    <h2>채팅방 생성</h2>

    <form name="frm">
        <label for="roomName">채팅방 제목을 입력해주세요!</label>
        <input type="text" id="roomName" name="roomName" required>

        <button type="submit" id="submit_btn" onclick="check();">방 생성하기</button>
    </form>
</body>
</html>