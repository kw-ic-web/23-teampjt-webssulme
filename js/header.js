document.addEventListener("DOMContentLoaded", () => {
    const header = document.getElementById("header");
    const buttonContainer = document.querySelector(".button-container");

    // Simulating data (replace this with actual data)
    const user = { name: "hello" };
    const isLogin = true;

    // Function to navigate to a specific URL
    const navigateTo = (url) => {
        window.location.href = url;
    };

    // Function to handle logout
    const logout = () => {
        alert("You have been logged out.");
        navigateTo('/');
    };

    // Dynamically add buttons based on login status
    if (isLogin && user) {
        const nicknameContainer = document.createElement("div");
        nicknameContainer.className = "nickname";
        
        const usernameContainer = document.createElement("div");
        usernameContainer.className = "username";
        usernameContainer.textContent = user.name;

        const createPostButton = createButton("새글작성", () => navigateTo('/write'));
        const logoutButton = createButton("Log out", logout);

        buttonContainer.appendChild(nicknameContainer);
        nicknameContainer.appendChild(usernameContainer);
        buttonContainer.appendChild(createPostButton);
        buttonContainer.appendChild(logoutButton);
    } else {
        const loginButton = createButton("Log in", () => navigateTo('/login'));
        const joinButton = createButton("Join the membership", () => navigateTo('/signup'));

        buttonContainer.appendChild(loginButton);
        buttonContainer.appendChild(joinButton);
    }
});

// Function to create a button with a specific text and click handler
function createButton(text, clickHandler) {
    const button = document.createElement("button");
    button.className = "button";
    button.textContent = text;
    button.addEventListener("click", clickHandler);
    return button;
}