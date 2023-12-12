<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가게 목록</title>
    <link rel = 'stylesheet' href = "/css/header.css">
    <link rel = 'stylesheet' href = "/css/style.css">
    <link rel = 'stylesheet' href = "/css/media.css">

    <link rel = 'stylesheet' href = "/css/index.css">
    <style>

        .storemenu a.selected,
        .storemenu2 a.selected {
            font-size: 1.2em; /* 원하는 폰트 크기로 조절하세요 */
            font-weight: bold; /* 필요에 따라 굵게 설정하세요 */
            /* 추가적인 스타일 설정 가능 */
        }
        .category {
            background-color: transparent;
            padding-bottom: 1.0%;
            color: #fff;
            margin: 30px auto;
            width: 80%;
            border: 2px solid rgb(237, 185, 43); /* Add border style */
            border-radius: 20px; /* Adjust the value as needed for the desired roundness */
            vertical-align: middle;
        }


        .category a {
            color: black; /* Set the desired font color */
            text-decoration: none; /* Remove underline from links if needed */
        }


        .category2 {
            background-color: transparent;
            padding-bottom: 1.0%;
            color: #fff;
            margin: 5px auto;
            width: 80%;
            border: 2px solid rgb(237, 185, 43); /* Add border style */
            border-radius: 20px; /* Adjust the value as needed for the desired roundness */
            vertical-align: middle;
        }


        .storemenu {
            display: flex;
            justify-content: space-around;
            font-size: 1.7rem;
            align-items: center;
            margin: 5px auto;
            margin-top: 10px ;
            color:  black;
        }

        .storemenu2 {
            display: flex;
            justify-content: space-around;
            font-size: 1.7rem;
            align-items: center;
            margin: 5px auto;
            margin-top: 5px ;
            color:  black;
        }



        .item {
            white-space: nowrap;

        }


    </style>
</head>

<body>
<div id = 'head' class="header">
    <img src="/img/Logo.png" style = "margin-right: 1350px;" alt="로고" width="200px" height="65px" onclick="location.href='main.html'">


    <div class="button-container" id="buttonContainer">
        <p class = 'nickname' id = 'name' style = "margin-right: 40px;"></p>
        <button class="button" id="logoutBtn" style="margin:10px; " onclick="logout()">로그아웃</button>
        <input class="button" type="button" id="loginBtn" value="로그인" style="margin: 7px; margin-right: 15px;" onclick="location.href='login'">
        <input class="button" type="button" id="joinBtn" value="회원가입" style="margin: 7px; margin-right: 15px;" onclick="location.href='join.html'">
    </div>


    <div class="nav__bar">
        <ul class="nav__menu">
            <li><a href="main.html" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 홈 </a></li>
            <li><a href="storeList.html" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 후기 목록 </a></li>
            <li><a id = 'freebtn' onclick= "mine()" style="margin-top: 15px; margin-left: 10px;" class="white_font"> 자유게시판 </a></li>
            <li><a id = 'mypagebtn' onclick= "my()" style="margin-top: 10px; margin-left: 10px;" class="white_font"> 마이페이지 </a></li>
        </ul>
    </div>
</div>



<div class="category">
    <ul class="storemenu">
        <li><a onclick="loadCategory('카페', this)"> 카페 </a></li>
        <li><a onclick="loadCategory('술집', this)"> 술집 </a></li>
        <li><a onclick="loadCategory('놀이공원', this)"> 놀이공원 </a></li>
        <li><a onclick="loadCategory('피시방', this)"> 피시방 </a></li>
        <li><a onclick="loadCategory('영화관', this)"> 영화관 </a></li>
    </ul>
</div>

<div class="category2">
    <ul class="storemenu2">
        <li><a onclick="loadCategory('패스트푸드점', this)"> 패스트푸드점 </a></li>
        <li><a onclick="loadCategory('음식점', this)"> 음식점 </a></li>
        <li><a onclick="loadCategory('편의점', this)"> 편의점 </a></li>
        <li><a onclick="loadCategory('뷰티', this)"> 뷰티</a></li>
        <li><a onclick="loadCategory('일일알바', this)"> 일일알바 </a></li>
    </ul>
</div>

<div class="board_wrap">

    <div class="board_title">
        <div class="title-content">
            <strong> 가게 목록 </strong>

        </div>

    </div>
    <div class="board_list_wrap">
        <div class="board_list" id ="list" >

        </div>

        <div id = 'bt' class="bt_wrap">

            <a href="#"  class="bt prev"> <이전 </a>
            <a href="#"  class="bt next"> >다음 </a>
        </div>

        <h2  style= "text-align : center; margin-right:400px;" type = 'hidden' id='pwConfirm'></h2>
        <!--        <div class="button-wrapper">-->
        <!--            <input class="button" visibility = "hidden;"  style= "margin-right:400px;" type="button" id="Btn" value="글쓰기" onclick="location.href='free_boardWrite.html'">-->
        <!--        </div>-->


    </div>


</div>


<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>

    document.addEventListener('DOMContentLoaded', function () {
        const queryParams = new URLSearchParams(window.location.search);
        const category = queryParams.get('category');

        const titleContent = document.querySelector('.title-content strong');

        // 카테고리가 존재할 경우에만 요청을 보냄
        if (category) {
            // 서버로의 요청을 보내는 부분
            axios.get(`http://35.212.196.164/category/${category}`)
                .then(function (response) {
                    // 요청이 성공한 경우 실행되는 부분
                    const data = response.data;

                    console.log(data);
                    if (data.length > 0) {
                        const itemsPerPage = 10;
                        let currentPage = 1;
                        titleContent.textContent = `${category} 목록`;
                        // 선택된 카테고리에 대해서만 스타일을 변경
                        const menuItems = document.querySelectorAll('.storemenu a, .storemenu2 a');
                        menuItems.forEach(item => {
                            if (item.innerText === category) {
                                item.style.fontSize = '1.2em';// 원하는 크기로 조절
                                item.style.fontWeight = 'bold';
                            }
                        });
                        function displayItems(startIndex, endIndex) {

                            const container = document.getElementById('list');
                            container.innerHTML = '<div class="top"><div class="title" style="margin-left: 150px;">가게명</div><div class="location" style="margin-left: 500px; white-space: nowrap;">위치</div></div>';

                            for (let i = startIndex; i < endIndex; i++) {
                                const store = data[i];

                                if (!store) {
                                    break;
                                }

                                const itemContainer = document.createElement('div');
                                itemContainer.classList.add('item');
                                itemContainer.innerHTML = `
                                <div class="title" style="margin-left: 100px; margin-right: -100px;">
                                      <a href="storeView.html?idx=${store.id}">${store.name}</a>
                                </div>
                                <div class="location">${store.location}</div>
                            `;

                                container.appendChild(itemContainer);
                            }
                        }

                        function updatePaginationButtons() {
                            const prevButton = document.querySelector('.bt.prev');
                            const nextButton = document.querySelector('.bt.next');

                            prevButton.style.display = currentPage > 1 ? 'inline-block' : 'none';
                            nextButton.style.display = currentPage < Math.ceil(data.length / itemsPerPage) ? 'inline-block' : 'none';
                        }

                        function showPage(pageNumber) {
                            const startIndex = (pageNumber - 1) * itemsPerPage;
                            const endIndex = startIndex + itemsPerPage;

                            displayItems(startIndex, endIndex);
                            updatePaginationButtons();
                        }

                        document.querySelector('.bt.prev').addEventListener('click', () => {
                            if (currentPage > 1) {
                                currentPage--;
                                showPage(currentPage);
                            }
                        });

                        document.querySelector('.bt.next').addEventListener('click', () => {
                            const totalPages = Math.ceil(data.length / itemsPerPage);
                            if (currentPage < totalPages) {
                                currentPage++;
                                showPage(currentPage);
                            }
                        });
                        showPage(currentPage);
                    }
                })
                .catch(function (error) {
                    console.error('오류 발생:', error);
                });
        }
        else{

            axios.get(`http://35.212.196.164/category/카페`)
                .then(function (response) {
                    // 요청이 성공한 경우 실행되는 부분
                    const data = response.data;

                    console.log(data);
                    if (data.length > 0) {
                        const itemsPerPage = 10;
                        let currentPage = 1;
                        titleContent.textContent = '카페 목록';
                        // 선택된 카테고리에 대해서만 스타일을 변경
                        const menuItems = document.querySelectorAll('.storemenu a, .storemenu2 a');
                        menuItems.forEach(item => {
                            if (item.innerText === '카페') {

                                item.style.fontSize = '1.2em'; // 원하는 크기로 조절
                                item.style.fontWeight = 'bold';
                            }
                        });
                        function displayItems(startIndex, endIndex) {
                            const container = document.getElementById('list');
                            container.innerHTML = '<div class="top"><div class="title" style="margin-left: 150px;">가게명</div><div class="location" style="margin-left: 500px; white-space: nowrap;">위치</div></div>';

                            for (let i = startIndex; i < endIndex; i++) {
                                const store = data[i];

                                if (!store) {
                                    break;
                                }

                                const itemContainer = document.createElement('div');
                                itemContainer.classList.add('item');
                                itemContainer.innerHTML = `
                                <div class="title" style="margin-left: 100px; margin-right: -100px;">
                                    <a href="storeView.html?idx=${store.id}">${store.name}</a>
                                </div>
                                <div class="location">${store.location}</div>
                            `;

                                container.appendChild(itemContainer);
                            }
                        }

                        function updatePaginationButtons() {
                            const prevButton = document.querySelector('.bt.prev');
                            const nextButton = document.querySelector('.bt.next');

                            prevButton.style.display = currentPage > 1 ? 'inline-block' : 'none';
                            nextButton.style.display = currentPage < Math.ceil(data.length / itemsPerPage) ? 'inline-block' : 'none';
                        }

                        function showPage(pageNumber) {
                            const startIndex = (pageNumber - 1) * itemsPerPage;
                            const endIndex = startIndex + itemsPerPage;

                            displayItems(startIndex, endIndex);
                            updatePaginationButtons();
                        }

                        document.querySelector('.bt.prev').addEventListener('click', () => {
                            if (currentPage > 1) {
                                currentPage--;
                                showPage(currentPage);
                            }
                        });

                        document.querySelector('.bt.next').addEventListener('click', () => {
                            const totalPages = Math.ceil(data.length / itemsPerPage);
                            if (currentPage < totalPages) {
                                currentPage++;
                                showPage(currentPage);
                            }
                        });
                        showPage(currentPage);
                    }
                })
                .catch(function (error) {
                    console.error('오류 발생:', error);
                });
        }

    });



    // ------------------ 상단 버튼 각각 누를때 실행되는 코드
    function loadCategory(category,element) {
        const allCategoryElements = document.querySelectorAll('.storemenu a, .storemenu2 a');
        allCategoryElements.forEach(item => {
            item.classList.remove('selected');
            item.style.fontSize = '1.8rem'; // 다른 카테고리를 클릭할 때 폰트 크기 초기화
            item.style.fontWeight = 'normal';
        });

        element.classList.add('selected');
        element.style.fontSize = '1.2em'; // 클릭한 카테고리의 폰트 크기 키우기
        element.style.fontWeight = 'bold';
        const titleContent = document.querySelector('.title-content strong');
        const url = `http://35.212.196.164/category/${category}`;

        fetch(url)
            .then(response => response.json()) // JSON 형태로 변환
            .then(data => {
                console.log(data)
                if (data.length > 0) {
                    const itemsPerPage = 10;
                    let currentPage = 1;
                    titleContent.textContent = `${category} 목록`;
                    function displayItems(startIndex, endIndex) {
                        const container = document.getElementById('list');
                        container.innerHTML = '<div class="top"><div class="title" style = "margin-left  : 150px;">가게명</div><div class="location" style = "margin-left  : 500px; white-space: nowrap;">위치</div></div>';

                        for (let i = startIndex; i < endIndex; i++) {
                            const store = data[i];

                            if (!store) {
                                break;
                            }

                            const itemContainer = document.createElement('div');
                            itemContainer.classList.add('item');
                            itemContainer.innerHTML = `
                <div class="title" style="margin-left: 100px; margin-right: -100px;">
                    <a href="storeView.html?idx=${store.id}">${store.name}</a>
                </div>
                <div class="location"">${store.location}</div>
            `;

                            container.appendChild(itemContainer);
                        }
                    }


                    function updatePaginationButtons() {
                        //const prevButton = document.getElementById('prev');
                        // const nextButton = document.getElementById('prev');
                        const prevButton = document.querySelector('.bt.prev');
                        const nextButton = document.querySelector('.bt.next');

                        prevButton.style.display = currentPage > 1 ? 'inline-block' : 'none';
                        nextButton.style.display = currentPage < Math.ceil(data.length / itemsPerPage) ? 'inline-block' : 'none';
                    }

                    function showPage(pageNumber) {
                        const startIndex = (pageNumber - 1) * itemsPerPage;
                        const endIndex = startIndex + itemsPerPage;

                        displayItems(startIndex, endIndex);
                        updatePaginationButtons();
                    }

                    document.querySelector('.bt.prev').addEventListener('click', () => {
                        if (currentPage > 1) {
                            currentPage--;
                            showPage(currentPage);
                        }
                    });

                    document.querySelector('.bt.next').addEventListener('click', () => {
                        const totalPages = Math.ceil(data.length / itemsPerPage);
                        if (currentPage < totalPages) {
                            currentPage++;
                            showPage(currentPage);
                        }
                    });
                    showPage(currentPage);
                }


            })
            .catch(function (error) {
                // 요청이 실패한 경우 실행되는 부분
                console.error('서버 요청 중 오류 발생:', error);
            });
    }
    // -------------------------------------------------------------------

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

    function mine() {
        if (!localStorage.getItem('is_logined')) {
            alert('로그인 후 이용가능합니다!')
        }
        else{
            window.location.href = 'free_boardList.html';
        }
    }


    // 현재 URL에서 쿼리 문자열을 가져옴
    const queryParams = new URLSearchParams(window.location.search);

    // // 'data' 매개변수가 존재하는지 확인
    // if (queryParams.has('data')) {
    //     // 'data' 매개변수의 값을 가져옴 (문자열 형태)
    //     const dataString = queryParams.get('data');  // id
    //     const dataString2 = queryParams.get('data2');   // name
    //     const dataString3 = queryParams.get('data3');   // location
    //     const category = queryParams.get(' category');   // location
    //     // JSON 형태로 파싱하여 사용
    //     const dataArray = JSON.parse(dataString);
    //     const dataArray2 = JSON.parse(dataString2);
    //     const dataArray3 = JSON.parse(dataString3);
    //     const category1 = JSON.parse(category);
    //     console.log( dataArray)
    //     console.log(dataArray2)
    //     console.log(dataArray3)
    //
    //
    //         const allCategoryElements = document.querySelectorAll('.storemenu a, .storemenu2 a');
    //         allCategoryElements.forEach(item => item.classList.remove('selected')); // 모든 카테고리에서 'selected' 클래스 제거
    //
    //         const selectedCategoryElement = document.querySelector(`[onclick="loadCategory('${category1}', this)"]`);
    //         if (selectedCategoryElement) {
    //             selectedCategoryElement.classList.add('selected');
    //         }
    //
    //
    //
    //
    //     // 이제 dataArray를 사용하여 페이지에 필요한 작업 수행
    //     if (dataArray.length > 0) {
    //         const itemsPerPage = 10;
    //         let currentPage = 1;
    //
    //         function displayItems(startIndex, endIndex) {
    //             const container = document.getElementById('list');
    //             container.innerHTML = '<div class="top"><div class="title" style = "margin-left  : 150px;">가게명</div><div class="location" style = "margin-left  : 500px; white-space: nowrap;">위치</div></div>';
    //
    //             for (let i = startIndex; i < endIndex; i++) {
    //                 const id = dataArray[i];
    //                 const name = dataArray2[i];
    //                 const location = dataArray3[i];
    //
    //
    //                 if (!id) {
    //                     break;
    //                 }
    //
    //                 const itemContainer = document.createElement('div');
    //                 itemContainer.classList.add('item');
    //                 itemContainer.innerHTML = `
    //             <div class="title" style = "margin-left: 100px;  margin-right: -100px"><a href="storeDetails.html?id=${id}">${name}</a></div>
    //             <div class="location" style = "margin-right: 0px;">${location}</div>
    //         `
    //
    //
    //                 container.appendChild(itemContainer);
    //             }
    //         }
    //
    //      //<div class="num">번호</div>
    //        // <div className="num">${i + 1}</div>
    //
    //
    //         function updatePaginationButtons() {
    //             //const prevButton = document.getElementById('prev');
    //             // const nextButton = document.getElementById('prev');
    //             const prevButton = document.querySelector('.bt.prev');
    //             const nextButton = document.querySelector('.bt.next');
    //
    //             prevButton.style.display = currentPage > 1 ? 'inline-block' : 'none';
    //             nextButton.style.display = currentPage < Math.ceil(dataArray.length / itemsPerPage) ? 'inline-block' : 'none';
    //         }
    //
    //         function showPage(pageNumber) {
    //             const startIndex = (pageNumber - 1) * itemsPerPage;
    //             const endIndex = startIndex + itemsPerPage;
    //
    //             displayItems(startIndex, endIndex);
    //             updatePaginationButtons();
    //         }
    //
    //         document.querySelector('.bt.prev').addEventListener('click', () => {
    //             if (currentPage > 1) {
    //                 currentPage--;
    //                 showPage(currentPage);
    //             }
    //         });
    //
    //         document.querySelector('.bt.next').addEventListener('click', () => {
    //             const totalPages = Math.ceil(dataArray.length / itemsPerPage);
    //             if (currentPage < totalPages) {
    //                 currentPage++;
    //                 showPage(currentPage);
    //             }
    //         });
    //         showPage(currentPage);
    //     }
    //
    //     else if (dataArray.length === 0) {
    //         // 'data' 매개변수가 없는 경우
    //         document.getElementById("list").style.display = "none";
    //         document.getElementById("bt").style.display = "none";
    //         const pwc = document.getElementById('pwConfirm');
    //         pwc.textContent = '기입된 가게가 없습니다.';
    //         pwc.style.color = 'green';
    //     }
    // }


    function show() {

        const titleElement = event.currentTarget;
        console.log(titleElement)
        const numElement = titleElement.parentElement.querySelector('num');

        console.log(numElement);

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