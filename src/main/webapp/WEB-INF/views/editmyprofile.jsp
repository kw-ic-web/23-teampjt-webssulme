<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 편집 </title>
    <link rel = 'stylesheet' href = "/css/header.css">
    <link rel = 'stylesheet' href = "/css/index.css">
    <link rel = 'stylesheet' href = "/css/join.css">

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
            <li><a href="../freeboardpage" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 자유게시판 </a></li>
            <li><a href="../mypage" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 마이페이지 </a></li>
        </ul>
    </div>
</div>


<div class = 'signup'>
    <h1 class = 'h1'>프로필 편집</h1>
    <p class = 'p'>비밀번호</p>
    <input class = in type="password"  name="pwd" oninput = "pwCheck()" placeholder="변경하실 비밀번호를 입력해주세요."></input>
    <p class = 'p'>비밀번호 확인</p>
    <input class = in type="password" name="pwd2"  oninput = "pwCheck()" placeholder="비밀번호를 한번 더 입력해주세요."></input>
    <span  type = 'hidden' id='pwConfirm'></span>
    <button class = joinbtn onclick="signup()">완료</button>
</div>




<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" >
    let id;
    // 로그인이 되면
    if (localStorage.getItem('is_logined')) {
        // 로그아웃 버튼, 누구누구님만 보임
        document.getElementById("loginBtn").style.display = "none";
        document.getElementById("joinBtn").style.display = "none";

        // localStorage에서 id 값을 가져오기
        id = localStorage.getItem("id");

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


    // 비밀번호 일치/불일치 확인 코드
    function pwCheck(){
        const pw1 = document.querySelector("input[name = 'pwd']").value.trim();
        const pw2 = document.querySelector("input[name = 'pwd2']").value.trim();
        const pwc = document.getElementById('pwConfirm');
        console.log(pw1)
        console.log(pw2)

        if (pw1 === pw2) {
            pwc.textContent = '비밀번호가 일치합니다.';
            pwc.style.color = 'green';
        } else if (pw1.length === 0 || pw2.length === 0){
            pwc.textContent = '비밀번호가 일치하지 않습니다.';
            pwc.style.color = 'red';
        }

        else{
            pwc.textContent = '비밀번호가 일치하지 않습니다.';
            pwc.style.color = 'red';
        }
    }


    function signup() {
        var pwd = document.querySelector("input[name = 'pwd']").value;

        try { axios.put(`http://35.212.196.164:8080/mypage/profile/${id}/${pwd}`,{ withCredentials: true })
            .then(res => {
                console.log(res)
                if (res.data) {
                    alert("비밀번호 변경이 완료되었습니다 !");
                    document.location.href = "/";

                }
                else {
                    alert("정확하게 다시 입력해주세요 !");
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
            window.location.href = '/';
        }catch (error) {
            console.error('오류 발생:', error);
        }
    }



</script>

</body>

</html>


<%--<head>--%>
<%--  <meta charset="UTF-8">--%>
<%--  <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--  <title>마이페이지 편집 </title>--%>
<%--    <link rel = 'stylesheet' href = "/css/header.css">--%>
<%--    <link rel = 'stylesheet' href = "/css/index.css">--%>
<%--    <link rel = 'stylesheet' href = "/css/join.css">--%>
<%-- --%>
<%--</head>--%>

<%--<body>--%>
<%--  <div id = 'head' class="header">--%>
<%--    <img src="/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="65px" onclick="location.href='main.html'">--%>
<%--    <div class="button-container" id="buttonContainer">--%>
<%--      <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>--%>
<%--      <button class="button" id="logoutBtn" style="margin: 7px;" onclick="logout()">로그아웃</button>--%>
<%--      <input class="button" type="button" id="loginBtn" value="로그인" style="margin: 7px; margin-right: 15px;" onclick="location.href='login.html'">--%>
<%--      <input class="button" type="button" id="joinBtn" value="회원가입" style="margin: 7px; margin-right: 15px;" onclick="location.href='join.html'">--%>
<%--    </div>--%>


<%--  <div class="nav__bar">--%>
<%--    <ul class="nav__menu">--%>
<%--      <li><a href="main.jsp" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 홈 </a></li>--%>
<%--      <li><a href="../postlistpage.html" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 후기 목록 </a></li>--%>
<%--      <li><a href="../freeboardpage.html" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 자유게시판 </a></li>--%>
<%--      <li><a href="../mypage.html" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 마이페이지 </a></li>--%>
<%--    </ul>--%>
<%--  </div>--%>
<%--  </div>--%>


<%--  <div class = 'signup'>--%>
<%--    <h1 class = 'h1'>프로필 편집</h1>--%>
<%--        <p class = 'p'>아이디</p>--%>
<%--        <input class = in name="id" placeholder="변경하실 아이디를 입력해주세요."/>--%>
<%--        --%>
<%--        <div class="centered-container" style="text-align: center;"> --%>
<%--          <id="decide" style='color:red;'>ID 중복 여부를 확인해주세요.</span>--%>
<%--          <input  type="button" id="check_button" value="ID 중복 검사" onclick="idCheck();"style="width: 100px;  height: 30px;"></p>--%>
<%--          <input type = 'hidden' id = 'idDuplication' value = 'idUncheck'/>--%>
<%--        </div>--%>
<%--    --%>
<%--        <p class = 'p'>비밀번호</p>--%>
<%--        <input class = in type="password"  name="pwd" oninput = "pwCheck()" placeholder="변경하실 비밀번호를 입력해주세요."></input>--%>
<%--        <p class = 'p'>비밀번호 확인</p>--%>
<%--        <input class = in type="password" name="pwd2"  oninput = "pwCheck()" placeholder="비밀번호를 한번 더 입력해주세요."></input>--%>
<%--        <span  type = 'hidden' id='pwConfirm'></span>--%>
<%--        <button class = joinbtn onclick="signup()">완료</button>--%>
<%--  </div>--%>
<%--  --%>




<%--  <script type="text/javascript" >--%>
<%--      // 로그인이 되면--%>
<%--      if (localStorage.getItem('is_logined')) {--%>
<%--        // 로그아웃 버튼, 누구누구님만 보임--%>
<%--        document.getElementById("loginBtn").style.display = "none";--%>
<%--        document.getElementById("joinBtn").style.display = "none";--%>
<%--         --%>
<%--        // localStorage에서 id 값을 가져오기--%>
<%--          const id = localStorage.getItem("id");--%>

<%--          // p 요소에 nickname 값을 넣기--%>
<%--          const nameElement = document.getElementById("name");--%>
<%--          if (nameElement) {--%>
<%--              nameElement.textContent = id + '님' || "No nickname"; // 값이 없을 경우에 대비한 기본 값 설정--%>
<%--          }--%>
<%--      } --%>
<%--      --%>
<%--      else {--%>
<%--        // false라면 --%>
<%--        // 로그인, 회원가입 버튼이 보임--%>
<%--        document.getElementById("logoutBtn").style.display = "none";--%>
<%--        document.getElementById("name").style.display = "none";--%>
<%--      }--%>


<%--      function my() {--%>
<%--        if (!localStorage.getItem('is_logined')) {--%>
<%--          alert('로그인 후 이용가능합니다!')--%>
<%--        }--%>
<%--        else{--%>
<%--          window.location.href = 'mypage.jsp';--%>
<%--        }--%>
<%--      }--%>


<%--       // 비밀번호 일치/불일치 확인 코드--%>
<%--    function pwCheck(){--%>
<%--        const pw1 = document.querySelector("input[name = 'pwd']").value.trim();--%>
<%--        const pw2 = document.querySelector("input[name = 'pwd2']").value.trim();--%>
<%--        const pwc = document.getElementById('pwConfirm');--%>
<%--        console.log(pw1)--%>
<%--        console.log(pw2)--%>

<%--        if (pw1 === pw2) {--%>
<%--            pwc.textContent = '비밀번호가 일치합니다.';--%>
<%--            pwc.style.color = 'green';--%>
<%--        } else if (pw1.length === 0 || pw2.length === 0){--%>
<%--            pwc.textContent = '비밀번호가 일치하지 않습니다.';--%>
<%--            pwc.style.color = 'red';--%>
<%--        }--%>

<%--        else{--%>
<%--            pwc.textContent = '비밀번호가 일치하지 않습니다.';--%>
<%--            pwc.style.color = 'red';--%>
<%--        }--%>
<%--    }--%>


<%--    // 아이디 중복체크--%>
<%--    function idCheck(){--%>
<%--        const id = document.querySelector("input[name = 'id']").value;--%>
<%--        const decideElement = document.getElementById('decide');--%>
<%--        const idDuplication = document.getElementById('idDuplication');--%>
<%--        const check = document.getElementById('check_button');--%>
<%--        console.log(id);--%>

<%--            // 빈값 체크--%>
<%--            if (id == ''|| id.length == 0){--%>
<%--                alert('아이디를 입력해주세요');--%>
<%--                return false;--%>
<%--            }--%>

<%--            // 아이디 중복 확인 요청 코드 => 서버--%>
<%--            axios.get(`http://35.212.196.164/join/idCheck/${id}`)--%>
<%--            .then(res => {--%>
<%--            // 중복값이 있으면 true, 없으면 false로 반환해온 값을 받아옴--%>
<%--            if (res.data) {--%>
<%--             decideElement.innerHTML = '이미 사용 중인 아이디입니다.';--%>
<%--             decideElement.style.color = 'red';--%>
<%--                  --%>
<%--                --%>
<%--           } else {--%>
<%--             decideElement.innerHTML = '사용 가능한 아이디입니다.';--%>
<%--            idDuplication.value = 'idcheck';--%>
<%--             decideElement.style.color = 'blue';--%>
<%--             }--%>
<%--                --%>
<%--             })--%>
<%--             .catch(error => {--%>
<%--               console.error('오류 발생:', error);--%>
<%--            });      --%>
<%--           --%>
<%--          }--%>
<%--    --%>
<%--    function inputIdChk() {--%>
<%--        const decideElement = document.getElementById('decide');--%>
<%--        const idDuplication = document.getElementById('idDuplication');--%>
<%--        const dbCheckId = document.getElementById('check_button');--%>

<%--        idDuplication.value = 'idUncheck';--%>
<%--        dbCheckId.disabled = false;--%>
<%--        dbCheckId.style.opacity=1;--%>
<%--        dbCheckId.style.cursor = 'pointer';--%>
<%--        decideElement.style.color = 'red';--%>
<%--        decideElement.textContent = 'ID 중복 검사를 해주세요';--%>
<%--    }--%>

<%--    function signup() {--%>
<%--      var id =document.querySelector("input[name = 'id']").value;--%>
<%--      var pwd = document.querySelector("input[name = 'pwd']").value;--%>

<%--      try { --%>
<%--        axios.post(`http://35.212.196.164/join/insert/${id}/${pwd}`,{ withCredentials: true })--%>
<%--        .then(res => {--%>
<%--            console.log(res)--%>
<%--              if (res.data) {--%>
<%--                alert("회원가입이 완료되었습니다 !");--%>
<%--                document.location.href = "login.html";--%>
<%--                 --%>
<%--              } --%>
<%--              else {--%>
<%--                alert("정확하게 다시 입력해주세요 !");--%>
<%--              }--%>
<%--          --%>
<%--        })--%>
<%--      } catch (error) {--%>
<%--          console.error('오류 발생:', error);--%>
<%--      }--%>
<%--    }--%>

<%--    function logout(){--%>
<%--                try {--%>
<%--                    localStorage.removeItem('id');--%>
<%--                    localStorage.removeItem('pwd');--%>
<%--                    localStorage.removeItem('is_logined');--%>
<%--                    alert("로그아웃 되었습니다.");--%>
<%--                    window.location.href = 'main.html';--%>
<%--                }catch (error) {--%>
<%--                    console.error('오류 발생:', error);--%>
<%--                }--%>
<%--            }--%>
<%-- --%>


<%--  </script>--%>

<%--</body>--%>

<%--</html>--%>
