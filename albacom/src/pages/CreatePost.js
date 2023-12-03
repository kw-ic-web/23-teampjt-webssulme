// const CreatePost = () => {
//     return <div>알바 후기 작성 페이지입니다</div>;
// }

import React from "react";
import styled from "styled-components";
import { useDispatch, useSelector } from "react-redux";
import { Grid, Input} from "../elements/Index";
import { actionCreators as postActions } from "../redux/modules/post";
import { history } from "../redux/store";
import { Button, Menu, MenuItem } from "@material-ui/core";
import { titleCheck } from "../shared/check";

const CreatePost = (props) => {
  const dispatch = useDispatch();
  const [title, setTitle] = React.useState("");
  const [content, setContent] = React.useState("");
  const [category, setCategory] = React.useState("카테고리 선택");


  // 로그인한 유저정보 불러오기
  const user = useSelector((state) => state.user);
  const username = user.user.name;

  const changeTitle = (e) => {
    setTitle(e.target.value);
  };

  const changeContent = (e) => {
    setContent(e.target.value);
  };

  // Material UI -- 함수 시작지점
  const [anchorEl, setAnchorEl] = React.useState(null);
  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  // 카테고리 선택시 발생하는 이벤트 (드롭다운 close, 카테고리 값 변동)
  const handleClose = (e) => {
    setAnchorEl(null);

    // 드롭다운 활성화하고 선택안했을때 오류 방지
    if (e.target.childNodes.length === 0) {
      return;
    }
    setCategory(e.target.childNodes[0].textContent);
  };
  // Material UI --함수 끝

  const addPost = () => {
    // 아무내용 입력안하고 게시글 작성버튼 누를시
    if (!title || !content || !category ) {
      window.alert("제목, 카테고리, 내용은 필수 기입 항목입니다.");
      return;
    }

    // 제목을 너무 길게 작성할 시 정규표현식으로 거르고 알림창생성
    if (!titleCheck(title)) {
      window.alert("제목을 20자 이내로 작성해주세요.");
      return;
    }

    dispatch(
      postActions.addPostDB(title, content, category, username)
    );
    history.replace("/");
  };

  // 이건 과연 필요한 것일까...
  // 미리보기 설정(이미지 url로 변환후 화면에 표시)
  // const selectFile = (e) => {
  //   //file state에 현재 선택된 파일정보 저장
  //   setImgFile(e.target.files[0]);

  //   // FileReader 내장함수 사용
  //   const reader = new FileReader();

  //   // 만약 파일이 선택되지 않았을 경우 그냥 반환한다.(오류방지)
  //   if (!e.target.files[0]) {
  //     return;
  //   }

  //   // 현재 선택된 파일을 dataurl로 변환
  //   reader.readAsDataURL(e.target.files[0]);

  // };

  return (
    <React.Fragment>
      <Wrapper>
        <Grid>
          <Input
            _onChange={changeTitle}
            bold
            placeholder="제목을 입력하세요."
          />
        </Grid>
        <Grid padding="30px 0px 0px 0px">
          <Button
            style={{
              boxShadow: "rgb(0 0 0 / 30%) 0px 1.5px 2.5px 0px",
              border: "1px solid #dddddd",
            }}
            aria-controls="simple-menu"
            aria-haspopup="true"
            onClick={handleClick}
          >
            {category}
          </Button>
          <Menu
            id="simple-menu"
            anchorEl={anchorEl}
            keepMounted
            open={Boolean(anchorEl)}
            onClose={handleClose}
          >
            <MenuItem onClick={handleClose}>음악</MenuItem>
            <MenuItem onClick={handleClose}>여행</MenuItem>
            <MenuItem onClick={handleClose}>맛집</MenuItem>
            <MenuItem onClick={handleClose}>반려동물</MenuItem>
          </Menu>
        </Grid>

    
        <Grid>
          <Input
            value={content}
            _onChange={changeContent}
            multiline
            placeholder="내용을 입력하세요."
          />
        </Grid>
        <Grid is_flex padding="30px 0px">
          <BasicButton onClick={addPost}>완료</BasicButton>
          <BasicButton
            onClick={() => {
              history.goBack();
            }}
          >
            취소
          </BasicButton>
        </Grid>
      </Wrapper>
    </React.Fragment>
  );
};

const BasicButton = styled.button`
  width: 100px;
  height: 35px;
  margin: 0px;
  font: inherit;
  border: 0px solid;
  background-color: #ccd6f1;
  border-radius: 10px;
  box-shadow: rgb(0 0 0 / 30%) 0px 1.5px 2.5px 0px;
  :hover {
    background-color: #bccdfb;
  }
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
    width: 3rem;
    font-size: 0.6rem;
    height: 1.7rem;
    margin: 0px 1.5rem;
  }

  @media (max-width: 375px) {
    width: 3rem;
    font-size: 0.7rem;
    height: 1.7rem;
    margin: 0px 1.5rem;
  }
`;

const Wrapper = styled.div`
  font: inherit;
  width: 50rem;
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
  & > div > button {
    font: inherit;
    font-size: 1rem;
  }

  @media (max-width: 1024px) {
    width: 40rem;
    margin-top: 2rem;
    & > div > button {
      font: inherit;
      font-size: 1rem;
    }
  }
  @media (max-width: 768px) {
    width: 28rem;
    margin-top: 2rem;
    & > div > button {
      font: inherit;
      font-size: 0.8rem;
    }
  }
  @media (max-width: 540px) {
    width: 21rem;
    margin-top: 1.5rem;
    padding: 4rem;
    & > div > button {
      font: inherit;
      font-size: 0.8rem;
    }
  }
  @media (max-width: 414px) {
    width: 16.5rem;
    padding: 3rem;
    margin-top: 1.5rem;
    & > div > button {
      font: inherit;
      font-size: 0.8rem;
    }
  }
  @media (max-width: 375px) {
    width: 13rem;
    padding: 3rem;
    margin-top: 2rem;
    & > div > button {
      font: inherit;
      font-size: 0.7rem;
    }
  }
  @media (max-width: 280px) {
    width: 9.7rem;
    padding: 3rem;
    margin-top: 1rem;
  }
`;

export default CreatePost;

