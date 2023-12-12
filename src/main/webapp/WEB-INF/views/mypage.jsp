<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>마이페이지 </title>
  <link rel = 'stylesheet' href = "/css/header.css">
  <link rel = 'stylesheet' href = "/css/index.css">
  <link rel = 'stylesheet' href = "/css/mypage.css">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>

<body>
<div id = 'head' class="header">
  <img src="/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="65px" onclick="location.href='/'">

  <div class="button-container" id="buttonContainer">
    <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
    <button class="button" id="logoutBtn" style="margin: 7px;" onclick="logout()">로그아웃</button>
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

  <!-- 내가 작성한 후기 글, 내가 작성한 자유게시글 목록 보이게 하고 싶음 -->
  <div class = 'mypage'>
    <h1 class = 'h1'>마이페이지</h1>

    <div class="myprofile">
      <!-- <img src="../img/person.png"  class = "im" alt="프로필" width="50px" height="30px"> -->
      <p class = 'h2' id = 'name1'></p>
      <button class='btn' onclick="location.href='mypage/profile'">프로필 편집</button>

      <h3 class = 'h2'>나의 활동</h3>
      <button class='btn' onclick="mypost();">내가 작성한 알바 후기</button>
      <!-- <button class='btn'  onclick="location.href='myfreepost.html'" style="margin-left: 270px;">내가 작성한 자유게시글</button> -->
      <button class='btn'  onclick="myfreepost();" style="margin-left: 270px;">내가 작성한 자유게시글</button>
    </div>

  </div>
  </div>

  <script type="text/javascript" >

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



    function mypost() {
      const id = localStorage.getItem("id");

      try {
        axios.get(`http://35.212.196.164:8080/mypage/commentlist/`+id)
                .then(res => {
                  const dataArray = res.data;

                  // 데이터를 URL 매개변수로 전달하여 myfreepost.html로 이동
                  const queryParams = new URLSearchParams();
                  queryParams.append('data', JSON.stringify(dataArray));

                  // URL에 쿼리 매개변수 추가하여 이동
                  window.location.href = `mypost?${queryParams.toString()}`;
                });
      } catch (error) {
        console.error('오류 발생:', error);
      }
    }


    function myfreepost() {
      const id = localStorage.getItem("id");

      try {
        axios.get(`http://35.212.196.164:8080/mypage/contentlist/`+id)
                .then(res => {

                  const dataArray = res.data;

                  // 데이터를 URL 매개변수로 전달하여 myfreepost.html로 이동
                  const queryParams = new URLSearchParams();
                  queryParams.append('data', JSON.stringify(dataArray));

                  // URL에 쿼리 매개변수 추가하여 이동
                  window.location.href = `myfreepost?${queryParams.toString()}`;
                });
      } catch (error) {
        console.error('오류 발생:', error);
      }
    }








    function logout(){
      try {
        localStorage.removeItem('id');
        localStorage.removeItem('pwd');
        localStorage.removeItem('is_logined');
        alert("로그아웃 되었습니다.");
        window.location.href = '/';
      }catch (error) {
        console.error('오류 발생:', error);
      }
    }

  </script>

</body>

</html>


