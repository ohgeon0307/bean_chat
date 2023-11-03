<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>게시판</h2><br />
		<a href="<%=request.getContextPath()%>/board/boardList.do">게시판 바로가기</a><br />
	<h2>채팅방</h2>
		<a href="<%=request.getContextPath()%>/chat/chatList.do">채팅방 목록 바로가기</a><br />
	<h2>User</h2><br />
		<a href="<%=request.getContextPath()%>/user/userList.do">유저목록보기</a><br />
		<a href="<%=request.getContextPath()%>/mypage/myMain.do">마이페이지 바로가기</a><br />
		<a href="<%=request.getContextPath()%>/user/userJoin.do">회원가입하기</a><br />
		<a href="<%=request.getContextPath()%>/user/userLogin.do">로그인하기</a><br />
		<a href="<%=request.getContextPath()%>/user/userFind.do">아이디/비밀번호찾기</a>
</body>
</html>