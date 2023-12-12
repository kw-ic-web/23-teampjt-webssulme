<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
    <link rel = 'stylesheet' href = "/css/header.css">
    <link rel = 'stylesheet' href = "/css/style.css">
    <link rel = 'stylesheet' href = "/css/media.css">


</head>

<body>
<div id = 'head' class="header">
    <img src="/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="100px" onclick="location.href='/'">


    <div class="button-container" id="buttonContainer">
        <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
        <button class="button" id="logoutBtn" style="margin:10px; " onclick="logout()">로그아웃</button>
        <input class="button" type="button" id="loginBtn" value="로그인" style="margin: 7px; margin-right: 15px;" onclick="location.href='login'">
        <input class="button" type="button" id="joinBtn" value="회원가입" style="margin: 7px; margin-right: 15px;" onclick="location.href='join'">
    </div>


    <div class="nav__bar">
        <ul class="nav__menu">
            <li><a href="/" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 홈 </a></li>
            <li><a href="storeList" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 후기 목록 </a></li>
            <li><a id = 'freebtn' onclick= "mine()" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 자유게시판 </a></li>
            <li><a id = 'mypagebtn' onclick= "my()" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 마이페이지 </a></li>
        </ul>
    </div>
</div>
</body>




<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
</head>

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
        <div class="title-content">
            <strong>자유게시판</strong>
            <p>알바 고민 상담을 해봐요 !</p>
        </div>

        <input class="button" visibility = "hidden;"  style= "margin-right:40px;" type="button" id="Btn" value="글쓰기" onclick="location.href='freeboardwrite'">
    </div>

    <!--    <div class="button-wrapper">-->
    <!--        <input class="button" visibility = "hidden;"  style= "margin-right:400px;" type="button" id="Btn" value="글쓰기" onclick="location.href='free_boardWrite.html'">-->
    <!--    </div>-->
    <div class="board_list_wrap">
        <div class="board_list" id ="boardList" >
            <div>
                <div class="num"></div>
                <div class="title"><a href="freeboardview"></a></div>
                <div class="writer"></div>
                <div class="date"></div>
            </div>
        </div>


        <div id = 'bt' class="bt_wrap">

            <a href="#"  class="bt prev"> 이전< </a>
            <a href="#"  class="bt next"> >다음 </a>
        </div>

        <h2  style= "text-align : center; margin-right:400px;" type = 'hidden' id='pwConfirm'></h2>
        <!--        <div class="button-wrapper">-->
        <!--            <input class="button" visibility = "hidden;"  style= "margin-right:400px;" type="button" id="Btn" value="글쓰기" onclick="location.href='free_boardWrite.html'">-->
        <!--        </div>-->


    </div>

</div>


</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
    //import axios from 'axios';
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
            window.location.href = 'mypage';
        }
    }

    function mine() {
        if (!localStorage.getItem('is_logined')) {
            alert('로그인 후 이용가능합니다!')
        }
        else{
            window.location.href = 'freeboard';
        }
    }

    // 페이지 로드 시 실행되는 함수
    window.onload = async function () {
        // 서버로부터 자유게시판 목록을 가져오는 요청
        try {
            const response = await axios.get('http://35.212.196.164:8080/freeboard/getfreeboardlist');

            // 서버로부터 받은 데이터를 변수에 저장
            const boardList = response.data;

            // 가져온 데이터를 화면에 출력하는 함수 호출
            displayBoardList(boardList);
        } catch (error) {
            console.error('서버로부터 자유게시판 목록을 가져오는 중 오류 발생:', error);
            // 오류 처리, 오류 메시지 표시 등
        }
    };

    // 서버로부터 받은 데이터를 화면에 출력하는 함수
    function displayBoardList(boardList) {
        const boardListContainer = document.getElementById('boardList');
        boardListContainer.innerHTML = '';
        // 이전에 표시된 목록 삭제 (새로고침을 했을 때 중복 방지)



        // boardList를 최신순으로 정렬
        boardList.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));


        if (boardList.length > 0) {
            const itemsPerPage = 5;
            let currentPage = 1;

            function displayItems(startIndex, endIndex) {
                // const boardListContainer = document.getElementById('boardList');
                // boardListContainer.innerHTML = '';
                boardListContainer.innerHTML = '<div class="top"><div class ="num">번호</div><div class="title">제목</div><div class = "writer">글쓴이</div><div class="date">작성일</div></div>';

                for (let i = startIndex; i < endIndex; i++) {
                    const item = boardList[i];

                    if (!item) {
                        break;
                    }

                    const itemContainer = document.createElement('div');
                    const date = new Date(item.created_at);
                    const formattedDate = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + (date.getDate());

                    itemContainer.innerHTML =
                        '<div class="num">' + (i + 1) + '</div>' +
                        '<div class="title"><a href="freeboardview?idx=' + item.id + '">' + item.title + '</a></div>' +
                        '<div class="writer">' + item.user_nickname + '</div>' +
                        '<div class="date">' + formattedDate + '</div>' +
                        '<div class="idx" style="display: none;">' + item.id + '</div>';
                    boardListContainer.appendChild(itemContainer);

                }
            }

            function updatePaginationButtons() {
                //const prevButton = document.getElementById('prev');
                // const nextButton = document.getElementById('prev');

                const prevButton = document.querySelector('.bt.prev');
                const nextButton = document.querySelector('.bt.next');

                prevButton.style.display = currentPage > 1 ? 'inline-block' : 'none';
                nextButton.style.display = currentPage < Math.ceil(boardList.length / itemsPerPage) ? 'inline-block' : 'none';
            }

            function showPage(pageNumber) {
                const startIndex = (pageNumber - 1) * itemsPerPage;
                const endIndex = startIndex + itemsPerPage;
                displayItems(startIndex, endIndex);
                updatePaginationButtons();

            }

            document.querySelector('.bt.prev').addEventListener('click', () => {
                if (currentPage > 1) {
                    currentPage--;
                    showPage(currentPage);
                }
            });

            document.querySelector('.bt.next').addEventListener('click', () => {
                const totalPages = Math.ceil(boardList.length / itemsPerPage);
                if (currentPage < totalPages) {
                    currentPage++;
                    showPage(currentPage);
                }
            });


            showPage(currentPage);
        }


        else if (boardList.length === 0) {
            // 'data' 매개변수가 없는 경우
            document.getElementById("list").style.display = "none";
            document.getElementById("bt").style.display = "none";
            const pwc = document.getElementById('pwConfirm');
            pwc.textContent = '작성된 자유게시글이 없습니다.';
            pwc.style.color = 'green';
        }

    }

    function show() {

        const titleElement = event.currentTarget;
        console.log(titleElement)
        const numElement = titleElement.parentElement.querySelector('num');

        console.log(numElement);

    }

</script>
