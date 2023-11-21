// const StoreList = () => {
//     return <div>가게 나열 페이지입니다</div>;
// }

// 카테고리를 눌렀을 때 보여지는 후기 나열 페이지 

import React from "react";
import styled from "styled-components";

import Category from "../components/Category";
import PostList from "../components/PostList";

// 사실상 main 페이지는 카테고리만 나오는 것일뿐
// storelist에서 카테고리 + 가게 후기들 리스트 렌더링
const StoreList = () => {
  return (
    <React.Fragment>
      <Category />
      <PostList></PostList>
    </React.Fragment>
  );
};

export default StoreList;

const Title = styled.div`
  font-family: "Lobster", cursive;
  display: flex;
  justify-content: center;
  margin: 0px auto;
  font-size: 5rem;
  margin-top: 1.5rem;
  @media (max-width: 768px) {
    font-size: 4.7rem;
  }
  @media (max-width: 414px) {
    font-size: 3.2rem;
  }
  @media (max-width: 375px) {
    font-size: 3rem;
  }
  @media (max-width: 280px) {
    font-size: 2.8rem;
  }
`;
