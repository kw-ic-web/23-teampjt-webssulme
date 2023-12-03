import React from "react";
import styled from "styled-components";
import moment from "moment";
import "moment/locale/ko";
import { actionCreators as commentActions } from "../redux/modules/comment";
import { useDispatch, useSelector } from "react-redux";

const Comment = (props) => {
  const { user, content, createdAt } = props;
  const dispatch = useDispatch();

  // 댓글 id 가져오기
  const comment_id = props._id;

  // 로그인한 유저 정보 불러오기
  const login_user = useSelector((state) => state.user);

  const deleteComment = () => {
    if (window.confirm("정말 삭제하시겠습니까?")) {
      dispatch(commentActions.deleteCommentDB(comment_id));
      window.alert("삭제되었습니다!");
      // history.go(0); // 현재 페이지 새로고침
    } else {
      return;
    }
  };
  return (
    <React.Fragment>
      <CommentPostWrap>
        <Nickname>{user}</Nickname>
        <Content>{content}</Content>
        <Time>{moment(new Date(createdAt)).fromNow()}</Time>

        {/* 로그인 유저의 이름과 작성자의 이름이 일치하면 댓글삭제버튼 보이게  */}
        {login_user.user.name === user ? (
          <div
            style={{
              display: "flex",
              width: "5rem",
              marginLeft: "15px",
              alignItems: "center",
            }}
          >
            <Button onClick={deleteComment}>삭제</Button>
          </div>
        ) : (
          <></>
        )}
      </CommentPostWrap>
    </React.Fragment>
  );
};

Comment.defaultProps = {
  user: "댓글쓴이",
  content: "댓글내용이에요!",
  createdAt: "2023-11-15",
};

const CommentPostWrap = styled.div`
  display: flex;
  justify-content: "space-between";
  margin-bottom: 1rem;
  border-bottom: 1px solid #dddddd;
  padding-bottom: 0.8rem;
  @media all and (max-width: 1024px) {
    font-size: 1rem;
  }

  @media all and (max-width: 768px) {
    font-size: 0.8rem;
  }
  @media all and (max-width: 414px) {
    font-size: 0.6rem;
  }

  @media all and (max-width: 375px) {
    font-size: 0.6rem;
  }
`;

const Button = styled.button`
  min-width: 2.6rem;
  height: 30px;
  margin: 0px auto;
  color: gray;
  border: none;
  background-color: #ccd6f1;
  border-radius: 10px;
  font-weight: 700;
  font-size: 0.9rem;
  cursor: pointer;
  :hover {
    color: red;
  }
  @media all and (max-width: 414px) {
    min-width: 1rem;
    width: 2rem;
    height: 1.8rem;
    font-size: 0.5rem;
  }
  @media all and (max-width: 375px) {
    min-width: 1rem;
    width: 2rem;
    height: 1.8rem;
    font-size: 0.5rem;
  }
`;

const Nickname = styled.div`
  min-width: 10rem;
  width: auto;
  margin-right: 1rem;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  @media all and (max-width: 1024px) {
    min-width: 3rem;
    width: auto;
  }
  @media all and (max-width: 768px) {
    min-width: 3rem;
    width: auto;
  }

  @media all and (max-width: 414px) {
    min-width: 2rem;
    width: auto;
  }
  @media all and (max-width: 375px) {
    min-width: 2rem;
    width: auto;
  }
`;

const Content = styled.div`
  display: flex;
  width: 100%;
  align-items: center;
`;

const Time = styled.div`
  width: 11rem;
  align-items: center;
  display: flex;
  justify-content: flex-end;
  color: #888686;
  @media all and (max-width: 1024px) {
    width: 9rem;
  }

  @media all and (max-width: 768px) {
    width: 7rem;
  }

  @media all and (max-width: 414px) {
    width: 6rem;
  }
  @media all and (max-width: 375px) {
    width: 6rem;
  }
`;

export default Comment;
