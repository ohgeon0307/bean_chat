<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="app.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>빈챗 자유게시판</title>
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
    <div class="container">
      <img src="../images/indexImage/beanchat_text.png" alt="" class="beanchat_text">    
      <div class="items">
          <ul>
              <li><a href="#"><img role="button" src="../images/indexImage/login_icon.png" alt=""><span>로그인</span></a></li>
              <li><a href="#"><img role="button" src="../images/indexImage/mypage_icon.png" alt=""><span>마이페이지</span></a></li>
              <li><a href="#"><img role="button" src="../images/indexImage/board_icon.png" alt=""><span>게시판</span></a></li>
              <li><a href="#"><img role="button" src="../images/indexImage/chat_icon.png" alt=""><span>채팅</span></a></li>
          </ul>
      </div>
  </div>
    <!--end: nav-->
    <main>
      <h1>자유게시판</h1>
      <div id="inner">
        <div class="boardSet">
          <div class="boardSearch">
            <select class="searchFilter">
              <option>제목</option>
              <option>내용</option>
              <option>작성자</option>
            </select>
            <input type="text" placeholder="검색어를 입력하세요" /><button
              type="submit"
              class="bSearchBtn"
            >
              검색
            </button>
          </div>
          <!--end: .boardSearch-->
          
          <!--end: .boardSelect-->
        </div>
        <!--end: .boardSet-->
        <div class="boardList">
          <ul>
            <li>
              <a href="#">제목을 입력하세요</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">Stay foolish, Stay hungry</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">
                흐르는강물을거꾸로거슬러오르는연어들의도무지알수없는 그들만의
                신비한 이유처럼 그 언제 서부터인가 걸어 걸어 걸어오는 이길
                앞으로 얼마나 더 많이 가야만 하는지
              </a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">안녕 안녕 안녕 안녕 안녕 안녕 안녕안녕안녕안녕안녕</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  20930 &nbsp;&#124;&nbsp; 댓글수 1000 &nbsp;&#124;&nbsp; 추천수
                  2000
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">coffeecoffeecoffeecoffeecoffeecoffeecoffee</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">FONTFONTFONTFONTFONTFONTFONTFONTFONTFONTFONT</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">글 제목</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">글 제목</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">글 제목</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">글 제목</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">글 제목</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">글 제목</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">글 제목</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">글 제목</a>
              <div class="boardContent">
                <span>자유</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
            <li>
              <a href="#">글 제목</a>
              <div class="boardContent">
                <span>후기</span>
                <p>
                  작성자 &nbsp;&#124;&nbsp; 2023.01.16 &nbsp;&#124;&nbsp; 조회수
                  0 &nbsp;&#124;&nbsp; 댓글수 0 &nbsp;&#124;&nbsp; 추천수 0
                </p>
              </div>
              <!--end: boardContent-->
            </li>
          </ul>
        </div>
        <!--end: .boardList-->
        <div id="boardOption">
          <div class="pager"><p>◀ pager가 들어갈 자리입니다 ▶</p></div>
          <!--end: .pager-->
          <div class="btnBar">
            <a href="#">글쓰기</a>
          </div>
          <!--end:.bthBar-->
        </div>
        <!--end: #boardOption-->
      </div>
      <!--end: #inner-->
    </main>
    <!--end: main-->
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
    <!--end: footer-->
  </body>
</html>
