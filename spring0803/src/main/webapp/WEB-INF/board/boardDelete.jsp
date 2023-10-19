<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.my0803.myapp.domain.BoardVo" %>
<% BoardVo bv = (BoardVo)request.getAttribute("bv"); %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글삭제</title>
<link href="./css/board.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
function check(){
	//alert("클릭확인");
	
	var fm = document.frm;
	
	if (fm.pwd.value ==""){
		alert("비밀번호를 입력해주세요");
		fm.pwd.focus();		
		return;
	}
	
	fm.action="<%=request.getContextPath()%>/board/boardDeleteAction.do";
	fm.method="post";
	fm.submit();	
	
	return;
}


</script>
</head>
<body>

<h1>글삭제페이지</h1>
<form name="frm">
<input type="hidden" name="bidx" value="<%=bv.getBidx()%>">
<table border="1" style="width:600px">
		<tr>
		<th>제목</th>
		<td>
		<%//=bv.getSubject() %>
		</td>
		</tr>		
		<tr>
		<th>비밀번호</th>
		<td>
		<input type="password" name="pwd">		
		</td>
		</tr>		
		<tr>
		<td colspan="2" style="text-align:center;">
		<input type="button" name="smt" value="확인" onclick="check();">
		</td>
		</tr>
</table>
</form>

</body>
</html>