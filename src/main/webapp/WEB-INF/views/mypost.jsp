<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>후기 수정</title>
    <link rel = 'stylesheet' href = "/static/css/header.css">
    <link rel = 'stylesheet' href = "/static/css/css.css">

</head>


<body>
<div id = 'head' class="header">
    <img src="/static/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="65px" onclick="location.href='/'">


    <div class="button-container" id="buttonContainer">
        <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
        <button class="button" id="logoutBtn" style="margin:10px; " onclick="logout()">로그아웃</button>
        <input class="button" type="button" id="loginBtn" value="로그인" style="margin: 7px; margin-right: 15px;" onclick="location.href='login'">
        <input class="button" type="button" id="joinBtn" value="회원가입" style="margin: 7px; margin-right: 15px;" onclick="location.href='join'">
    </div>


    <div class="nav__bar">
        <ul class="nav__menu">
            <li><a href="main.html" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 홈 </a></li>
            <li><a href="storeList.html" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 후기 목록 </a></li>
            <li><a id = 'freebtn' onclick= "mine()" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 자유게시판 </a></li>
            <li><a id = 'mypagebtn' onclick= "my()" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 마이페이지 </a></li>
        </ul>
    </div>
</div>
</body>



<style type="text/css">
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

    * {
        margin: 0px;
        font-family: "Do Hyeon";

    }
</style>
<body>
<div class="board_wrap">
    <div class="board_title">
        <strong>알바 후기 게시판(수정)</strong>
        <p>작성한 후기를 확인해주세요.</p>
    </div>
    <div class="board_write_wrap">
        <div class="board_write">
            <div class="title">
                <dl>
                    <dt>제목</dt>
                    <dd><input type="text" name = "subject" placeholder="제목 입력"></dd>
                </dl>
            </div>
            <div class="info">
                <dl>
                    <dt>아이디</dt>
                    <dd><input type="text" name = "id" placeholder="아이디 입력"></dd>
                </dl>
            </div>
            <div class="cont">
                <textarea name = "content" placeholder="내용 입력"></textarea>
            </div>
        </div>
        <div class="bt_wrap">
            <a href="#" id="editbtn" class="on">수정</a>
            <a href="storeList.html">취소</a>
        </div>
    </div>
</div>
</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
    // 로그인이 되면
    if (localStorage.getItem('is_logined')) {
        // 로그아웃 버튼, 누구누구님만 보임
        document.getElementById("loginBtn").style.display = "none";
        document.getElementById("joinBtn").style.display = "none";

        // localStorage에서 id 값을 가져오기
        const id = localStorage.getItem("id");

        // p 요소에 nickname 값을 넣기
        const nameElement = document.getElementById("name");
        if (nameElement) {
            nameElement.textContent = id + '님' || "No nickname"; // 값이 없을 경우에 대비한 기본 값 설정
        }
    }

    else {
        // false라면
        // 로그인, 회원가입 버튼이 보임
        document.getElementById("logoutBtn").style.display = "none";
        document.getElementById("name").style.display = "none";
    }



    function my() {
        if (!localStorage.getItem('is_logined')) {
            alert('로그인 후 이용가능합니다!')
        }
        else{
            window.location.href = 'mypage.html';
        }
    }

    function mine() {
        if (!localStorage.getItem('is_logined')) {
            alert('로그인 후 이용가능합니다!')
        }
        else{
            window.location.href = 'free_boardList.html';
        }
    }

    const Editbtn = document.getElementById("editbtn");

    Editbtn.addEventListener("click", (e) => {
        e.preventDefault();

        const subject = document.querySelector('input[name="subject"]').value;
        const id = document.querySelector('input[name="id"]').value;
        const content = document.querySelector('textarea[name="content"]').value;

        // Do something with the collected data, e.g., log it
        console.log("Title:", subject);
        console.log("Author:", id);
        console.log("Content:", content);

        // Check each field individually
        if (!subject) {
            alert("수정하실 제목을 입력해주세요!");
            return;
        }

        if (!id) {
            alert("수정하실 아이디를 입력해주세요 !");
            return;
        }

        if (!content) {
            alert("수정하실 내용을 입력해주세요 !");
            return;
        }


        // Redirect to view.html after collecting data
        window.location.href = "storeList.html";
    });


</script>


