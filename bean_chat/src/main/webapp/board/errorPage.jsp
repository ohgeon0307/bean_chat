<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 페이지!</title>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .error-container {
            text-align: center;
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #BCE489;
        }

        p {
            color: #333;
        }

        .btn-container {
            margin-top: 20px;
        }

        .btn-okay {
            background-color: #5bc0de;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        
        .logo-container {
            margin-bottom: 20px;
        }

        .logo-img {
            width: 50%;
            height: auto;
        }
    </style>
</head>
<body>
	<div class="error-container">
	  <div class="logo-container">
            <img class="logo-img" src="../images/indexImage/beanchat_char.png" alt="로고 이미지">
        </div>
        <h1>권한이 없습니다!</h1>
        <p>죄송해요! 수정/삭제 권한이 없는거같아요.
        본인이 작성한 게시글이라면, 관리자에게 문의해보시길 바랍니다!
        </p>
        <div class="btn-container">
            <button class="btn-okay" onclick="redirectToBoardList()">돌아가기</button>
        </div>
    </div>

    <script>
        function redirectToBoardList() {
            // boardList.do로 리다이렉트
            window.location.href = '<%=request.getContextPath()%>/board/boardList.do';
        }
    </script>
</body>
</html>