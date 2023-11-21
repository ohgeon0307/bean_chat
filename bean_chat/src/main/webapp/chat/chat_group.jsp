<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<!DOCTYPE html>
<html style="width: 1086px;">
<head>
<%
String userId = null;
if (session.getAttribute("userId") != null) {
   userId = (String) session.getAttribute("uidx");
}
String cTo = null;
if (request.getParameter("cTo") != null) {
   cTo = (String) request.getParameter("cTo");
}
%>
<meta http-equiv="cContents-Type" cContents="text/html; charset=utf-8">
<meta name="viewport" cContents="width=device-width, initial-scale=1.0">
<title>채팅방</title>

<style>
body {
   width: 1086px;
   height: 1042px;
}

#chatList {
   overflow-y: auto;
   width: 800px;
   height: 700px;
}

textarea {
   height: 100px;
   width: 650px;
}

button {
   width: 100px;
   padding-right: 13px;
   padding-left: 13px;
   padding-top: 5px;
   padding-bottom: 8px;
   background-color: #4CAF50;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
function autoClosingAlert(selector, delay) {
   var alert = $(selector).alert();
   alert.show();
   window.setTimeout(function () { alert.hide () } ,delay);
}
function submitFunction(){
   var cFrom = '<%=userId%>';
   var cTo = '<%=cTo%>';
   var cContents = $('#cContents').val();
   $.ajax({
      type:"POST",
      url: "<%=request.getContextPath()%>/chat/chat_group.do",
      dataType: "json",
      data: {
         cFrom: encodeURICompinent(cFrom),
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

var lastID = 0;

function chatListFunction(type) {
    var cFrom = '<%= userId%>';
    var cTo = '<%= cTo%>';
    $.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/chat/chat_group.do",
        dataType: "json",
        data: {
            cFrom: encodeURIComponent(cFrom),
            cTo: encodeURIComponent(cTo),
            listType: type
        },
        success: function (data) {
            if (data == "") return;
            var parsed = JSON.parse(data);
            var result = parsed.result;
            for (var i = 0; i < result.length; i++) {
                addChat(result[i][0].value, result[i][2].value, result[i][3].value);
            }
            lastID = Number(parsed.last);
        }
    });
}

function addChat(userNickname, cContents, cTime) {
    $('#chatList').append('<div class="message">' +
        '<img src="<%=request.getContextPath()%>
   /images/indexImage/beanchat_char.png" alt="이미지">'
                        + '<div class="message-body">' + '<h4>'
                        + userNickname
                        + '<span class="small pull-right">' + cTime
                        + '</span>' + '</h4>' + '<p>' + cContents
                        + '</p>' + '</div>' + '</div>');
      $('#chatList').scrollTop($('#chatList')[0].scrollHeight);
   }

   function getInfiniteChat() {
      setInterval(function() {
         chatListFunction(lastID);
      }, 3000);
   }
</script>
</head>
<body>
   <div id="chatList" class="porlet-body chat-widget">
      <textarea style="overflow-y: auto; width: 793px; height: 688px;"
         id="cContents" class="form-control"></textarea>
   </div>
   <textarea id="cContents" placeholder="채팅을 입력하세요." maxlength="1000"></textarea>
   <button onclick="submitFunction()">전송</button>
   <script>
      $(document).ready(function() {
         chatListFunction('ten');
         getInfiniteChat();
      });
   </script>
</body>
</html>