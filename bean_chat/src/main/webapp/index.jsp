<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="UTF-8">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>beanchat</title>
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link rel="stylesheet" href="./full-page-js/fullpage.min.css" />
    <link rel="stylesheet" href="./css/index.css">
    <link
      href="../images/indexImage/beanchat_char.png"
      rel="shortcut icon" 
    />
    <!--파비콘-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="./full-page-js/fullpage.min.js"></script>
</head>

<body>
    
    <div class="container"> <!-- 헤더 시작 -->
        <img src="./images/indexImage/beanchat_text.png" alt="" class="beanchat_text">    
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
                			<a href="<%=request.getContextPath()%>/user/userLogin.do"><img role="button" src="./images/indexImage/login_icon.png" alt=""><span>로그인</span></a>
        				</c:when>
            			<c:otherwise>
            				<a href="<%=request.getContextPath()%>/user/userLogout.do" onclick="return confirm('로그아웃 하시겠습니까?')"><img role="button" src="./images/indexImage/logout_icon.png" alt=""><span>로그아웃</span></a>
            			</c:otherwise>
            		</c:choose> 
            	</li>
                <li>
                	<c:choose>
                		<c:when test="${uidx== null }">
                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')"><img role="button" src="./images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
                		</c:when>
                		<c:otherwise>
                			<a href="<%=request.getContextPath()%>/mypage/myMain.do"><img role="button" src="./images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a>
                		</c:otherwise>
                	</c:choose>
                </li>
                
                <li>
                	<c:choose>
                		<c:when test="${uidx==null }">
                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')"><img role="button" src="./images/indexImage/board_icon.png" alt=""><span>게시판</span></a>
                		</c:when>
                		<c:otherwise>
                			<a href="<%=request.getContextPath() %>/board/boardList.do"><img role="button" src="./images/indexImage/board_icon.png" alt=""><span>게시판</span></a>
                		</c:otherwise>
                	</c:choose>
                </li>
                <li>
                <c:choose>
                	<c:when test="${uidx==null }">
                		<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')"><img role="button" src="./images/indexImage/announcement_icon.png" alt=""><span>공지사항</span></a>
                	</c:when>
                	<c:otherwise>
                		<a  href="<%=request.getContextPath()%>/notice/noticeList.do"><img role="button" src="./images/indexImage/announcement_icon.png" alt=""><span>공지사항</span></a>
               		</c:otherwise>
                </c:choose>
                </li>
                <li>
                	<c:choose>
                		<c:when test="${uidx== null }">
                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')"><img role="button" src="./images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
                		</c:when>
                		<c:otherwise>
                			<a href="<%=request.getContextPath()%>/chat/chatIndex.do"><img role="button" src="./images/indexImage/chat_icon.png" alt=""><span>채팅</span></a>
                		</c:otherwise>
                	</c:choose>
                </li>	
            </ul>
        </div>
    </div> <!-- 헤더 종료 -->

    <div id="full-page"> <!-- full-page section 나누기 시작 -->


        <div class="section s0"> <!-- full-page section 첫번째 시작 -->
            <div class="main">
                <div class="main_text_image">
                     <img src="./images/indexImage/BeanchatTitle1.png" alt="" class="Beanchat_title">
                    
                    <p>빈챗은 가볍고 쉬운 웹 채팅 어플리케이션 입니다.</p>
                    <img src="./images/indexImage/BeanChatWater.png" alt="" class="Beanchat_water">
                </div>
               
            </div>
        </div> <!-- full-page section 첫번째 종료 -->

        <div class="section s1"> <!-- full-page section 두번째 시작 -->
            <div class="main">
                <div class="main_text_image">
                    <img src="./images/indexImage/BeanchatTitle2.png" alt="" class="Beanchat_title2">
                    <p>우리는 어쩌면 작은 콩들이 아닐까요?</p>
                    <p> 빈챗의 웹 채팅 어플리케이션은 마치 작은 완두콩처럼 작지만,</p>
                     <p>끊임없는 가능성을 품고 발전하는 시스템입니다.</p>
                     <p>작은 완두콩같은 사람들이 모여 채팅을 하고, </p>
                     <p>지속적인 소통으로 좋은 관계를 이루어낼 수 있음을 증명해보고 싶습니다. </p>
                     <p>자, 그럼 시작해볼까요 ?</p>
                     <c:choose>
                		<c:when test="${uidx== null }">
                			<a href="<%=request.getContextPath()%>/user/userLogin.do" onclick="return alert('로그인이 필요합니다.')">시작하기!</a>
                		</c:when>
                		<c:otherwise>
                			<a href="<%=request.getContextPath()%>/chat/chatIndex.do">시작하기!</a>
                		</c:otherwise>
                	</c:choose>
                     
                </div>
            </div>
        </div> <!-- full-page section 두번째 종료-->

    </div>
    <figure class="scroll_image01"> <!-- 스크롤 애니메이션용 figure 태그 시작 -->
        <img src="./images/indexImage/scroll.png">
    </figure> <!-- 스크롤 애니메이션용 figure 태그 종료 -->

    <script> // full-page 적용을 위한 라이브러리 코드 작성
        new fullpage('#full-page', {
            licenseKey: '',
            sectionsColor: ['#BCE489', '#BCE489', '#BCE489', '#BCE489'],
            navigation: true,
            navigationTooltips: ['Beanchat', 'About', 'Chatting', '오점뭐?'],
            scrollingSpeed: 1500,
            onLeave: function (origin, destination, direction) {
                console.log('onLeave', origin.index);
                //스크롤 시작시 실행 (이벤트 핸들러 콜백)
                //origin : 원래 있었던 섹션의 대한 정보
                //destination : 다음 목적지 섹션
                //direction : 섹션의 방향
                if (origin.index == 1) {
                    $('.s1 h3').hide();
                }

            },
            afterLoad: function (origin, destination, direction) {
                console.log('afterLoad');
                //스크롤 종료시 실행 (이벤트 핸들러 콜백)
                if (destination.index == 1) { //만약 destination(다음 목적지 세션이 section 1이라면)
                    $('.scroll_image01').hide(); //scroll 이미지를 숨기겠다.
                }

                if (destination.index == 0) { //만약 destination(다음 목적지 세션이 0이라면(위로 올라갈 경우))
                    $('.scroll_image01').show(); //scroll 이미지를 다시 보여주겠다.
                }

            }
        });
    </script>

</body>

</html>