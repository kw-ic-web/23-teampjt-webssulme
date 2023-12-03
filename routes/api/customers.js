const express = require("express");
//const mysql = require("../../mysql/index.js");
const router = express.Router();

router.get("/", async (req, res) => {
  const customers = await mysql.query("customerList");
  console.log(customers);
  res.send(customers);
});


// 자유게시판 새글 작성API
router.get("/freeboard/insertnewcontent", async (req, res) => {
  try {
    const content = await mysql.query("content");

    console.log(req.query);

    // Check if 'content' is not empty and has at least two elements
    if (Array.isArray(content)) {
      const index = '1';   // 내용이 비어있지 않으면 index '1' 을 반환 -> 즉, 새글작성 성공인거임.
      return res.send(index);
    } else {
      return res.status(404).send("No content or not enough elements");
    }
  } catch (error) {
    console.error("Error fetching free board list:", error);
    return res.status(500).send("Internal Server Error");
  }
});


// 자유게시판 목록 API
router.get("/freeboard/getfreeboardlist", async (req, res) => {
  const arr=[]
  
  const id = await mysql.query("id");
  const nickname = await mysql.query("user_nickname");
  const title = await mysql.query("title");
  const content = await mysql.query("content");
  const time = await mysql.query("created_at");
  

  freeBoard.forEach((el,index)=>{
    arr.push({id: id, user_nickname : nickname, title : title, content : content, created_at : time})
  });

  res.send(arr)
});





router.post("/insert", async (req, res) => {
  const result = await mysql.query("customerInsert", req.body.param);
  res.send(result);
});

router.put("/update", async (req, res) => {
  const result = await mysql.query("customerUpdate", req.body.param);
  res.send(result);
});

router.delete("/delete/:id", async (req, res) => {
  const { id } = req.params;
  const result = await mysql.query("customerDelete", id);
  res.send(result);
});

module.exports = router;
