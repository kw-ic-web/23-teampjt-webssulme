<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel = 'stylesheet' href = "/css/css.css">
    <link rel = 'stylesheet' href = "/css/header.css">
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
        <div class="board_write_wrap">
            <div class="board_write">
            <form id="writeFrm">                   
                <div class="title">   
                    <dl>
                      <dt>제목</dt>
                      <dd><input type="text" name = "subject" placeholder="제목 입력"></dd>
                    </dl>
                </div>
                <div class="info">
                    <dl>
                        <dt>아이디</dt>
                        <dd><input type="text" name = "id" placeholder="글쓴이 입력"></dd>
                    </dl>
                </div>
                <div class="cont">
                    <textarea name="content" placeholder="내용 입력"></textarea>
                </div>
                <div class="idx" style="display: none;">${boardItem.id}</div>
            </div>
            <div class="bt_wrap">
                <a href ="#" id="registrationBtn">등록</a>
                <!--input type="submit" value="등록">-->

                <a href="free_boardList.jsp">취소</a>
            </form>      
            </div>
        </div>
    </div>
</body>
</html>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="module"></script>
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

  const registrationBtn = document.getElementById("registrationBtn");

  registrationBtn.addEventListener("click", async (e) => {
    e.preventDefault();

  const subject = document.querySelector('input[name="subject"]').value;
  const id = document.querySelector('input[name="id"]').value;
  const content = document.querySelector('textarea[name="content"]').value;

  // 각 필드를 개별적으로 확인
  if (!subject || !id || !content) {
    alert("제목, 아이디, 내용을 모두 입력해주세요!");
    return;
  }

  try {
    const response = await axios.post(`http://35.212.196.164/freeboard/insertnewcontent/${id}/${subject}/${content}`);

    console.log(response.data);

    // 응답 데이터를 확인하여 성공 또는 실패 처리
    if (response.data === true ) {
      console.log("새글 등록 성공!");
      // 성공 시 리다이렉트하거나 기타 작업 수행 가능

      // 성공 시 리다이렉트하거나 기타 작업 수행 가능
      window.location.href = 'free_boardList.html';
        
    } else {
      console.log('새글 등록 실패!');
      // 실패 시 처리, 오류 메시지 표시 등
    }
  } catch (error) {
    console.error("POST 요청 중 오류 발생:", error);
    // 오류 처리, 오류 메시지 표시 등
  }
});


</script>