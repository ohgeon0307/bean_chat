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
<!-- 제이쿼리 연결 -->
	<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"> </script>
    <!--파비콘-->
    <link href="../images/indexImage/beanchat_char.png" rel="shortcut icon"/>
    <!--검색 버튼 아이콘-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>
    <!--css 연결-->
    <link href="../css/admin/admin_user_list.css" rel="stylesheet" />
    <link href="../css/reset.css" rel="stylesheet" />
    <link href="../css/admin/admin_user_list.css" rel="stylesheet" />
	<script>
	    $(document).ready(function() {
	        // '전체 선택/해제' 체크박스 클릭 시 동작
	        $('#selectAllCheckbox').on('click', function() {
	            // 모든 사용자 체크박스들의 상태를 전체 선택/해제 체크박스와 동일하게 설정
	            $('input[name="uidx"]').prop('checked', $(this).prop('checked'));
	        });
	
	        // 사용자 체크박스 클릭 시 전체 선택/해제 체크박스 상태 변경
	        $('input[name="uidx"]').on('click', function() {
	            var allChecked = true;
	            $('input[name="uidx"]').each(function() {
	                if (!$(this).prop('checked')) {
	                    allChecked = false;
	                }
	            });
	            $('#selectAllCheckbox').prop('checked', allChecked);
	        });
	    });
	</script>
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
		<div class="userSearch">
					<form name="sFrm" id="sFrm" action="${pageContext.request.contextPath}/admin/userList.do" method="post">
						<select name="searchType" class="searchFilter">
							<option value="uidx">UIDX</option>
							<option value="userId">아이디</option>
							<option value="userName">이름</option>
							<option value="userNickname">닉네임</option>
						</select>
						<input type="text" placeholder="검색어를 입력하세요" name="keyword" /> 
						<input type="submit" name="sbt" class="uSearchBtn" value="검색">
					</form><!-- searchForm -->
				</div><!-- //.userSearch-->

        
		<form name="frm" id="frm" action="${pageContext.request.contextPath}/admin/adminUserDelete.do" method="post">
				<input type="checkbox" id="selectAllCheckbox"> 전체 선택/해제
				<table class="userList">
					<thead>
			            <tr>
			                <th>선택</th>
			                <th>UIDX</th>
			                <th>아이디</th>
			                <th>이름</th>
			                <th>닉네임</th>
			                <th>가입일</th>
			            </tr>
			        </thead>
			        <tbody>
						<c:forEach items="${alist }" var ="udto">
							<tr>
								<td><input type="checkbox" name="uidx" value="${udto.uidx}"></td>
								<td>${udto.uidx}</td>
			                    <td>${udto.userId}</td>
			                    <td>${udto.userName}</td>
			                    <td>${udto.userNickname}</td>
			                    <td>${udto.userDate}</td>
							</tr>
	            		</c:forEach>
					</tbody>
				</table> <!--//.userList-->
				<div class="btnBar">
					<input type="submit" name="delBtn" class="delBtn" value="선택된 회원 탈퇴">
				</div>
			</form><!-- deleteForm -->

			<div id="pageOption">
				<div class="pager">
					<c:if test="${pmdto.prev}">
						<a href="${pageContext.request.contextPath}/admin/userList.do?page=${pmdto.startPage - 1}&searchType=${scri.searchType}&keyword=${scri.keyword}">&lt;</a>
					</c:if>

					<c:forEach begin="${pmdto.startPage}" end="${pmdto.endPage}" var="pageNum">
						<c:choose>
						
							<c:when test="${pageNum eq scri.page}">
								<span class="current">${pageNum}</span>
							</c:when>
							
							<c:otherwise>
								<a href="${pageContext.request.contextPath}/admin/userList.do?page=${pageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">${pageNum}</a>
							</c:otherwise>
							
						</c:choose>
					</c:forEach>

					<c:if test="${pmdto.next}">
						<a href="${pageContext.request.contextPath}/admin/userList.do?page=${pmdto.endPage + 1}&searchType=${scri.searchType}&keyword=${scri.keyword}">&gt;</a>
					</c:if>
				</div><!--end: .pager-->

				
			</div><!--end: #pageOption-->
		</div><!--end: #inner-->
		
	</main>


    <footer>
		<div id="slogan">
	        <img src="../images/indexImage/beanchat_char.png" width="200px" />
	        <p>Beanchat, the collaborative chat web application System.</p>
		</div><!--end: #slogan-->
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
	        <p class="companyInfo">빈챗 &#124; 팀원 : 최다혜 안기현 임세현 오 건 <br/>
	        	Beanchat &#124; 전주시 덕진구 백제대로 572 4층 이젠컴퓨터아트서비스학원<br />
				© 2023 Beanchat Ltd. All rights reserved.
			</p><!--end: .companyInfo-->
		</div><!--end: #footerMenu-->
		<div id="sns">
			<ul>
				<li><a href="#"><i class="xi-instagram xi-2x"></i></a></li>
				<li><a href="#"><i class="xi-facebook xi-2x"></i></a></li>
				<li><a href="#"><i class="xi-kakaotalk xi-2x"></i></a></li>
			</ul>
		</div><!--end: #sns-->
	</footer>
</body>


</html>