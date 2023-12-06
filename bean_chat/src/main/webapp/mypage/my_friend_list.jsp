<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구리스트</title>
	<script>
	function addFriend(){
		var fm = document.frm;
	
		fm.method = "post";
		fm.action = "<%=request.getContextPath()%>/mypage/myFriendAdd.do"; //처리하기위해 이동하는 주소
		fm.submit();
		return;
	}
	
	</script>

</head>
<body>

    <h1>친구 목록</h1>
    <form name="frm">
	    <label for="findId">친구ID :</label>
	    <input type="text" name="findId" id="findId">
	    <button type="button" id="addFrdBtn" onclick="addFriend();">친구추가</button>
    </form>
    <ul>
        <!-- 친구 목록을 반복하여 표시 -->
        <c:forEach items="${alist}" var="fdto">
            <li>${fdto.fInfo.userNickName}</li>
            <li>${fdto.frInfo.userName}</li>
            <li>${fdto.frInfo.userId}</li>
        </c:forEach>
    </ul>
    
    
</body>
</html>