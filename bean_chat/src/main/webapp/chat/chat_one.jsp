
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String userId = null;
if (session.getAttribute("userId") != null) {
	userId = (String) session.getAttribute("userId");
}

String cTo = null;
if (request.getParameter("cTo") != null) {
	cTo = (String) request.getParameter("cTo");
}
%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="../css/chat/chat_one.css" rel="stylesheet" />
<title>채팅방</title>



<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script type="text/javascript">
    function autoClosingAlert(selector, delay) {
        var alertElement = $(selector);
        alertElement.show();
        window.setTimeout(function () { alertElement.hide() }, delay);
    }

    function submitFunction() {
        var cFrom = '<%=userId%>';
        var cTo = '<%=cTo%>';

        var cContents = $('#cContents').val();
        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/chatsubmit/chat_one.do",
            dataType: "json",
            data: {
                cFrom: encodeURIComponent(cFrom),
                cTo: encodeURIComponent(cTo),
                cContents: encodeURIComponent(cContents),
            },
            success: function (result) {
                if (result == 1) {
                    autoClosingAlert('#successMessage', 2000);
                } else if (result == 0) {
                    autoClosingAlert('#dangerMessage', 2000);
            //	alert("통신실패");
                } else {
                    autoClosingAlert('#warningMessage', 2000);
                }
            }
           
        });
        $('#cContents').val('');
    }

    var lastCidx = 0; // 가장 마지막으로 대화데이터의 챗데이터

    function chatListFunction(type) {
        var cFrom = '<%=userId%>';
        var cTo =  '<%=cTo%>';
       console.log('userId:', '<%=userId%>');
        console.log('cTo:',   '<%=cTo%>');
       // console.log('ten:', ten); 
        
        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/chat/chatOne.do",
			headers : {
				'Acccpt' : 'application/json'
			},

			dataType : "json",
			contentType : "application/json",

			data : {
				cFrom : encodeURIComponent(cFrom),
				cTo : encodeURIComponent(cTo),
				listType : type
			},
			headers : {
				Accept : "application / json",
			},

			success : function(data) {

				alert("리스트함수");
				console.log('Server Response:', data);
				if (data == "")
					return;
				console.log('data:', data);
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					addChat(result[i][0].value, result[i][2].value,
							result[i][3].value);

				}
				lastCidx = Number(parsed.last);

			},

			error : function(xhr, status, error) {
				if (xhr.responseJSON) {
					console.log('Server Error:', xhr.responseText);
				} else {
					console.log('Ajax Error:', status, error);
				}
			}
		});
	}

	function addChat(userNickname, cContents, cTime) {
		$('#chatList')
				.append(
						'<div class="message">'
								+ '<img style="width:30px; height:30px;" src="../images/indexImage/beanchat_char.png" alt="이미지">'
								+ '<div class="message-body">' + '<h4>'
								+ userNickname
								+ '<span class="small pull-right">' + cTime
								+ '</span>' + '</h4>' + '<p>' + cContents
								+ '</p>' + '</div>' + '</div>');
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}

	function getInfiniteChat() {
		setInterval(function() {
			chatListFunction(lastCidx);
		}, 3000);
	}
</script>
</head>
<body>
<header>
	<div class="container">
		<img src="../images/indexImage/beanchat_text.png" alt=""
			class="beanchat_text">
		<div class="items">
			<ul>
				<li><c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do"><img
								role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/user/userLogout.do"><img
								role="button" src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
						</c:otherwise>
					</c:choose></li>
				<li><c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do"><img
								role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/mypage/myMain.do"><img
								role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
						</c:otherwise>
					</c:choose></li>
				<li><a href="<%=request.getContextPath()%>/board/boardList.do"><img
						role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a></li>
				<li><c:choose>
						<c:when test="${uidx== null }">
							<a href="<%=request.getContextPath()%>/user/userLogin.do"><img
								role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
						</c:when>
						<c:otherwise>
							<a href="<%=request.getContextPath()%>/chat/chatList.do"><img
								role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
						</c:otherwise>
					</c:choose></li>
			</ul>
		</div>
	</div>
	</header>
	<main>
	<div id="realmainzone">
		<h3>1대1 채팅</h3>
		<br>
		<div id="main_main">
			<div id="fdlist"></div>
			<div id="chat_area">
				<div id="chatList"></div>
				<div id="mainzone">
					<textarea id="cContents" placeholder="채팅을 입력하세요." maxlength="1000"></textarea>
					<button onclick="submitFunction()">전송</button>
				</div> <!-- #mainzone -->
			</div> <!-- #chat_area -->
		</div> <!-- #main_main-->

		<div class="alert alert-success" id="successMessage"
			style="display: none;">
			<strong>메세지 전송에 성공했습니다</strong>
		</div>
		<div class="alert alert-danger" id="dangerMessage"
			style="display: none;">
			<strong> 내용을 입력</strong>
		</div>
		<div class="alert alert-warning" id="warningMessage"
			style="display: none;">
			<strong>데이터베이스 오류</strong>
		</div>

	</div><!-- #realmainzone-->


</main>
	<script type="text/javascript">
		$(document).ready(function() {
			chatListFunction('ten');
			getInfiniteChat();

		});
	</script>

</body>
</html>