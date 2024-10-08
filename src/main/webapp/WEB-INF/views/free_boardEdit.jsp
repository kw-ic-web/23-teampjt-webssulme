<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel = 'stylesheet' href = "/css/header.css">
    <link rel = 'stylesheet' href = "/css/index.css">
    <link rel = 'stylesheet' href = "/css/media.css">
    <link rel = 'stylesheet' href = "/css/style.css">
</head>

<body>
<div id = 'head' class="header">
    <img src="/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="70px" onclick="location.href='/'">
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
        <strong>자유게시판(수정)</strong>
        <p>수정할 정보를 입력해주세요.</p>
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
                    <dt>글쓴이</dt>
                    <dd id="userNickname"></dd>
                </dl>
            </div>
            <div class="cont">
                <textarea name = "content" placeholder="내용 입력"></textarea>
            </div>
        </div>
        <div class="bt_wrap">
            <a id="editbtn" class="on">수정</a>
            <a href="/freeboard">취소</a>
        </div>
    </div>
</div>

</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="module"></script>
<script>
    let  id;
    // 로그인이 되면
    if (localStorage.getItem('is_logined')) {
        // 로그아웃 버튼, 누구누구님만 보임
        document.getElementById("loginBtn").style.display = "none";
        document.getElementById("joinBtn").style.display = "none";

        // localStorage에서 id 값을 가져오기
        id = localStorage.getItem("id");

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


    window.onload = function () {

        // Retrieve user_nickname from the URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const userNickname = urlParams.get('userNickname');

        console.log(userNickname);

        // Check if the element with id 'userNickname' exists before updating innerText
        const userNicknameElement = document.getElementById('userNickname');
        if (userNicknameElement) {
            userNicknameElement.innerText = userNickname;
        }

        const editBtn = document.getElementById("editbtn");

        editBtn.addEventListener("click", async (e) => {
            e.preventDefault();

            const updatedSubject = document.querySelector('input[name="subject"]').value;
            const updatedContent = document.querySelector('textarea[name="content"]').value;

            // Check each field individually
            if (!updatedSubject || !updatedContent) {
                alert("수정할 제목, 내용을 모두 입력해주세요!");
                return;


            }

            // URL에서 직접 idx 값을 가져오기

            const urlParams = new URLSearchParams(window.location.search);
            const idx = urlParams.get('idx');

            console.log(idx); // Now, idx should

            try {
                const response = await axios.put(`http://35.212.196.164:8080/freeboard/putcontent/` + idx + `/` + updatedSubject + `/` + updatedContent);

                console.log(response.data);

                // Check response data and process success or failure
                if (response.data === true) {
                    console.log("글 수정 성공!");
                    // Redirect or perform other actions on success
                    window.location.href = '/freeboard';
                    alert('수정이 완료되었습니다.')
                } else {
                    console.log('글 수정 실패!');
                    // Handle in case of failure, display error message, etc.
                }
            } catch (error) {
                console.error("PUT 요청 중 오류 발생:", error);
                // Error handling, displaying error messages, etc.
            }
        });
    };

</script>

