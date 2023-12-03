import React, { useState } from "react";
import Post from "./Post";

import styled from "styled-components";
import { useDispatch, useSelector } from "react-redux";
import { history } from "../redux/configureStore";

import { actionCreators as postActions } from "../redux/modules/post";

import LArrow from "../shared/LArrow.png";
import RArrow from "../shared/RArrow.png";

const PostList = () => {
  const dispatch = useDispatch();

  // 카테고리 값 불러오기
  const text = useSelector((state) => state.post.text);

  // 페이지네이션 초기값 1페이지로 설정
  const [page, setPage] = useState(1);

  // 다음 페이지로 이동
  const pageUp = () => {
    setPage(page + 1);
  };

  // 이전 페이지로 이동
  const pageDown = () => {
    if (page === 1) {
      // 첫 페이지일 때 클릭하면 현재가 첫페이지라는 알림울리고 끝내기
      window.alert("첫 페이지입니다.");
      return;
    }
    setPage(page - 1);
  };

  // 페이지 변경 시마다 그 페이지에 상속된 게시글 정보 불러옴
  React.useEffect(() => {
    dispatch(postActions.setPostDB(text, page)); // 현재 카테고리(text)와 페이지 번호(page)에 해당되는 포스트값들 불러오는 함수 실행
  }, [page]); // page 숫자 변할때마다 가져와야하는 포스트들이 달라지기때문에 두번째항에 page 입력

  const post_list = useSelector((state) => state.post.list); // post는 모듈js를 뜻함 post.js 모듈에서 initialState에 list 값을 가져옴

  // 처음 실행 시 모든 게시글의 정보 불러오기(카테고리구분x)
  React.useEffect(() => {
    dispatch(postActions.setPostDB());
  }, []);

  return (
    <React.Fragment>
      <Wrap>
        <LeftArrow onClick={pageDown}></LeftArrow>
        <PostWrap>
          {post_list.map((p, idx) => {
            let id = p._id;
            return (
              <div
                key={id}
                onClick={() => {
                  history.push(`post/${id}`);
                }}
              >
                <Post {...p} />
              </div>
            );
          })}
        </PostWrap>
        <RightArrow onClick={pageUp}></RightArrow>
      </Wrap>
    </React.Fragment>
  );
};

export default PostList;




const Wrap = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-around;
  width: 100%;
  @media (max-width: 1024px) {
    & > button {
      background-size: 4rem 4rem;
      width: 4rem;
      height: 4rem;
    }
    & > div {
      width: 75%;
    }
  }
  @media (max-width: 768px) {
    & > button {
      background-size: 3rem 3rem;
      width: 3rem;
      height: 3rem;
    }
    & > div {
      width: 70%;
    }
  }
  @media (max-width: 414px) {
    & > button {
      background-size: 2.2rem 2.2rem;
      width: 2.2rem;
      height: 2.2rem;
      margin: 0px 10px;
    }
    & > div {
      width: 70%;
    }
  }
  @media (max-width: 375px) {
    & > button {
      background-size: 2rem 2rem;
      width: 2rem;
      height: 2rem;
      margin: 0px 10px;
    }
  }
  @media (max-width: 280px) {
    & > button {
      background-size: 1.5rem 1.5rem;
      width: 1.5rem;
      height: 1.5rem;
      margin: 0px 5px;
    }
  }
`;

const PostWrap = styled.div`
  flex-wrap: wrap;
  display: flex;
  width: 62.5rem;
  margin: 0px auto;
  justify-content: space-around;
`;

const LeftArrow = styled.button`
  background-image: url(${LArrow});
  background-size: 4.5rem 4.5rem;
  background-color: #ffffff;
  width: 4.5rem;
  height: 4.5rem;
  margin-left: 1.5rem;
  border: none;
`;

const RightArrow = styled.button`
  background-image: url(${RArrow});
  background-size: 4.5rem 4.5rem;
  background-color: #ffffff;
  width: 4.5rem;
  height: 4.5rem;
  margin-right: 1.5rem;
  border: none;
`;
