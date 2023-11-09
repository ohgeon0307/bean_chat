<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />


<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<link href="../css/chat/chat_list.css" rel="stylesheet" />
<title>채팅방 목록</title>
</head>
<body>


	<main>
		<div><h2>채팅방 목록</h2></div>

		<hr />
		<div id="mainzone">
			
	
			<div class="btn1">
				<a href="<%=request.getContextPath()%>/chat/chat_one.do"><p>1:1 채팅</p>
			<img src="../images/logo/BeanchatChar1.png" alt="1:1 채팅">
				</a>
			</div><!-- //.btn1 -->
		
			<div class="btn2">
				<a href="<%=request.getContextPath()%>/chat/chat_group.do">
					<p>단체채팅방</p>
					<img src="../images/logo/BeanChatPicLogo.png" alt="단체채팅방">
				</a>
			</div><!-- //.btn2 -->
		</div><!-- //#mainzone -->


</main>
</body>
</html>