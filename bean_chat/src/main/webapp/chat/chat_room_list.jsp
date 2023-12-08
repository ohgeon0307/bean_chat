<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Room List</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>내 채팅방 목록</h2>

    <c:if test="${not empty chatRooms}">
        <ul>
            <c:forEach var="chatRoom" items="${chatRooms}">
                <li><a href="${pageContext.request.contextPath}/chat/selectChatRoom.do?selectedChatRoomId=${chatRoom.id}">${chatRoom.roomName}</a></li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${empty chatRooms}">
        <p>참여 중인 채팅방이 없습니다. </p>
    </c:if>
</body>
</html>