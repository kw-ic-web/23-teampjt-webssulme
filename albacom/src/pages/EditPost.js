// const EditPost = () => {
//     return <div>알바 후기글 수정 페이지입니다</div>;
// }

import React from "react";
import styled from "styled-components";

import { useDispatch, useSelector } from "react-redux";
import { Grid, Input} from "../elements/Index";

import { actionCreators as postActions } from "../redux/modules/post";
import { history } from "../redux/store";

const EditPost = (props) => {
  const dispatch = useDispatch();
  const post = useSelector((state) => state.post.post);

  const post_id = props.match.params.id;

  // 수정 시 현재 게시물의 content를 수정 인풋창에 띄워주기 위해 state의 default값을 post.content로 설정
  const [contents, setContents] = React.useState(post.content);
  const [title, setTitle] = React.useState(post.title);

  const changeContents = (e) => {
    setContents(e.target.value);
  };

  const changeTitle = (e) => {
    setTitle(e.target.value);
  };

  // 수정 전 포스트 정보 가져오기
  React.useEffect(() => {
    dispatch(postActions.getOnePostDB(post_id));
  }, [dispatch, post_id]);


  
  // 수정하기
  const editPost = () => {
    dispatch(postActions.editPostDB(contents, title, post_id));
    history.push("/");
  };

  return (
    <React.Fragment>
      <Wrapper>
        <Grid>
          <h3>게시글 수정</h3>
          <TitleInput value={title} onChange={changeTitle}></TitleInput>
        </Grid>
        
        <Grid>
          <Input
            _onChange={changeContents}
            multiline
            value={contents}
            placeholder="수정할 내용을 입력하세요."
          />
        </Grid>
        <Grid is_flex padding="30px 0px">
          <Button onClick={editPost}>수정완료</Button>
          <Button
            onClick={() => {
              history.replace(`/post/${post_id}`);
            }}
          >
            취소
          </Button>
        </Grid>
      </Wrapper>
    </React.Fragment>
  );
};

EditPost.defaultProps = {
  title: "제목이에요. 진짜로",
  img: "",
  content: "내용이 들어가요.",
};

const Button = styled.button`
  width: 100px;
  height: 35px;
  margin: 0px;
  border: 0px solid;
  font: inherit;
  background-color: #ccd6f1;
  border-radius: 10px;
  box-shadow: rgb(0 0 0 / 30%) 0px 1.5px 2.5px 0px;
  @media (max-width: 1024px) {
    width: 5rem;
    font-size: 0.9rem;
    height: 2rem;
    margin: 0px 2.2rem;
  }
  @media (max-width: 768px) {
    width: 4.5rem;
    font-size: 0.8rem;
    height: 1.9rem;
    margin: 0px 2rem;
  }

  @media (max-width: 540px) {
    width: 4.5rem;
    font-size: 0.7rem;
    height: 1.7rem;
    margin: 0px 1.5rem;
  }
  @media (max-width: 414px) {
    width: 4rem;
    font-size: 0.6rem;
    height: 1.7rem;
    margin: 0px 1.5rem;
  }

  @media (max-width: 375px) {
    width: 4rem;
    font-size: 0.7rem;
    height: 1.7rem;
    margin: 0px 1.5rem;
  }
`;

const Wrapper = styled.div`
  width: 70rem;
  margin-left: auto;
  margin-right: auto;
  margin-top: 6rem;
  margin-bottom: 10rem;
  padding: 100px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  background: white;
  border-radius: 4px;
  box-shadow: rgb(0 0 0 / 30%) 0px 4px 16px 0px;
  border-radius: 10px;

  @media (max-width: 1024px) {
    width: 40rem;
    margin-top: 2rem;
  }
  @media (max-width: 768px) {
    width: 28rem;
    margin-top: 2rem;
  }
  @media (max-width: 540px) {
    width: 21rem;
    margin-top: 1.5rem;
    padding: 4rem;
  }
  @media (max-width: 414px) {
    width: 16.5rem;
    padding: 3rem;
    margin-top: 1.5rem;
  }
  @media (max-width: 375px) {
    width: 13rem;
    padding: 3rem;
    margin-top: 2rem;
    & > h1 {
      font-size: 2rem;
    }
  }
  @media (max-width: 280px) {
    width: 9.7rem;
    padding: 3rem;
    margin-top: 1rem;
  }
`;

const TitleInput = styled.input`
  width: 100%;
  height: 40px;
  font: inherit;
  font-size: 1.3rem;
  margin: 10px auto;
  border-top: none;
  border-left: none;
  border-right: none;
  border-bottom: solid 1px gray;
  @media (max-width: 768px) {
    width: 90%;
  }
  @media (max-width: 414px) {
    font-size: 1rem;
    height: 1rem;
    padding: 10px 10px;
    width: 90%;
  }

  @media (max-width: 375px) {
    font-size: 1rem;
    height: 1rem;
    padding: 10px 10px;
    width: auto;
  }
`;

export default EditPost ;