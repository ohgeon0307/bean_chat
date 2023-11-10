
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	
	
	
	function autoClosingAlert(selector,delay)
	{
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {alert.hide()},delay); 
	}
	function submitFunction(){
		var cFrom = '<%=userId%>';
		var cTo =  '<%=cTo%>';
		var cContents = $('#cContents').val(); 
		$.ajax({
			type:"POST",
			url:"<%=request.getContextPath()%>/chat/chat_group.do",
			dataType : "json",
			data:{
				cFrom:encodeURIComponent(cFrom),
				cTo:encodeURIComponent(cTo),
				cContents:encodeURIComponent(cContents),
				},
				success: function(result){
					if(result==1){
						autoClosingAlert('#successMessage',2000);
					}else if(result==0)
					{
					autoClosingAlert('#dangerMessage',2000);
					}else{						
					autoClosingAlert('#dangerMessage',2000);
						 }
					     				}  
			});
		$('#cContents').val('');
									}
	var lastID = 0;
	function chatListFunction(type){
		var cFrom = '<%= userId%>';
		var cTo = '<%= cTo%>';
		$.ajax({
			type:"POST",
			url:"<%=request.getContextPath()%>/chat/chat_group.do",
			dataType : "json",
			data:{
				cFrom:encodeURIComponent(cFrom),
				cTo:encodeURIComponent(cTo),
				listType : type
				},
				success: function(data){
					if(data=="")return;
					var parsed = JSON.parse(data);
					var result = parsed.result;
					for (var i =0; i < result.length; i++){
						addChat(result[i][0].value,result[i][2].value,result[i][3].value);
						
					}
						lastID=Number(parsed.last);
				}
		});
	}
	
		function addChat(userNickname, cContents, cTime) {
				$('#chatList').append('<div class="row">'+
				'<div class="col-1g-12">' + 
				'<div class="media">' +
				'<a class="pull-left" href="# ">' +

				'<img class="media-object img-circle" src="images/icon.png" alt="">' +
				
				'<div class="media-body">' + 
				'<h4 class="media-heading">'+
				userNickname +
				'<span class="small pull-right">'+
				cTime +
				'</span>'+
				'</h4>'+
				'<p>'+
				cContents +
				'</p>'+
				'</div>'+
				'</div>'+
				'</div>'+
				'</div>'+
				'<hr>');
$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
		function getInfiniteChat(){
			setInterval(function(){
				chatListFunction(lastID);
			},3000);
		}
	
	</script>
</head>
<body>



	<div class="conmtainer bootstrap snippet">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-defoult">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4>
								<i class="fa fa-circle text-green"></i>단체채팅방
							</h4>
						</div>
						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatList" class="porlet-body chat-widget">
							<textarea style="overflow-y: auto; width: 600px; height: 600px;"
								id="textaera" class="form-control"></textarea>
						</div>
						<div class="row" style="height: 90px;">
							<div class="form-group col-xs-10">
								<textarea style="height: 100px; width: 550px;" id="cContents"
									class="form-control" placeholder="채팅을 입력하세요." maxlength="1000"></textarea>
							</div>
							<div class="form-group col-xs-2">
								<button type="button" class="btn btn-defoult pull-right"
									onclick="submitFunction();">전송</button>
								<div class="clearfix"></div>
	   <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel">
        <div class="modal-dialog" role="document">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
            
	<script >
	$('#messageModal').modal("show");

	
	</script>
	
	<%
	session.removeAttribute("messageContent");
	session.removeAttribute("messagetype");
	%>
	<script type="text/javascript">
	$(document).ready(function(){
		chatListFunction('ten');
		getInfiniteChat();
	});
	
	</script>
</body>
</html>