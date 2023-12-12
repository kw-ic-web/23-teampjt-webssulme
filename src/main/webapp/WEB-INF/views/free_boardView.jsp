<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv = "X-UA-Compatible" content="IE-edge">
    <meta name="viewport" content="width=device-width", initial-scale="1.0">
    <title>공지사항</title>
    <link rel = 'stylesheet' href = "/css/style.css">
    <link rel = 'stylesheet' href = "/css/header.css">
    <link rel = 'stylesheet' href = "/css/index.css">
    <link rel = 'stylesheet' href = "/css/comment.css">
    <link rel = 'stylesheet' href = "/css/media.css">

    <style>
        .ps_box {
            width: 100%;
            height: 51px;
            border: 1px solid #dadada;
            padding: 10px 14px;
            background: #fff;
            box-sizing: border-box;
        }

        .ps_box input {
            outline: none;
            width: 100%;
            height: 100%;
            border: none;
        }

        .bt_wra {
            margin-top: 30px;
            text-align: center;
            font-size: 0;
        }

        .bt_wra a {
            display: inline-block;
            min-width: 80px;
            margin-left: 10px;
            padding: 10px;
            border: 3px solid rgb(237, 185, 43);
            border-radius: 2px;
            font-size: 1.4rem;
        }

        .bt_wra a:first-child {
            margin-left: 0;
        }

        .bt_wra a.on {
            background: #000;
            color: #fff;
        }




    </style>
</head>

<body>
<div id = 'head' class="header">
    <img src="/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="65px" onclick="location.href='/'">
    <div class="button-container" id="buttonContainer">
        <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
        <button class="button" id="logoutBtn" style="margin: 7px;" onclick="logout()">로그아웃</button>
        <input class="button" type="button" id="loginBtn" value="로그인" style="margin: 7px; margin-right: 15px;" onclick="location.href='/login'">
        <input class="button" type="button" id="joinBtn" value="회원가입" style="margin: 7px; margin-right: 15px;" onclick="location.href='/join'">
    </div>


    <div class="nav__bar">
        <ul class="nav__menu">
            <li><a href="/" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 홈 </a></li>
            <li><a href="/storeList" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 후기 목록 </a></li>
            <li><a id = 'freebtn' onclick= "mine()" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 자유게시판 </a></li>
            <li><a id = 'mypagebtn' onclick= "my()" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 마이페이지 </a></li>
        </ul>
    </div>
</div>


<div class="board_wrap">
    <div class="board_title">
        <div class="title-content">
            <strong>자유 게시판</strong>
            <p>알바 고민 상담을 해봐요 !! </p>
        </div>

        <!--           <input class="button"  style= "margin-right:40px;" type="button" id="Btn" value="목록" onclick="location.href='free_boardList.html'">-->
    </div>

    <div class="board_view_wrap">
        <div class="board_view">
            <div class="title" id="title"></div>
            <div class="info">
                <dl style="display: none;">
                    <dt>번호</dt>
                    <dd id="PostNumber"></dd>
                </dl>
                <dl>
                    <dt>글쓴이</dt>
                    <dd id="userNickname"></dd>
                </dl>
                <dl>
                    <dt>작성일</dt>
                    <dd id="createdAt"></dd>
                </dl>
            </div>
            <div class="cont" id="content">
                글 내용이 들어갑니다<br>
            </div>
        </div>

        <!--            <div id = 'bt' class="bt_wrap">-->
        <!--                &lt;!&ndash; 첫페이지면 해당 버튼이 안보이게도 설정해야 함 !!! &ndash;&gt;-->
        <!--                <a href="#"  class="bt prev"> <이전 </a>-->
        <!--                <a href="#"  class="bt next"> >다음 </a>-->
        <!--            </div>-->


        <div class="bt_wra">
            <a href="/freeboard" class="on">목록</a>
            <a id="editLink" href="#" class="on">수정</a>
            <!--button id="btn-delete" class ="btn btn-danger">삭제</button>-->
        </div>


    </div>
</div>

<div>
    <ul class ="comment"  style="width: 70%;">
        <li class="comment-form" >
            <form id="commentFrm">
                <h3>댓글 작성<span></span></h3>
                <span class="ps_box">
                <input style = "font-size : 20px;" type="text" placeholder="댓글 내용을 입력해주세요" class="int" name="content"/>
                    </span>

                <input  type="submit" class ="btn" value="등록">
            </form>
        </li>
    </ul>
    <li id="comment-list" style ="padding-bottom: 100px;  "></li>
</div>
<!--script src="js/comment.js"></script>-->
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
        const nameElement2 = document.getElementById("name1");
        if (nameElement) {
            nameElement.textContent = id + '님' || "No nickname"; // 값이 없을 경우에 대비한 기본 값 설정
        }
        if (nameElement2) {
            nameElement2.textContent = id + '님' || "No nickname"; // 값이 없을 경우에 대비한 기본 값 설정
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
            window.location.href = '/mypage';
        }
    }

    function mine() {
        if (!localStorage.getItem('is_logined')) {
            alert('로그인 후 이용가능합니다!')
        }
        else{
            window.location.href = '/freeboard';
        }
    }
    function formatDateString(dateString) {
        const date = new Date(dateString);
        return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
    }


    window.onload = async function () {

        // URL에서 직접 idx 값을 가져오기
        const urlParams = new URLSearchParams(window.location.search);
        const idx = urlParams.get('idx');

        try {
            // Fetch the board item from the server
            const response = await axios.get(`http://35.212.196.164:8080/freeboard/complete/` + idx);

            console.log(response);
            const selectedItem = response.data;

            console.log(selectedItem);


            displaySelectedItem(selectedItem);

        } catch (error) {
            console.error('Error fetching data for the selected item:', error);
        }

        // 댓글 자동 불러오기

        async function fetchAndDisplayComments(idx) {
            try {
                const res = await axios.get(`http://35.212.196.164:8080/freeboard/getcontent/` + idx);
                const data = res.data;


                const userAndContent = data.map(comment => ({
                    user_nickname: comment.user_nickname,
                    content: comment.content,
                    created_at: comment.created_at

                }));
                console.log(userAndContent)

                commentList.innerHTML = "";

                for (let i = userAndContent.length - 1; i >= 0; i--) {
                    const date = new Date(userAndContent[i].created_at);
                    const formattedDate = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
                    const row = createRow(userAndContent[i].user_nickname, userAndContent[i].content,formattedDate);
                    commentList.appendChild(row);
                }
                totalRecord();

            } catch (error) {
                console.error('댓글을 불러오는 도중 오류 발생:', error);
            }
        }

// 함수 호출
        fetchAndDisplayComments(idx);

    };

    /*function displaySelectedItem(selectedItem) {
            // Update the content of the board_view_wrap section with the details of the selected item
            document.getElementById('.title a').innerText = selectedItem.title;
            document.getElementById('PostNumber').innerText = selectedItem.id;
            document.getElementById('content').innerText = selectedItem.content; // Use innerHTML for rendering HTML content
            document.getElementById('userNickname').innerText = selectedItem.user_nickname;
            document.getElementById('createdAt').innerText = formatDateString(selectedItem.created_at);

            // Populate other elements as needed
        }*/


    function displaySelectedItem(selectedItem) {

        const titleElement = document.getElementById('title');
        if (titleElement) {
            titleElement.innerHTML = selectedItem.title;
        }
        // Update the content of the board_view_wrap section with the details of the selected item

        // Check if the element with id 'PostNumber' exists before updating innerText
        const postNumberElement = document.getElementById('PostNumber');
        if (postNumberElement) {
            postNumberElement.innerText = selectedItem.id;
        }

        // Check if the element with id 'userNickname' exists before updating innerText
        const userNicknameElement = document.getElementById('userNickname');
        if (userNicknameElement) {
            userNicknameElement.innerText = selectedItem.user_nickname;
        }

        // Check if the element with id 'createdAt' exists before updating innerText
        const createdAtElement = document.getElementById('createdAt');
        if (createdAtElement) {
            createdAtElement.innerText = formatDateString(selectedItem.created_at);
        }

        // Check if the element with id 'content' exists before updating innerHTML
        const contentElement = document.getElementById('content');
        if (contentElement) {
            contentElement.innerHTML = selectedItem.content;
        }


        // 수정 페이지 idx,userNickname 연결
        const editLink = document.getElementById('editLink');
        editLink.href = `/freeboardedit?idx=` + selectedItem.id + `&userNickname=` + selectedItem.user_nickname;

    }

    // 댓글 부분 구현 완료.  api연결 후 넣기만 하면 됌.
    const commentBtn = document.querySelector("#commentFrm");
    const commentList = document.querySelector("#comment-list");
    const total = document.querySelector("h3 > span");

    const list =[];

    async function commentBtnHandler(e) {
        e.preventDefault();

        const input = e.target.content;
        if (input.value === "") {
            alert("댓글을 입력해주세요 !");
            return console.log(list);
        }

        const commentObj = new Comment(input.value);  // 입력값
        list.push(commentObj);
        totalRecord();

        // Replace with your actual free_board_id and user_nickname
        const urlParams = new URLSearchParams(window.location.search);
        const free_board_id = urlParams.get('idx');
        const user_nickname = localStorage.getItem("id");

        console.log(free_board_id);
        console.log(user_nickname);
        console.log(commentObj.content);
        console.log(commentObj.date);

        try {
            const response = await axios.post(`http://35.212.196.164:8080/freeboard/insertcontent/` + free_board_id + `/` + user_nickname + `/` + commentObj.content);

            console.log(response.data);

            if (response.data === true) {
                const date = new Date(commentObj.date);
                const formattedDate = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();;
                const row = createRow(commentObj.userid, commentObj.content,formattedDate);
                commentList.appendChild(row); // 기존에 commentList.innerHTML = ""; 대신에 appendChild를 사용
                commentList.insertBefore(row, commentList.firstChild);

                console.log('댓글 등록 성공');
            } else {

                console.error('댓글 등록 실패');


            }
        } catch (error) {
            console.error('Error:', error);
        }

        input.value = "";
        totalRecord(); // 등록 후 댓글 갯수 갱신

        return console.log(commentObj);
    }


    function Comment(content, userid, date) {
        this.userid = localStorage.getItem("id");
        this.content = content;
        this.date = new Date(); // Set the current date
    }



    function createRow(userid, content, date) {
        const ul = document.createElement("ul");
        const li1 = document.createElement("li");
        const li2 = document.createElement("li");
        const li3 = document.createElement("li");

        ul.append(li1);
        ul.append(li2);
        ul.append(li3);

        ul.setAttribute("class", "comment-row");
        li1.setAttribute("class", "comment-id");
        li2.setAttribute("class", "comment-content");
        li3.setAttribute("class", "comment-date");

        // CSS Reset
        ul.style.cssText = "font-size: 20px; width: 60%;";
        li1.style.cssText = "width: 10%; margin-left: 80px; white-space: nowrap;";
        li2.style.marginLeft = "40px";
        ul.style.marginLeft = "230px";
        li2.style.marginRight = "-100px";
        li1.innerHTML = userid;
        li2.innerHTML = content;
        li3.innerHTML = date;



        return ul;
    }


    function totalRecord(){
        total.innerHTML = `(` + commentList.children.length + `)`;
    }




    commentBtn.addEventListener("submit",commentBtnHandler);



</script>
