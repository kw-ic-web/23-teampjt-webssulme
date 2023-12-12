<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv = "X-UA-Compatible" content="IE-edge">
    <meta name="viewport" content="width=device-width", initial-scale="1.0">
    <title>공지사항</title>
    <link rel = 'stylesheet' href = "/css/css.css">
    < <link rel = 'stylesheet' href = "/css/comment.css">
    <link rel = 'stylesheet' href = "/css/header.css">
    <link rel = 'stylesheet' href = "/css/index.css">
    
</head>

<body>
<div id = 'head' class="header">
    <img src="/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="65px" onclick="location.href='main.html'">
    <div class="button-container" id="buttonContainer">
        <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
        <button class="button" id="logoutBtn" style="margin: 7px;" onclick="logout()">로그아웃</button>
        <input class="button" type="button" id="loginBtn" value="로그인" style="margin: 7px; margin-right: 15px;" onclick="location.href='login.html'">
        <input class="button" type="button" id="joinBtn" value="회원가입" style="margin: 7px; margin-right: 15px;" onclick="location.href='join.html'">
    </div>


    <div class="nav__bar">
        <ul class="nav__menu">
            <li><a href="main.jsp" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 홈 </a></li>
            <li><a href="postlistpage.html" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 후기 목록 </a></li>
            <li><a href="freeboardpage.html" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 자유게시판 </a></li>
            <li><a id = 'mypagebtn' onclick= "my()" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 마이페이지 </a></li>
        </ul>
    </div>
</div>


    <div class="board_wrap">
        <div class="board_title">
            <strong>자유게시판</strong>
            <p>여러 정보들을 공유해주세요.</p>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title" id="title"></div><!-- 루프 내에서 사용 중이라고 가정합니다 -->
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
            <div class="bt_wrap">
                <a href="free_boardList.jsp" class="on">목록</a>
                <a id="editLink" href="#" class="on">수정</a>
                <!--button id="btn-delete" class ="btn btn-danger">삭제</button>-->
            </div>
        </div>
    </div>

    <div>
        <li class="comment-form">
            <form id="commentFrm">
                <h3>댓글 작성<span></span></h3>
                <span class="ps_box">
                    <input type="text" placeholder="댓글 내용을 입력해주세요" class="int" name="content"/>
                </span>
                <input type="submit" class ="btn" value="등록">
            </form> 
        </li>
        <li id="comment-list"></li>
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
            window.location.href = 'mypage.jsp';
        }
    }
    function formatDateString(dateString) {
        const date = new Date(dateString);
        return `${date.getFullYear()}.${date.getMonth() + 1}.${date.getDate()}`;
    }


    window.onload = async function () {

        // URL에서 직접 idx 값을 가져오기
        const urlParams = new URLSearchParams(window.location.search);
        const idx = urlParams.get('idx');

        try {
            // Fetch the board item from the server
            const response = await axios.get(`http://35.212.196.164/freeboard/complete/${idx}`);

            console.log(response);
            const selectedItem = response.data;

            console.log(selectedItem);

            // Call the function with the received data
            displaySelectedItem(selectedItem);

        } catch (error) {
            console.error('Error fetching data for the selected item:', error);
                // Handle errors as needed
        }
        
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
    editLink.href = `free_boardEdit.html?idx=${selectedItem.id}&userNickname=${selectedItem.user_nickname}`;
  
}
    





    const commentBtn = document.querySelector("#commentFrm");
    const commentList = document.querySelector("#comment-list");
    const total = document.querySelector("h3 > span");

    const list =[];

    function Comment(content){
    this.userid="cloudcoke";   // user_nickname으로 바꾸고
    this.content = content;
    this.date="2023-11-23";  // createdat으로 하면됌.

    }

    function createRow(userid, content, date){
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

    li1.innerHTML=userid;
    li2.innerHTML=content;
    li3.innerHTML = date;


    return ul;
    
    }

    function drawing(){
        commentList.innerHTML="";
        for(let i = list.length - 1; i>=0; i--){
            const row = createRow(list[i].userid, list[i].content, list[i].date);
            commentList.append(row);
        }
    }

    function totalRecord(){
        total.innerHTML=`(${list.length})`;
    }



    function commentBtnHandler(e){
        e.preventDefault();
        //list.push(e.target.content.value);
        const input = e.target.content;
        if(input.value === ""){
        alert("댓글을 입력 한 후 등록 버튼을 눌러주세요.");
        return console.log(list);
        }
        
        const commentObj = new Comment(input.value);
        list.push(commentObj);
        totalRecord();


        drawing();
        e.target.reset();


        return console.log(commentObj);
    }   

    commentBtn.addEventListener("submit",commentBtnHandler);

 
</script>