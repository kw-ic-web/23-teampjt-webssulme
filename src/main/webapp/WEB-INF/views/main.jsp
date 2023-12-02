<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>메인 페이지 </title>

  <link rel = 'stylesheet' href = "../../../../../../../23-teampjt-webssulme/views/css/header.css">
  <link rel = 'stylesheet' href = "../../../../../../../23-teampjt-webssulme/views/css/index.css">
  <link rel = 'stylesheet' href = "../../../../../../../23-teampjt-webssulme/views/css/main.css">
</head>


<body>
  <div id = 'head' class="header">
    <img src="../../../../../../../23-teampjt-webssulme/views/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="65px" onclick="location.href='main.html'">
      

    <div class="button-container" id="buttonContainer">
      <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
      <button class="button" id="logoutBtn" style="margin:10px; " onclick="logout()">로그아웃</button>
      <input class="button" type="button" id="loginBtn" value="로그인" style="margin: 7px; margin-right: 15px;" onclick="location.href='login.html'">
      <input class="button" type="button" id="joinBtn" value="회원가입" style="margin: 7px; margin-right: 15px;" onclick="location.href='join.html'">
    </div>
    

  <div class="nav__bar">
    <ul class="nav__menu">
      <li><a href="main.html" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 홈 </a></li>
      <li><a href="../../../../../../../23-teampjt-webssulme/views/html/postlistpage.html" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 후기 목록 </a></li>
      <li><a href="../../../../../../../23-teampjt-webssulme/views/html/freeboardpage.html" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 자유게시판 </a></li>
      <li><a id = 'mypagebtn' onclick= "my()" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 마이페이지 </a></li>
    </ul>
  </div>
  </div>


  <div class="category" >
    <div class = "divv" style="margin-bottom: 2.5rem;">
      <div class="box" onclick="setText('편의점')">
        <div class="icon-with-text">
          <img src="../../../../../../../23-teampjt-webssulme/views/img/convenience.png" alt="편의점" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
          <div class="text">편의점</div>
        </div>
      </div>
    
      <div class="box" onclick="setText('영화관')">
        <div class="icon-with-text">
          <img src="../../../../../../../23-teampjt-webssulme/views/img/cinema.png" alt="영화관" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
          <div class="text">영화관</div>
        </div>
      </div>
    
      <div class="box" onclick="setText('술집')">
        <div class="icon-with-text">
          <img src="../../../../../../../23-teampjt-webssulme/views/img/beer.png" alt="술집" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
          <div class="text">술집</div>
        </div>
      </div>
    
      <div class="box" onclick="setText('놀이공원')">
        <div class="icon-with-text">
          <img src="../../../../../../../23-teampjt-webssulme/views/img/park.png" alt="놀이공원" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
          <div class="text">놀이공원</div>
        </div>
      </div>
    
      <div class="box" onclick="setText('피시방')">
        <div class="icon-with-text">
          <img src="../../../../../../../23-teampjt-webssulme/views/img/game.png" alt="피시방" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
          <div class="text">피시방</div>
        </div>
      </div>
</div>
</div>
  

  <div class="category">
    <div class = "divv" style="margin-bottom: 2.5rem;">
    <div class="box" onclick="setText('카페')">
      <div class="icon-with-text">
        <img src="../../../../../../../23-teampjt-webssulme/views/img/cafe.png" alt="카페" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
        <div class="text">카페</div>
      </div>
    </div>
  
    <div class="box" onclick="setText('음식점')">
      <div class="icon-with-text">
        <img src="../../../../../../../23-teampjt-webssulme/views/img/food.png" alt="음식점" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
        <div class="text">음식점</div>
      </div>
    </div>
  
    <div class="box" onclick="setText('뷰티')">
      <div class="icon-with-text">
        <img src="../../../../../../../23-teampjt-webssulme/views/img/beauty.png" alt="뷰티" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
        <div class="text">뷰티</div>
      </div>
    </div>
  
    <div class="box" onclick="setText('패스트푸드점')">
      <div class="icon-with-text">
        <img src="../../../../../../../23-teampjt-webssulme/views/img/fastfood.png" alt="패스트푸드점" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
        <div class="text">패스트푸드점</div>
      </div>
    </div>
  
    <div class="box" onclick="setText('일일알바')">
      <div class="icon-with-text">
        <img src="../../../../../../../23-teampjt-webssulme/views/img/oneday.png" alt="일일알바" class = "icon" width="200px" height="65px" onclick="location.href='main.html'">
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
          window.location.href = 'mypage.html';
        }
      }


    function logout(){
                try {
                    localStorage.removeItem('id');
                    localStorage.removeItem('pwd');
                    localStorage.removeItem('is_logined');
                    alert("로그아웃 되었습니다.");
                    window.location.href = 'main.html';
                }catch (error) {
                    console.error('오류 발생:', error);
                }
            }
 
 
 
 </script>  
</body>
</html>
