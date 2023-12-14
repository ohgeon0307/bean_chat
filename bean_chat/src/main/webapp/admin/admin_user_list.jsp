<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="app.dto.*" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원목록</title>
    <link
      href="../images/indexImage/beanchat_char.png"
      rel="shortcut icon"
    />
    <!--파비콘-->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"
    />
    <!--검색 버튼 아이콘-->
    <link href="../css/board/board_list.css" rel="stylesheet" />
    <!--css 연결-->
</head>
<body>
	<header>
			<div class="container"> 
			<img src="../images/indexImage/beanchat_text.png" alt="" class="beanchat_text">    
	        <div class="items">
	            <ul>
		           <li> 
	            		<c:if test="${admin == 'admin' }">
	            			<a href="<%=request.getContextPath()%>/admin/userList.do"><i class="xi-crown xi-4x" style="color:gold;"></i></a>
	            		</c:if>
	            	</li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"><img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
	        				</c:when>
	            			<c:otherwise>
	            				<a href="<%=request.getContextPath()%>/user/userLogout.do" onclick="return confirm('로그아웃 하시겠습니까?')"><img role="button" src="../images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
	            			</c:otherwise>
	            		</c:choose>
	            	</li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="<%=request.getContextPath()%>/mypage/myMain.do"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
	                		</c:otherwise>
	                	</c:choose>
	                </li>
	                <li><a href="<%=request.getContextPath()%>/board/boardList.do"><img role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a></li>
	                <li>
	                	<c:choose>
	                		<c:when test="${uidx== null }">
	                			<a href="<%=request.getContextPath()%>/user/userLogin.do"onclick="return alert('로그인이 필요합니다.')"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="<%=request.getContextPath()%>/chat/chatList.do"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
	                		</c:otherwise>
	                	</c:choose>
	                </li>	
	            </ul>
			</div><!-- //.items -->
		</div> <!-- //.container -->
	</header>
	<main>
		<h1>회원 관리</h1>
		<div id="inner">
			<div class="boardSet">
				<div class="boardSearch">
					<select class="searchFilter">
						<option>uidx</option>
						<option>아이디</option>
						<option>닉네임</option>
						<option>이름</option>
					</select>
					<input type="text" placeholder="검색어를 입력하세요" />
					<button type="submit" class="bSearchBtn"> 검색</button>
				</div><!-- //.boardSearch-->
			</div><!--//.boardSet-->
        
			<div class="boardList">
				<ul>
					<c:forEach items="${alist }" var ="udto">
					<li>
						<a href="${pageContext.request.contextPath}/admin/adminUserDelete.do?uidx=${udto.uidx}">
							<span class="boardContent">
								uidx: ${udto.uidx}  아이디 : ${udto.userId } 이름 : ${udto.userName }  닉네임 : ${udto.userNickname }  가입일 : ${udto.userDate }
							</span><!-- //.boardContent -->
						</a>
					</li>
					</c:forEach>
				</ul>
			</div> <!--//.boardList-->
	        <div id="boardOption">
				<div class="pager"><p>◀ pager가 들어갈 자리입니다 ▶</p></div><!--end: .pager-->
				<div class="btnBar">
					<a href="${pageContext.request.contextPath}/board/boardWrite.do">글쓰기</a>
				</div> <!--//.bthBar-->
			</div><!--//#boardOption-->
		</div><!--// #inner-->
	</main>
    <footer>
      <div id="slogan">
        <img src="../images/indexImage/beanchat_char.png" width="200px" />
        <p>Beanchat, the collaborative chat web application System.</p>
      </div> <!--end: #slogan-->
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
          빈챗 &#124; 팀원 : 최다혜 안기현 임세현 오 건 <br/>
          Beanchat &#124; 전주시 덕진구 백제대로 572 4층 이젠컴퓨터아트서비스학원<br />
          © 2023 Beanchat Ltd. All rights reserved.
        </p> <!--end: .companyInfo-->
      </div><!--end: #footerMenu-->
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
      </div><!--end: #sns-->
    </footer><!--end: footer-->
</body>


</html>