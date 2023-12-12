<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <link rel = 'stylesheet' href = "/css/header.css">
  <link rel = 'stylesheet' href = "/css/index.css">
  <link rel = 'stylesheet' href = "/css/login.css">

</head>
<body>
<div id = 'head' class="header">
  <img src="/img/Logo.png"style = "margin-right: 1350px;"   alt="로고" width="200px" height="65px" onclick="location.href='main'">

  <div class="button-container" id="buttonContainer">
    <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
    <button class="button" id="logoutBtn" style="margin: 7px;" onclick="logout()">로그아웃</button>
    <input class="button" type="button" id="loginBtn" value="로그인" style="margin: 7px; margin-right: 15px;" onclick="location.href='login'">
    <input class="button" type="button" id="joinBtn" value="회원가입" style="margin: 7px; margin-right: 15px;" onclick="location.href='join'">
  </div>

  <div class="nav__bar">
    <ul class="nav__menu">
      <li><a href="main" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 홈 </a></li>
      <li><a href="storeList" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 후기 목록 </a></li>
      <li><a id = 'freebtn' onclick= "mine()" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 자유게시판 </a></li>
      <li><a id = 'mypagebtn' onclick= "my()" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 마이페이지 </a></li>
    </ul>
  </div>

</div>
<div class = 'login'>
  <!-- <form class = 'login' action="/login_process" method="post">  -->
  <h1 class = 'h1'>로그인</h1>
  <p class = 'p'>아이디</p>
  <input class = 'in' type="text" name="id" placeholder="아이디를 입력해주세요."/>

  <p class = 'p'>비밀번호</p>
  <input class = 'in' type="password" name="pwd" placeholder="비밀번호를 입력해주세요."></input>
  <!-- <button class='btn'>로그인</button> -->
  <input  class="btn" onclick = "login();" type="submit" id="log_btn" value="로그인">
  <!-- </form>  -->
</div>


<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

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
      window.location.href = 'free_boardList';
    }
  }


  function login() {
    var id =document.querySelector("input[name = 'id']").value;
    var pwd = document.querySelector("input[name = 'pwd']").value;
    const loginButton = document.getElementById("btn");
    //  로그인 성공시 true / 실패시 false 반환
    try {
      axios.post(`http://35.212.196.164:8080/login/check/`+id+'/'+pwd,{ withCredentials: true })
              .then(res => {
                if (res.data[0]) {
                  //  const is_logined = true;
                  // 서버로부터 받아온 값 (가정)
                  const userId  =  res.data[0].nickname;
                  const userpw = res.data[0].pw ;
                  localStorage.setItem("id", userId);
                  localStorage.setItem("pwd", userpw);
                  localStorage.setItem('is_logined', true);
                  alert(id+` 님 환영합니다 !`);
                  document.location.href = "/";
                }
                else { //반환값이 하나도 없을때
                  alert("로그인 정보가 일치하지 않습니다. 다시 입력해주세요 !");
                }
              })
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
      window.location.href = 'main';
    }catch (error) {
      console.error('오류 발생:', error);
    }
  }


</script>
</body>
</html>


