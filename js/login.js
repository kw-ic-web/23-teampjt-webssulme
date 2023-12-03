const loginForm = document.getElementById("login-form");
const loginButton = document.getElementById("login-form-submit");
const loginErrorMsg = document.getElementById("login-error-msg");

loginButton.addEventListener("click", (event) => {
    event.preventDefault();
    const username = loginForm.username.value;
    const password = loginForm.password.value;

    if (username === "user" && password === "web_dev") {
        alert("You have successfully logged in.");
        location.reload();
    } else {
        loginErrorMsg.style.opacity = 1;
    }
});

/*
const { Session } = require("session/lib/session");

console.log("js/login.js");

async function submit() {
    var userid = document.getElementById('userid').value;
    var userpwd = document.getElementById('userpwd').value;

    // 비번 encoding
    var encodedPwd = window.btoa(userpwd);
    var Msg = document.querySelector('#Msg');

    var sql = {
        params :{
        userid : userid,
        userpwd : encodedPwd,} 
    };

    try {
        const result = await axios.get('/serverclient/logincheck', sql)

        console.log(result.data);
        console.log("토큰값::", result.data.token);
        sessionStorage.setItem("jwtToken", result.data.token);
        console.log(result.data.data)

        // 로그인 그리스
        if (result.data.data === 1) {

            console.log(`userid is ${userid}`);
            location.href = `/home?${userid}`;
            
        } else {
            Msg.innerHTML = result.data;
        }
    } catch (error) {
        console.error("Login error:", error);
        Msg.innerHTML = "Login failed. Please try again.";
    }
}*/

