<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	BoardDto bdto = (BoardDto) request.getAttribute("bdto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빈챗 글쓰기</title>
<!--검색 버튼 아이콘-->

<link href="../images/indexImage/beanchat_char.png" rel="shortcut icon" />
<!--파비콘-->
<!-- include libraries(jQuery, bootstrap) -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css" />
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>


<!-- include summernote css/js-->

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<script src="/resources/summernote-lite.js"></script>
<script src="/resources/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/summernote-lite.css">

<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<script>
      $(document).ready(function () {
        $("#summernote").summernote({
          width: 1500,
          height: 600, // set editor height
          minHeight: 600, // set minimum height of editor
          maxHeight: 600, // set maximum height of editor
          focus: true, // set focus to editable area after initializing summernote
          lang: "ko-KR", // default: 'en-US'
          fontNames: [
            "Nanum Gothic",
            "sans-serif",
            "돋움",
            "Dotum",
            "Arial",
            "Arial Black",
            "Comic Sans MS",
            "Courier New",
            "Helvetica",
            "Impact",
            "Tahoma",
            "Times New Roman",
            "Verdana",
            "Roboto",
          ],
          defaultFontName: "Nanum Gothic",
          fontSizes: ["8", "9", "10", "11", "12", "14", "18"],
          toolbar: [
            ["style", ["style"]],
            ["font", ["bold", "italic", "underline", "clear"]],
            ["fontname", ["fontname"]],
            ["color", ["color"]],
            ["fontsize", ["fontsize"]],
            ["para", ["ul", "ol", "paragraph"]],
            ["height", ["height"]],
            ["table", ["table"]],
            ["insert", ["link", "picture", "hr"]],
            ["view", ["fullscreen", "codeview"]],
            ["help", ["help"]],
          ],
        });

        $(".title").keyup(function (e) {
          var content = $(this).val();
          $("#counter").html("(" + content.length + " / 40)"); //글자수 실시간 카운팅

          if (content.length > 40) {
            $(".errorMsg").html("제목은 최대 40자까지 입력 가능합니다.");
            $(".errorMsg").css("float", "right");
            $(".errorMsg").css("color", "red");
            $(".errorMsg").css("font-size", "15px");
            $(".errorMsg").css("font-style", "italic");

            $(this).val(content.substring(0, 40));
            $("#counter").html("(40 / 40)");
          } else {
            $(".errorMsg").html("");
          }
        });
        
        $(".logo").click(function(){	
        	if(!confirm("메인으로 돌아가시겠습니까? 작성하신 내용은 저장되지 않습니다.")){
				return false;
        	}else{
        		location.href="<%=request.getContextPath()%>";
        	}
        	
         });
        
        $(".cancel").click(function(){	
        	if(!confirm("이전 화면으로 돌아가시겠습니까? 작성하신 내용은 저장되지 않습니다.")){
				return false;
        	}else{
        		location.href="<%=request.getContextPath()%>";
        	}
        	
         });
        
      });
    </script>

<script>
function check(){

    var fm = document.frm;

    if (fm.subject.value == "") {
      alert("제목을 입력해주세요.");
      fm.subject.focus();
      return false;
    } else if (fm.contents.value == "") {
      alert("내용을 입력해주세요.");
      fm.contents.focus();
      return false;
    }
  
	fm.action = "<%=request.getContextPath()%>/board/boardModifyAction.do";
	fm.method = "post";
	fm.submit();
	return;
}
	</script>

<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<link href="../css/board/board_write.css" rel="stylesheet" />
<!--css 연결-->
</head>
<body>
	<form name="frm">
		<input type="hidden" value="${udto.userNickname}" name="writer">
		<input type="hidden" name="bidx" value="<%=bdto.getBidx()%>">
		<div id="topMenu">
			<div class="leftElement">
				<a href="#" class="logo"> <img
					src="../images/indexImage/beanchat_text.png" width="220px" />
				</a>
				<h1>글쓰기 Editor</h1>
			</div>
			<!--end: .leftElement-->
			<div class="rightElement">
				<a href="#" class="cancel">취소</a>
				<button class="write" onclick="check();">수정</button>
				<p class="nickname">
					<span>${udto.userNickname }</span> 님
				</p>
				<img
					src="<%=request.getContextPath()%>/resources/upload/${login.stname}"
					class="memberImage"
					style="width: 45px; height: 45px; border-radius: 30px;">
			</div>
			<!--end: .rightElement-->
		</div>
		<!--end: #topMenu-->
		<main>
			<div id="title">
				<select class="category" name="category">
					<option>자유</option>
					<option>후기</option>
				</select> <input type="text" name="subject" class="title" minlength="2"
					maxlength="40" value="<%=bdto.getSubject()%>" /> <span
					style="color: #aaa; font-size: 15.5px" id="counter">(0 / 40)</span>
				<br /> <span class="errorMsg"></span>
			</div>
			<!--end: title-->
			<textarea id="summernote" class="content" name="contents">
         	<%=bdto.getContents()%>
        	</textarea>
			<input type="file" name="filename">
		</main>
		<!--end: main-->
	</form>
	<!--end: form-->
	<footer>
		<div id="slogan">
			<img src="../images/indexImage/beanchat_char.png" width="200px" />
			<p>Beanchat, the collaborative chat web application System.</p>
		</div>
		<!--end: #slogan-->
		<div id="footerMenu">
			<ul>
				<li><a href="#">팀 소개</a></li>
				<p>&#124;</p>
				<li><a href="#">개인정보처리방침</a></li>
				<p>&#124;</p>
				<li><a href="#">이용약관</a></li>
				<p>&#124;</p>
				<li><a href="#">도움말</a></li>
				<p>&#124;</p>
				<li><a href="#">공지사항</a></li>
			</ul>
			<p class="companyInfo">
				빈챗 &#124; 팀원 : 최다혜 안기현 임세현 오 건 <br />Beanchat &#124; 전주시 덕진구 백제대로
				572 4층 이젠컴퓨터아트서비스학원 <br /> © 2023 Beanchat Ltd. All rights
				reserved.
			</p>
			<!--end: .companyInfo-->
		</div>
		<!--end: #footerMenu-->
		<div id="sns">
			<ul>
				<li><a href="#"><i class="xi-instagram xi-2x"></i></a></li>
				<li><a href="#"><i class="xi-facebook xi-2x"></i></a></li>
				<li><a href="#"><i class="xi-kakaotalk xi-2x"></i></a></li>
			</ul>
		</div>
		<!--end: #sns-->
	</footer>
</body>
</html>