<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
   BoardDto bdto = (BoardDto)request.getAttribute("bdto");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>빈챗 글쓰기</title>
    <!-- 검색 버튼 아이콘 -->
    <link href="../images/indexImage/beanchat_char.png" rel="shortcut icon"/>
    <!-- include libraries(jQuery, bootstrap) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>


    <link href="../css/reset.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/board/board_comments.css">

    <script>

            $(".cancel").click(function () {
                if (!confirm("이전 화면으로 돌아가시겠습니까? 작성하신 내용은 저장되지 않습니다.")) {
                    return false;
                } else {
                    location.href = "<%=request.getContextPath()%>";
                }

            });
    </script>

    <script>
        $(function () {
            $(".write").click(function () {
                var title = $(".title").val();
                var content = $(".content").val();

                if (title === "") {
                    alert("제목을 입력해주세요.");
                    document.frm.title.focus();
                    return false;
                } else if (content === "") {
                    alert("내용을 입력해주세요.");
                    document.frm.content.focus();
                    return false;
                }

                return true;
            });

            $(".cancel").on("click", function () {
                location.href = "list.do?page=${searchVo.page}"
                        + "&category=${searchVo.category}"
                        + "&order=${searchVo.order}"
                        + "&perPageNum=${searchVo.perPageNum}"
                        + "&searchType=${searchVo.searchType}"
                        + "&searchVal=${searchVo.searchVal}";
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

    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <link href="../css/board/board_contents.css" rel="stylesheet"/>
    <!-- css 연결 -->
</head>
<body>
      <input type="hidden"  value="${uidx}" name="uidx">
      <div id="topMenu">
         <div class="leftElement">
            <a href="../index.jsp"><img role="button" src="../images/indexImage/beanchat_text.png" alt="" class="beanchat_text"></a> 
            <div class="h_div"><h1>글 상세보기</h1></div>
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