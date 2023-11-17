<%@ page import="java.util.List" %>
<%@ page import="app.dto.ChatDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Collections" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%
String userId = null;
if (session.getAttribute("userId") != null) {
	userId = (String) session.getAttribute("userId");
}

String cTo = null;
if (session.getAttribute("cTo") != null) {
	cTo = (String) session.getAttribute("cTo");
}


%>

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>채팅방</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        #chatList {
            width: 600px;
            margin: 20px auto;
            border: 1px solid #ccc;
            padding: 10px;
            height: 600px;
            overflow-y: auto;
        }

      .message {
        border-bottom: 1px solid #eee;
        padding: 10px;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
    }

    .message img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        margin-right: 10px;
    }

    .message-body {
        flex: 1;
    }

    .message h4 {
        margin: 0;
    }

    .message p {
        margin: 0;
    }
        textarea {
            width: 550px;
            height: 80px;
            margin-bottom: 10px;
            padding: 5px;
        }

        button {
            width: 100px;
            padding: 8px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
          .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            display: none; /* 기본적으로는 숨김 상태로 설정 */
        }

        .alert-success {
            color: #3c763d;
            background-color: #dff0d8;
            border-color: #d6e9c6;
        }

        .alert-danger {
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
        }

        .alert-warning {
            color: #8a6d3b;
            background-color: #fcf8e3;
            border-color: #faebcc;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.1.min.js"
        integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
        crossorigin="anonymous"></script>
    <script type="text/javascript">
    
        function autoClosingAlert(selector, delay) {
            var alert = $(selector).alert();
            alert.show();
            window.setTimeout(function () { alert.hide() }, delay);
        }

        function submitFunction() {
            var cFrom = '<%=userId%>';
            var cTo = '<%=cTo%>';
    
            var cContents = $('#cContents').val();
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/chat/chat_one.do",
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
                    } else {
                        autoClosingAlert('#dangerMessage', 2000);
                    }
                }
            });
            $('#cContents').val('');
        }

        var lastID = 0; //가장 마지막으로 대화데이터의 챗데이터

        function chatListFunction(type) {
            var cFrom = '<%= userId%>';
            var cTo = '<%= cTo%>';
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/chat/chat_one.do",
                dataType: "json",
                data: {
                    cFrom: encodeURIComponent(cFrom),
                    cTo: encodeURIComponent(cTo),
                    listType: type
                },
                success: function (data) {
                	   console.log('Server Response:', data);
                    if (data == "") return;
                    var parsed = JSON.parse(data);
                    
                    var result = parsed.result;
                    for (var i = 0; i < result.length; i++) {
                        addChat(result[i][0].value, result[i][2].value, result[i][3].value);
                    }
                    lastID = Number(parsed.last);
                    
                },
                error: function (xhr, status, error) {
                    console.log('Ajax Error:', status, error);
                }
            });


            
        }

        function addChat(userNickname, cContents, cTime) {
        	
        	
            $('#chatList').append('<div class="message">' +
                '<img style="width:30px; height:30px;" src="../images/indexImage/beanchat_char.png" alt="이미지">' +
                '<div class="message-body">' +
                '<h4>' +
                userNickname +
                '<span class="small pull-right">' +
                cTime +
                '</span>' +
                '</h4>' +
                '<p>' +
                cContents +
                '</p>' +
                '</div>' +
                '</div>');
            $('#chatList').scrollTop($('#chatList')[0].scrollHeight);
            
           
        }
        

            function getUserNickname() {
            	   var userId = '<%= (String)session.getAttribute("userId") %>';                var userId = '<%=userId%>';
                return userId;
            }

           

        function getInfiniteChat() { //몇초간격으로 계속해서 새로운메시지가 왔는지
            setInterval(function () {
                chatListFunction(lastID);
            }, 3000);
        }
    </script>
</head>
<body>

    <div id="chatList"></div>
    
    <textarea id="cContents" placeholder="채팅을 입력하세요." maxlength="1000"></textarea>
    <button onclick="submitFunction()">전송</button>
    <div class="alert alert-success" id="successMessage" style="display:none;"><strong>메세지 전송에 성공했습니다</strong></div>
    <div class="alert alert-danger" id="dangerMessage" style="display:none;"><strong>이름과 내용을 입력</strong></div>
    <div class="alert alert-warning" id="warningMessage" style="display:none;"><strong>데이터베이스 오류</strong></div>

    <script type="text/javascript">
        $(document).ready(function () {
            chatListFunction('ten');
            getInfiniteChat();
	addChat();
        });
    </script>
    
</body>
</html>