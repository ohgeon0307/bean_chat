<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>채팅방</title>
</head>
<body>

<div class="conmtainer bootstrap snippet">
<div class="row">
<div class="col-xs-12">
<div class="portlet portlet-defoult">
<div class="portlet-heading">
<div class="portlet-title">
<h4><i class="fa fa-circle text-green"></i>개인채팅방</h4>
</div>
<div class="clearfix"></div>
</div>
<div id="chat" class="panel-collapse collapse in">
<div id="chat_List" class="porlet-body chat-widget">
<textarea style="overflow-y: auto; width: 600px; height: 600px;" id="cContents" class="form-control"></textarea>
</div>
<div class="row" style="height: 90px;"> 
<div class="form-group col-xs-10">
<textarea style="height:100px; width:550px;" id="cContents" class="form-control" placeholder="채팅을 입력하세요." maxlength="300"></textarea>
</div> 
<div class="form-group col-xs-2">
<button type="button" class="btn btn-defoult pull-right" onclick="submitFuntion();">전송</button>
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