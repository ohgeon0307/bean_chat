<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
            <title>내 프로필 보기</title>
            <!-- css연결 -->
            <link href="../css/reset.css" rel="stylesheet"/>
            <link href="../css/mypage/my_profile.css" rel="stylesheet"/>
			<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
			
            <!-- 제이쿼리 연결 -->
            <script
                src="https://code.jquery.com/jquery-3.6.1.min.js"
                integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
                crossorigin="anonymous"></script>
            <script>
                function changeForm(val) {

                    var fm = document.frm;

                    if (val == "0") {
                        fm.method = "post";
                        fm.action = "<%=request.getContextPath()%>/mypage/myModify.do"; //처리하기위해 이동하는 주소
                        fm.submit();
                        return;
                    } else if (val == "1") {
                        fm.method = "post";
                        fm.action = "<%=request.getContextPath()%>/mypage/myMain.do"; //처리하기위해 이동하는 주소
                        fm.submit();
                        return;
                    }

                }
            </script>

        </head>
        <body>
            <header>
                <!-- 헤더 시작 -->
                <div class="container">
                    <img src="../images/indexImage/beanchat_text.png" alt="" class="beanchat_text">
                        <div class="items">
                            <ul>
                                <li>
                                    <a href="<%=request.getContextPath()%>/user/userLogin.do">
                                        <img role="button" src="../images/indexImage/login_icon.png" alt="">
                                            <span>로그인</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="<%=request.getContextPath()%>/mypage/myMain.do">
                                            <img role="button" src="../images/indexImage/mypage_icon.png" alt="">
                                                <span>마이페이지</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/board/boardList.do">
                                                <img role="button" src="../images/indexImage/board_icon.png" alt="">
                                                    <span>게시판</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="<%=request.getContextPath()%>/chat/chatList.do">
                                                    <img role="button" src="../images/indexImage/chat_icon.png" alt="">
                                                        <span>채팅</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <!-- //.items -->
                                    </div>
                                    <!-- //.container -->
                                </header>
                                <!-- 헤더 종료 -->
                                <main>
                                    <h1>My Page</h1>
                                    <hr>
                                        <h2>나의 프로필</h2>
                                        
                                            <form name="frm" id="frm">
												<div id="main_view">
                                                <section id="pro_image">
                                                	
            											<img src="${profileImg}${udto.userImage}" id="member-profile">
            										
                                                </section>
                                                <section id="pro_info">
                                                    <div class="pro_title">
                                                        <label>닉네임</label>
                                                        <span>${udto.userNickname}</span>
                                                    </div>
                                                    <!-- //.pro_text -->

                                                    <div class="pro_text">
                                                        <label>ID(Email) :</label>
                                                        <span>${udto.userId}</span>
                                                    </div>
                                                    <!-- //.pro_text -->

                                                    <div class="pro_text">
                                                        <label>이름 :</label>
                                                        <span>${udto.userName}</span>
                                                    </div>
                                                    <!-- //.pro_text -->

                                                    <div class="pro_text">
                                                        <label>전화번호 :</label>
                                                        <span>${udto.userPhone}</span>
                                                    </div>
                                                    <!-- //.pro_text -->

                                                    <div class="pro_text">
                                                        <label>생년월일 :</label>
                                                        <span>${udto.userBirth}</span>
                                                    </div>
                                                    <!-- //.pro_text -->

                                                    <div class="pro_text">
                                                        <label>가입일 :</label>
                                                        <span>${udto.userDate}</span>
                                                    </div>
                                                    <!-- //.pro_text -->
                                                </section>
												<button type="button" id="modiBtn" onclick="changeForm(0)"><i class="xi-pen"></i>내 정보 수정하러 갈래요! <i class="xi-long-arrow-right"></i></button>
											</div>
                                                <input type="button" id="backBtn" value="목록 돌아가기" onclick="changeForm(1)">

												
											</form>


                                            </main>
                                        </body>
                                    </html>