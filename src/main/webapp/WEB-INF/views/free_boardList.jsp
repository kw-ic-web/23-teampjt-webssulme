<!DOCTYPE html> 
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>자유게시판 </title>
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
        <div class="board_list_wrap">
          <div class="top">
            <div class="num">번호</div>  <!-- 아마 id가 들어가면됌.-->
            <div class="title">제목</div>  <!--title-->
            <div class="writer">글쓴이</div> <!--user_nickname-->
            <div class="date">작성일</div> <!--createdAt-->
        </div>
            <div class="board_list" id ="boardList" >
                <div>
                    <div class="num"></div>
                    <div class="title"><a href="free_boardView.html"></a></div>
                    <div class="writer"></div>
                    <div class="date"></div>
                </div>
            </div>
            <div class="board_page">
                <a href="#" class="bt first"></a>
                <a href="#" class="bt prev"></a>
                <a href="#" class="num on">1</a>
                <a href="#" class="num">2</a>
                <a href="#" class="num">3</a>
                <a href="#" class="num">4</a>
                <a href="#" class="num">5</a>
                <a href="#" class="bt next">></a>
                <a href="#" class="bt last">>></a>
            </div>
            <div class="bt_wrap">
                <a href="free_boardWrite.jsp" class="on">글쓰기</a>
                <!--<a href="#">수정</a>-->
            </div>
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
   // 페이지 로드 시 실행되는 함수
  window.onload = async function () {
    // 서버로부터 자유게시판 목록을 가져오는 요청
    try {
      const response = await axios.get('http://35.212.196.164/freeboard/getfreeboardlist');

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

    // 이전에 표시된 목록 삭제 (새로고침을 했을 때 중복 방지)
    boardListContainer.innerHTML = '';


    // boardList를 최신순으로 정렬
    boardList.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));


    let i = 1;
    // 받아온 목록을 화면에 출력 id index관리/........
    for (const boardItem of boardList) {

      const date = new Date(boardItem.created_at);
      const formattedDate = `${date.getFullYear()}.${date.getMonth() + 1}.${date.getDate()}`;

      const boardItemElement = document.createElement('div');
      boardItemElement.innerHTML = `
      <div class="num">${i++}</div>
      <div class="title"><a href="free_boardView.html?idx=${boardItem.id}">${boardItem.title}</a></div>
      <div class="writer">${boardItem.user_nickname}</div>
      <div class="date">${formattedDate}</div>
      <div class="idx" style="display: none;">${boardItem.id}</div>
      `;
      boardListContainer.appendChild(boardItemElement);
    }
  }

</script>
