
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
	
	
	
	function autoCloseingAlert(selector,delay)
	{
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {alert.hide()},delay); 
	}
	function submitFuntion(){
		var cFrom = '<%=userId%>';
		var cTo =  '<%=cTo%>';
		var cContents = $('#cContents').val(); 
		$.ajax({
			type:"POST",
			url:"./ChatController",
			data:{
				cFrom:encodeURIComponent(cFrom),
				cTo:encodeURIComponent(cTo),
				cContents:encodeURIComponent(cContents);
				}
			})
		$('#cContents').val('');
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
						<div id="chat_List" class="porlet-body chat-widget">
							<textarea style="overflow-y: auto; width: 600px; height: 600px;"
								id="cContents" class="form-control"></textarea>
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
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>