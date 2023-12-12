<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내가 작성한 자유게시글</title>
    <link rel = 'stylesheet' href = "/static/css/header.css">
    <link rel = 'stylesheet' href = "/static/css/index.css">
    <link rel = 'stylesheet' href = "/static/css/myfreepost.css">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>

<div id = 'head' class="header">
    <img src="/static/img/Logo.png"  style = "margin-right: 1350px;"  alt="로고" width="200px" height="65px" onclick="location.href='main.html'">

    <div class="button-container" id="buttonContainer">
        <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
        <button class="button" id="logoutBtn" style="margin: 7px; " onclick="logout()">로그아웃</button>
        <input class="button" type="button" id="loginBtn" value="로그인" style="margin: 7px; margin-right: 15px;" onclick="location.href='login.html'">
        <input class="button" type="button" id="joinBtn" value="회원가입" style="margin: 7px; margin-right: 15px;" onclick="location.href='join.html'">
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

<div class = "mypost">
    <div class="board_wrap">
        <div class="board_title">
            <strong>내가 작성한 자유게시글</strong>
        </div>

        <div class="board_list_wrap">
            <div  id = 'list' class="board_list">
                <div class="top">
                    <div class="title">제목</div>
                    <div class="date">작성일</div>
                </div>
            </div>


            <div id = 'bt' class="bt_wrap">
                <!-- 첫페이지면 해당 버튼이 안보이게도 설정해야 함 !!! -->
                <a href="#"  class="bt prev"> <이전 </a>
                <a href="#"  class="bt next"> >다음 </a>
            </div>

            <h2  style= "text-align : center; margin-right:400px;" type = 'hidden' id='pwConfirm'></h2>
            <div class="button-wrapper">
                <input class="button" visibility = "hidden;"  style= "margin-right:400px;" type="button" id="Btn" value="마이페이지로" onclick="location.href='mypage.html'">
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" >

    // 로그인이 되면
    if (localStorage.getItem('is_logined')) {
        document.getElementById("loginBtn").style.display = "none";
        document.getElementById("joinBtn").style.display = "none";

        const id = localStorage.getItem("id");

        const nameElement = document.getElementById("name");
        if (nameElement) {
            nameElement.textContent = id + '님' || "No nickname"; // 값이 없을 경우에 대비한 기본 값 설정
        }
    }

    else {
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



    // 현재 URL에서 쿼리 문자열을 가져옴
    const queryParams = new URLSearchParams(window.location.search);

    // 'data' 매개변수가 존재하는지 확인
    if (queryParams.has('data')) {
        // 'data' 매개변수의 값을 가져옴 (문자열 형태)
        const dataString = queryParams.get('data');

        // JSON 형태로 파싱하여 사용
        const dataArray = JSON.parse(dataString);
        dataArray.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));

        // 이제 dataArray를 사용하여 페이지에 필요한 작업 수행
        if (dataArray.length > 0) {
            const itemsPerPage = 5;
            let currentPage = 1;

            function displayItems(startIndex, endIndex) {
                const container = document.getElementById('list');
                container.innerHTML = '<div class="top"><div class="title">제목</div><div class="date">작성일</div></div>';

                for (let i = startIndex; i < endIndex; i++) {
                    const item = dataArray[i];

                    if (!item) {
                        break;
                    }

                    const itemContainer = document.createElement('div');
                    const date = new Date(item.created_at);
                    const formattedDate = `${date.getFullYear()}.${date.getMonth() + 1}.${date.getDate()}`;

                    itemContainer.innerHTML = `
            <div class="title"><a href="free_boardView.html?idx=${item.id}">${item.title}</a></div>
            <div class="date">${formattedDate}</div>

        `;

                    container.appendChild(itemContainer);
                }
            }

            function updatePaginationButtons() {
                //const prevButton = document.getElementById('prev');
                // const nextButton = document.getElementById('prev');
                const prevButton = document.querySelector('.bt.prev');
                const nextButton = document.querySelector('.bt.next');

                prevButton.style.display = currentPage > 1 ? 'inline-block' : 'none';
                nextButton.style.display = currentPage < Math.ceil(dataArray.length / itemsPerPage) ? 'inline-block' : 'none';
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
                const totalPages = Math.ceil(dataArray.length / itemsPerPage);
                if (currentPage < totalPages) {
                    currentPage++;
                    showPage(currentPage);
                }
            });

// Initial display of the first page
            showPage(currentPage);
        }


        else if (dataArray.length === 0) {
            // 'data' 매개변수가 없는 경우
            document.getElementById("list").style.display = "none";
            document.getElementById("bt").style.display = "none";
            const pwc = document.getElementById('pwConfirm');
            pwc.textContent = '내가 쓴 자유게시물이 없습니다.';
            pwc.style.color = 'green';
        }}


    function show() {

        const titleElement = event.currentTarget;
        console.log(titleElement)
        const numElement = titleElement.parentElement.querySelector('num');

        console.log(numElement);

    }


    function logout(){
        try {
            localStorage.removeItem('id');
            localStorage.removeItem('pwd');
            localStorage.removeItem('is_logined');
            alert("로그아웃 되었습니다.");
            window.location.href = 'main.html';
        }catch (error) {
            console.error('오류 발생:', error);
        }
    }



</script>
</body>
</html>

