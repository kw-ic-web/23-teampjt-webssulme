const commentBtn = document.querySelector("#commentFrm");
    const commentList = document.querySelector("#comment-list");
    const commentAddList = document.querySelector("#commentAdd-list");
    const total = document.querySelector("h3 > span");

    const list = [];

    function Comment(userid, content, date) {
        this.userid = userid;
        this.content = content;
        this.date = date;
        this.replies = [];
}

    function createRow(comment) {
        const ul = document.createElement("ul");
        const li1 = document.createElement("li");
        const li2 = document.createElement("li");
        const li3 = document.createElement("li");
        const replyButton = document.createElement("button");

        ul.append(li1);
        ul.append(li2);
        ul.append(li3);
        ul.append(replyButton);

        ul.setAttribute("class", "comment-row");
        li1.setAttribute("class", "comment-id");
        li2.setAttribute("class", "comment-content");
        li3.setAttribute("class", "comment-date");
        replyButton.setAttribute("class", "reply-button");

        li1.innerHTML = comment.userid;
        li2.innerHTML = comment.content;
        li3.innerHTML = comment.date;
        replyButton.innerHTML = "답글 달기";

        replyButton.addEventListener("click", function () {
            const replyContent = prompt("답글을 입력하세요:");
            if (replyContent !== null && replyContent !== "") {
                const reply = new Comment("cloudcoke", replyContent, "2023-11-23");
                comment.replies.push(reply);
                drawing();
            }
        });

        return ul;
    }

    function drawing() {
        commentList.innerHTML = "";
        for (let i = list.length - 1; i >= 0; i--) {
            const row = createRow(list[i]);
            commentList.append(row);

            for (let j = list[i].replies.length - 1; j >= 0; j--) {
                const replyRow = createRow(list[i].replies[j]);
                replyRow.style.marginLeft = "20px";
                commentList.append(replyRow);
            }
        }
    }

    function totalRecord() {
        total.innerHTML = `(${list.length})`;
    }

    function commentBtnHandler(e) {
        e.preventDefault();

        const input = e.target.content;
        if (input.value === "") {
            alert("댓글을 입력한 후 제출해주세요.");
            return;
        }

        const commentObj = new Comment("cloudcoke", input.value, "2023-11-23");
        list.push(commentObj);
        totalRecord();

        drawing();
        e.target.reset();
    }

    commentBtn.addEventListener("submit", commentBtnHandler);