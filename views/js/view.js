// view.js
document.addEventListener("DOMContentLoaded", () => {
    // Retrieve posts from wherever you store them (simulated here)
    const posts = [
        { subject: "Post 1", id: "User1", content: "Content of post 1" },
        { subject: "Post 2", id: "User2", content: "Content of post 2" },
        // ... Add more posts as needed ...
    ];

    const contentElement = document.getElementById("content");

    // Render posts
    posts.forEach((post) => {
        const postElement = document.createElement("div");
        postElement.innerHTML = `
            <h2>${post.subject}</h2>
            <p>${post.id} - ${post.content}</p>
        `;
        contentElement.appendChild(postElement);
    });
});
