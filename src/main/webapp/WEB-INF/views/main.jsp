<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>메인 페이지 </title>

  <link rel = 'stylesheet' href = "/css/header.css">
  <link rel = 'stylesheet' href = "/css/index.css">
  <link rel = 'stylesheet' href = "/css/main.css">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

  <script async src="https://www.googletagmanager.com/gtag/js?id=G-6C07CT9X6D"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-6C07CT9X6D');
  </script>

</head>


<body>
<div id = 'head' class="header">
  <img src="/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="70px" onclick="location.href='/'">


  <div class="button-container" id="buttonContainer">
    <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
    <button class="button" id="logoutBtn" style="margin:10px; " onclick="logout()">로그아웃</button>
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


<div class="category" >
  <div class = "divv" style="margin-bottom: 2.5rem;">
    <div class="box">
      <div class="icon-with-text">
        <img src="/img/convenience.png" alt="편의점" class = "icon" width="200px" height="65px" onclick="CategoryClick('편의점')">
        <div class="text">편의점</div>
      </div>
    </div>

    <div class="box">
      <div class="icon-with-text">
        <img src="/img/cinema.png" alt="영화관" class = "icon" width="200px" height="65px" onclick="CategoryClick('영화관')">
        <div class="text">영화관</div>
      </div>
    </div>

    <div class="box">
      <div class="icon-with-text">
        <img src="/img/beer.png" alt="술집" class = "icon" width="200px" height="65px" onclick="CategoryClick('술집')">
        <div class="text">술집</div>
      </div>
    </div>

    <div class="box">
      <div class="icon-with-text">
        <img src="/img/park.png" alt="놀이공원" class = "icon" width="200px" height="65px" onclick="CategoryClick('놀이공원')">
        <div class="text">놀이공원</div>
      </div>
    </div>

    <div class="box">
      <div class="icon-with-text">
        <img src="/img/game.png" alt="피시방" class = "icon" width="200px" height="65px" onclick="CategoryClick('피시방')">
        <div class="text">피시방</div>
      </div>
    </div>
  </div>
</div>


<div class="category">
  <div class = "divv" style="margin-bottom: 2.5rem;">
    <div class="box">
      <div class="icon-with-text">
        <img src="/img/cafe.png" alt="카페" class = "icon" width="200px" height="65px" onclick="CategoryClick('카페')">
        <div class="text">카페</div>
      </div>
    </div>

    <div class="box">
      <div class="icon-with-text">
        <img src="/img/food.png" alt="음식점" class = "icon" width="200px" height="65px" onclick="CategoryClick('음식점')">
        <div class="text">음식점</div>
      </div>
    </div>

    <div class="box">
      <div class="icon-with-text">
        <img src="/img/beauty.png" alt="뷰티" class = "icon" width="200px" height="65px" onclick="CategoryClick('뷰티')">
        <div class="text">뷰티</div>
      </div>
    </div>

    <div class="box">
      <div class="icon-with-text">
        <img src="/img/fastfood.png" alt="패스트푸드점" class = "icon" width="200px" height="65px" onclick="CategoryClick('패스트푸드점')">
        <div class="text">패스트푸드점</div>
      </div>
    </div>

    <div class="box">
      <div class="icon-with-text">
        <img src="/img/oneday.png" alt="일일알바" class = "icon" width="200px" height="65px" onclick="CategoryClick('일일알바')">
        <div class="text">일일알바</div>
      </div>
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

  // function CategoryClick(category) {
  //   console.log('Selected category:', category);
  //   try {
  //     axios.get(`http://35.212.196.164/category/${category}`)
  //             .then(res => {
  //               const dataArray = res.data;
  //               console.log(res.data)
  //
  //               // const queryParams = new URLSearchParams();
  //               // queryParams.append('data', JSON.stringify(dataArray));
  //
  //               // 배열 내의 객체에서 'name' 속성만 추출하여 새로운 배열 생성
  //               const storeNamesArray = dataArray.map(store => store.name);
  //               const storelocationArray = dataArray.map(store => store.location);
  //               const storeidArray = dataArray.map(store => store.id);
  //               // 추출된 배열을 JSON 문자열로 변환
  //               const jsonString2 = JSON.stringify(storeNamesArray);
  //               const jsonString3 = JSON.stringify(storelocationArray);
  //               const jsonString = JSON.stringify(storeidArray);
  //               // 데이터를 URL 매개변수로 전달하여 store.html로 이동
  //               const queryParams = new URLSearchParams();
  //               queryParams.append('data', jsonString);
  //               queryParams.append('data2', jsonString2);
  //               queryParams.append('data3', jsonString3);
  //               queryParams.append('category', category);
  //               // URL에 쿼리 매개변수 추가하여 이동
  //               window.location.href = `store_List.html?${queryParams.toString()}`;
  //             });
  //   } catch (error) {
  //     console.error('오류 발생:', error);
  //   }
  //   // axios.post('your-api-endpoint', { category: category })
  //   //   .then(response => {
  //   //     // 성공적으로 처리된 경우의 동작
  //   //   })
  //   //   .catch(error => {
  //   //     // 오류가 발생한 경우의 동작
  //   //   });
  // }

  function CategoryClick(category) {
    console.log('Selected category:', category);
    const queryParams = new URLSearchParams();
    queryParams.append('category', category);
    window.location.href = "/storeList?" + queryParams.toString();
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