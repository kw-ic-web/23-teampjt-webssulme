// 카테고리를 눌렀을 때 보여지는 후기 나열 페이지 

import React from "react";
// import Category from "../components/Category";
import PostList from "../components/PostList";

// 사실상 main 페이지는 카테고리만 나오는 것일뿐
// storelist에서 카테고리 + 가게 후기들 리스트 렌더링
const PostListPage = () => {
  return (
    <React.Fragment>
      {/* <Category /> */}
      <PostList></PostList>
    </React.Fragment>
  );
};

export default PostListPage;