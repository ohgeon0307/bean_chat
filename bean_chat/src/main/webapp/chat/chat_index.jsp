<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="app.dao.UserDao"%>

<%
    String userId = (String) session.getAttribute("userId");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Room</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
    <a href="${pageContext.request.contextPath}/chat/createChatRoom.do"><button>방생성하기</button></a>
    <a href="${pageContext.request.contextPath}/chat/viewChatRoomList.do"><button>내 채팅방 목록확인하기</button></a>
</body>
</html>