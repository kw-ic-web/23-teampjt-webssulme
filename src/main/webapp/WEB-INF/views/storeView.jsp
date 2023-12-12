
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv = "X-UA-Compatible" content="IE-edge">
    <meta name="viewport" content="width=device-width", initial-scale="1.0">
    <title>가게별 후기 목록</title>
    <link rel = 'stylesheet' href = "/css/style.css">
    <link rel = 'stylesheet' href = "/css/media.css">

    <link rel = 'stylesheet' href = "/css/header.css">


</head>
<style type="text/css">
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');


    * {
        margin: 0;
        font-family: "Do Hyeon";
        padding: 0;
        box-sizing: border-box;
    }
    body {
        margin-top: 250px;
    }

    ul,
    li {
        list-style: none;
    }

    .review {
        padding: 30px;
        width: 80%;
        margin: 0;
        margin-left: 50px;
    }

    .review > li {
        margin-top: 20px;
    }

    .comment-row {
        display: flex;
        justify-content: space-between;
    }

    .comment-row > li {
        flex-grow: 1;
    }

    .comment-row > li:nth-child(2) {
        flex-shrink: 0;
        padding-left: 25px;
    }

    .Review-form > form {
        display: flex;
        flex-direction: column;
    }

    .Review-form > form > h3 {
        width: 80%;
        margin: 14px 0;
    }

    .comment-content {
        cursor: pointer;
        word-break: break-all;
        padding-right: 25px;

    }

    .ps_box2 {
        display: flex;
        flex-direction: column;
        position: relative;
        width: 1000px;
        height: 200px;
        border: solid 1px #dadada;
        padding: 10px 14px;
        background: #fff;
        box-sizing: border-box;
    }

    .ps_box2 > textarea {
        outline: none;
        width: 100%;
        padding: 10px;
        text-align: left;
        border: none;
        background: #fff;
        font-size: 25px;
        box-sizing: border-box;
        word-break: break-all;

    }

    .ps_box2 > textarea, #string {
        outline: none;
        width: 100%;
        padding: 10px;
        text-align: left;
        border: none;
        background: #fff;
        font-size: 25px;
        box-sizing: border-box;
        /* Add this line */
    }

    .btn {
        width: 18%;
        padding: 18px 0 16px;
        text-align: center;
        box-sizing: border-box;
        text-decoration: none;
        border: none;
        background: #333;
        color: #fff;
        font-size: 20px;
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
    .board_view .title {
        padding: 40px 30px;
        border-bottom: 1px dashed #ddd;
        font-size: 2rem;
    }

    .board_view .cont {
        padding: 5px;

        border-bottom: 1px solid #000;
        line-height: 180%;
        font-size: 1.6rem;
    }

</style>
<body>
<div id="head" class="header">
    <img src="/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="65px" onclick="location.href='/'">


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


<div class="board_wrap">
    <div class="board_title">
        <strong>알바 후기</strong>
    </div>


    <div class="board_view_wrap">
        <div class="board_view">
            <div id = 'title' class="title">
            </div>
            <div class="cont" id="content">
                <br>
            </div>

            <div>
                <ul class ="review">
                    <li class="Review-form">
                        <form id="ReviewFrm">
                            <h3>후기 작성<span></span></h3>
                            <span class="ps_box2">
                                <br>
                                <textarea placeholder="후기 내용을 입력하세요" id="string" name="content"></textarea>
                                <br>
                            </span>
                            <input type="submit" class ="btn" value="등록">
                        </form>
                    </li>
                </ul>

                <li id="review-list" style ="padding-bottom: 100px;"></li>
            </div>



            <div class="bt_wra">
                <a href="storeList" class="on">목록</a>
                <!--                    <a href="storeEdit.html">수정</a>-->
                <!--button id="btn-delete" class ="btn btn-danger">삭제</button>-->
            </div>
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

    function formatDateString(dateString) {
        const date = new Date(dateString);
        return `${date.getFullYear()}.${date.getMonth() + 1}.${date.getDate()}`;
    }


    window.onload = async function () {
        // URL에서 직접 idx 값을 가져오기
        const urlParams = new URLSearchParams(window.location.search);
        const idx = urlParams.get('idx');

        console.log(idx)
        try {
            const response = await axios.get(`http://35.212.196.164/store/${idx}`);


            const selectedItem = response.data;

            console.log(selectedItem);

            displaySelectedItem(selectedItem);

        } catch (error) {
            console.error('Error fetching data for the selected item:', error);
            // Handle errors as needed
        }

        // 후기 api연결

        async function fetchAndDisplayComments(idx) {   // 여기에 stored_id틀 넣어주면 된다
            try {
                const res = await axios.get(`http://35.212.196.164/store/comment/${idx}`);
                const data = res.data;


                const userAndContent = data.map(comment => ({
                    user_nickname: comment.user_nickname,
                    content: comment.content,
                    created_at: comment.created_at

                }));
                console.log(userAndContent)


                for (let i = userAndContent.length - 1; i >= 0; i--) {
                    const date = new Date(userAndContent[i].created_at);
                    const formattedDate = `${date.getFullYear()}.${date.getMonth() + 1}.${date.getDate()}`;
                    const row = createRow(userAndContent[i].user_nickname, userAndContent[i].content,formattedDate);
                    ReviewList.appendChild(row);
                }
                totalRecord();

            } catch (error) {
                console.error('후기를 불러오는 도중 오류 발생:', error);
            }
        }

        // 함수 호출
        fetchAndDisplayComments(idx);  // 여기에 store_id만 넣어주면 됌.

    };



    function displaySelectedItem(selectedItem) {
        const titleElement = document.getElementById('title');
        const contentElement = document.getElementById('content');

        console.log('titleElement:', titleElement);
        console.log('contentElement:', contentElement);


        if (titleElement && contentElement) {
            contentElement.innerHTML = selectedItem.location;
            titleElement.innerHTML = selectedItem.name;
        } else {
            console.error('오류');
        }
    }



    // 후기 구현
    const ReviewBtn = document.querySelector("#ReviewFrm");
    const ReviewList = document.querySelector("#review-list");
    const total = document.querySelector("h3 > span");

    const list =[];

    async function ReviewbtnHandler(e){
        e.preventDefault();
        //list.push(e.target.content.value);
        const input = e.target.content;
        if(input.value === ""){
            alert("후기를 입력 한 후 등록 버튼을 눌러주세요.");
            return console.log(list);
        }

        const commentObj = new Review(input.value);
        list.push(commentObj);
        totalRecord();

        const urlParams = new URLSearchParams(window.location.search);
        const store_id = urlParams.get('idx');
        const user_nickname = localStorage.getItem("id");


        console.log(user_nickname);
        console.log(commentObj.content);
        console.log(commentObj.date);

        try {
            const response = await axios.post(`http://35.212.196.164/store/comment/${user_nickname}/${store_id}/${commentObj.content}`);  // 여기에 1이 아니라 store_id가 들어가면됌.

            console.log(response.data);

            if (response.data === true) {
                const date = new Date(commentObj.date);
                const formattedDate = `${date.getFullYear()}.${date.getMonth() + 1}.${date.getDate()}`;
                const row = createRow(commentObj.userid, commentObj.content,formattedDate);
                ReviewList.appendChild(row); // 기존에 commentList.innerHTML = ""; 대신에 appendChild를 사용
                ReviewList.insertBefore(row,  ReviewList.firstChild);

                console.log('후기 등록 성공');
            } else {

                console.error('후기 등록 실패');


            }
        } catch (error) {
            console.error('Error:', error);
        }

        input.value = "";
        totalRecord(); // 등록 후 댓글 갯수 갱신

        return console.log(commentObj);
    }
    function Review(content){
        this.userid= localStorage.getItem("id");
        this.content = content;
        this.date= new Date();

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

        // ul.style.cssText = "font-size: 20px; width: 80%; padding-right: 25px; line-height: 60px; box-sizing: border-box; ";
        // li1.style.cssText = "width: 80%; white-space: nowrap;";
        // li2.style.cssText = "width: 80%; font-size: 25px; white-space : normal"; // Increase the font-size here

        ul.style.cssText = "font-size: 20px; width: 80%; adding-right: 25px; line-height: 60px; box-sizing: border-box; ";
        li1.style.cssText = "width: 10%; margin-left: 80px; white-space: nowrap;";
        li2.style.cssText = "width: 80%; font-size: 25px; white-space : normal";


        li2.style.marginRight = "-130px";
        li1.innerHTML = userid;
        li2.innerHTML = content;
        li3.innerHTML = date;



        return ul;

    }

    function totalRecord(){
        total.innerHTML = `(${ReviewList.children.length})`;
    }

    ReviewBtn.addEventListener("submit",ReviewbtnHandler);



</script>