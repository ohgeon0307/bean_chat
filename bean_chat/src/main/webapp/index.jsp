<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<a href="<%=request.getContextPath()%>/mypage/myMain.do">마이페이지 바로가기</a>
<a href="<%=request.getContextPath() %>/board/boardList.do">게시판 바로가기</a>
<a href="<%=request.getContextPath() %>/chat/chatList.do">채팅방 목록 바로가기</a>
</body>
</html>