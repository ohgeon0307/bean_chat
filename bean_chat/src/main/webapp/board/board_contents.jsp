<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
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
<link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"
    />
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
<link href="../css/reset.css" rel="stylesheet" />
<link rel="stylesheet" href="../css/board/board_comments.css">

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
        	if(!confirm("메인으로 돌아가시겠습니까?")){
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
	$(function(){
		$(".write").click(function(){
			var title = $(".title").val();		
			var content = $(".content").val();

			if(title == ""){
				alert("제목을 입력해주세요.");
				document.frm.title.focus();
				return false;
			}else if(content
					== ""){
				alert("내용을 입력해주세요.");
				document.frm.content.focus();
				return false;
			}
			
			return true;
		});
		
		$(".cancel").on("click", function(){
			
			location.href ="list.do?page=${searchVo.page}"
						  +"&category=${searchVo.category}"
						  +"&order=${searchVo.order}"
				   		  +"&perPageNum=${searchVo.perPageNum}"
				   	 	  +"&searchType=${searchVo.searchType}"
				   		  +"&searchVal=${searchVo.searchVal}";
		})
	});
	</script>
	
	<script>
  function confirmDelete(bidx) {
    if (confirm("게시글을 삭제하시겠습니까?")) {
      location.href = '<%=request.getContextPath()%>/board/boardDeleteAction.do?bidx=' + bidx;
    }
  }
</script>

<script>
$(document).ready(function(){
	$.boardCommentList();
	
	// 버튼을 클릭하면 입력된 데이터를 가지고 commentWrite.do로 넘겨서 DB에 입력한다
	$("#save").on("click",function(){
		//alert("클릭");
		
		let rwriter = $("#rwriter").val();
		let rcontents = $("#rcontents").val();
		let bidx = <%=bdto.getBidx()%>;
		let uidx = <%=session.getAttribute("uidx")%>;
		
		$.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/comment/commentWrite.do",
			dataType : "json",
			data : {
				"bidx" : bidx,
				"uidx" : uidx,
				"rwriter" : rwriter,
				"rcontents" : rcontents
			},
			
			cache : false,
			success : function(data){
				//alert("통신성공");
				//alert("data.value");
				//if(data.value ==1){
					//alert("등록성공");
				//}
			$.boardCommentList();     // 새로고침없이 바로등록됨
			$("#rwriter").val("");
			$("#rcontents").val("");
			},
			error : function(){
				alert("통신오류 실패");
			}
		});
	});
});

$.boardCommentList = funtion(){
	$.ajax({
		type : "get",
		url : "<%=request.getContextPath()%>/comment/commentList.do",
		dataType : "json",
		cache : false,
		success : function(data){
			//alert("통신성공");
		        
			commentList(data);
			//$.each(data,function(index){
				//alert(index);
				//alert(data[index].replyidx);
			//})
		
		},
		error : function(){
			alert("통신오류 실패");
		}
	});
}

function commentDel(replyidx){
	
	$.ajax({
		type : "get",
		url : "<%=request.getContextPath()%>/comment/commentDelete.do?replyidx="+replyidx,
		dataType : "json",
		cache : false,
		success : function(data){
			//alert("통신성공");
			if(data.value == 1){
				alert("삭제성공");
			}
		        
			$.commentList();
			//$.each(data,function(index){
				//alert(index);
				//alert(data[index].cidx);
			//})
		},
		error : function(){
			alert("통신오류 실패");
		}
	});
	return;
}

function commentList(data){
	
	var str ="";
	str = "<tr><td>번호</td><td>작성자</td><td>내용</td><td>등록일</td></tr>"
	
	var delBtn = "";
	
	var loginUidx = "<%=session.getAttribute("uidx")%>";
	
	$(data).each(function(){
		
		if(loginUidx == this.uidx){
			delBtn="<button type='button' id='btn' onclick='commentDel("+this.replyidx+");'>삭제</button>";
		}else {
			delBtn="";
		}
		
		str = str + "<tr><td>"+this.replyidx+"</td><td>"+this.rwriter+"</td><td>"+this.rcontent+"</td><td>"+this.rdate+"</td><td>"+delBtn+"</td></tr>"
	});
	
	%("#tbl").html("<table border=1 style='width:600px>'"+str+"</table>");
	
	return;
}
</script>

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<link href="../css/board/board_contents.css" rel="stylesheet" />
<!--css 연결-->
</head>
<body>
		<input type="hidden" value="${udto.userNickname}" name="writer">
		<div id="topMenu">
			<div class="leftElement">
				<a href="#" class="logo"> <img
					src="../images/indexImage/beanchat_text.png"
					
              width="220px" />
				</a>
				<h1>글 상세보기</h1>
			</div>
			<!--end: .leftElement-->
			<%-- <div class="rightElement">
				<a href="#" class="cancel">취소</a>
				<button class="write">등록</button>
				<p class="nickname">
					<span>${udto.userNickname}</span> 님
				</p>
				<img
					src="<%=request.getContextPath()%>/resources/upload/${login.stname}"
					class="memberImage"
					style="width: 45px; height: 45px; border-radius: 30px;">
			</div> --%>
			<!--end: .rightElement-->
		</div>
		<!--end: #topMenu-->
	<main>
        <p class="view">게시글 상세보기</p>
      <div class="main">

        <div id="viewTitle">
		    <p class="title">제목 : <%=bdto.getSubject() %></p>
			<hr/>
		</div>

        <div id="viewDate">
            <p class="date">작성날짜 : <%=bdto.getWriteDate() %></p>
            <hr/>
        </div>

        <div id="viewWriter">
            <p class="writer">작성자 : <%=bdto.getWriter() %></p>
            <hr/>
        </div>



		<div id="viewContent">
			<p class="contents">
				<%=bdto.getContents() %>
			</p>
            <div class="center-buttons">
            <a href="${pageContext.request.contextPath}/board/boardList.do"><button>목록</button></a>
            <button type="button" onclick="location.href='<%=request.getContextPath()%>/board/boardModify.do?bidx=<%=bdto.getBidx()%>'">수정</button>
            <button type="button" onclick="confirmDelete('<%=bdto.getBidx()%>')">삭제</button>
            </div>
		</div>
		
    </div>
    
     
    
    
	</main>
	<div id="commentSection">
            <h2>댓글</h2>
            <%-- 댓글 목록 출력 --%>
            <ul class="commentList">
                <c:forEach items="${commentList}" var="comment">
                    <li>
                        <p class="commentWriter">${comment.getWriter()}</p>
                        <p class="commentContent">${comment.getContent()}</p>
                        <p class="commentDate">${comment.getWriteDate()}</p>
                    </li>
                </c:forEach>
            </ul>
            <%-- 댓글 작성 폼 --%>
            <form action="${pageContext.request.contextPath}/board/addComment.do" method="post">
                <input type="hidden" name="bidx" value="${bdto.getBidx()}">
                <label for="commentContent">댓글 작성:</label>
                <textarea id="commentContent" name="content" rows="4" cols="50"></textarea>
                <button type="submit">댓글 등록</button>
            </form>
        </div>
	
	<!--end: main-->
	<!--end: form-->
		<footer>
      <div id="slogan">
        <img
          src="../images/indexImage/beanchat_char.png"
          width="200px"
        />
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
          빈챗 &#124; 팀원 : 최다혜 안기현 임세현 오 건 <br/>Beanchat &#124; 전주시 덕진구 백제대로
          572 4층 이젠컴퓨터아트서비스학원
          <br />
          © 2023 Beanchat Ltd. All rights reserved.
        </p>
        <!--end: .companyInfo-->
      </div>
      <!--end: #footerMenu-->
      <div id="sns">
        <ul>
          <li>
            <a href="#"><i class="xi-instagram xi-2x"></i></a>
          </li>
          <li>
            <a href="#"><i class="xi-facebook xi-2x"></i></a>
          </li>
          <li>
            <a href="#"><i class="xi-kakaotalk xi-2x"></i></a>
          </li>
        </ul>
      </div>
      <!--end: #sns-->
    </footer>
</body>
</html>