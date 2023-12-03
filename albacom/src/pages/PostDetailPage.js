// const StoreDetail = () => {
//     return <div>가게 후기 상세 페이지입니다</div>;
// }

import React from "react";
import { useDispatch, useSelector } from "react-redux";

import styled from "styled-components";
import { Grid, Input, Text } from "../elements/Index";
import moment from "moment";

import Comment from "../components/Comment";

import { actionCreators as commentActions } from "../redux/modules/comment";
import { actionCreators as postActions } from "../redux/modules/post";

import { history } from "../redux/store";

const StoreDetail = (props) => {
  const dispatch = useDispatch();

  const [comment, setComment] = React.useState("");

  //포스트 id 추출
  const post_id = props.match.params.id;

  // 유저정보 불러오기
  const user = useSelector((state) => state.user.user);

  // 유저정보가 변할때(로그인유저바뀔때) 내가쓴게시글인지 내가쓴 댓글인지 확인 후 렌더링(수정,삭제 버튼 표시유무/ 좋아요 눌렀는지 표시)
  React.useEffect(() => {
    dispatch(postActions.getOnePostDB(post_id));
    dispatch(commentActions.getCommentDB(post_id));
  }, [dispatch, user, post_id]);

  
  // 게시글 정보 불러오기
  const post = useSelector((state) => state.post.post);

  // 댓글 불러오기
  const comment_list = useSelector((state) => state.comment.list);

  // 댓글없으면 그냥 없는대로 렌더링(오류방지)
  if (!comment_list) {
    return null;
  }

  //게시글 삭제함수
  const deletePost = () => {
    if (window.confirm("정말 삭제하시겠습니까?")) {
      dispatch(postActions.deletePostDB(post_id));
      window.alert("삭제되었습니다!");
      history.replace("/");
    } else {
      return;
    }
  };


  // 댓글작성 실행함수
  const addComment = () => {
    // 로그인 없이 댓글 작성시 알림창 생성
    if (!user) {
      window.alert("로그인이 필요합니다.");
      return;
    }

    // 댓글 입력내용없이 작성버튼누를시 내용입력하라는 알림창 생성
    if (!comment) {
      window.alert("댓글 내용을 입력해주세요.");
      return;
    }
    dispatch(commentActions.addCommentDB(user.name, comment, post_id));
    window.alert("댓글을 게시하였습니다.");
  };

  return (
    <React.Fragment>
      <Wrapper>
        {/* 유저 이름과 작성자 이름이 동일하면 수정/삭제 버튼 생성, 아니면 빈값 */}
        {user.name === post.user ? (
          <Topbutton>
            <div style={{ marginRight: "0.5rem" }}>
              <Button
                onClick={() => {
                  history.push(`/post/${post_id}/edit`);
                }}
              >
                수정
              </Button>
            </div>
            <div>
              <Button onClick={deletePost}>삭제</Button>
            </div>
          </Topbutton>
        ) : (
          <></> // 빈 값 <React.Fragment>랑 같은 것
        )}

        <Grid padding="0px">
          <Text bold size="30px">
            {post.title}
          </Text>
          <InfoWrap>
            <InfoBox>
              <InfoText>{moment(post.createdAt).format("YYYY-MM-DD")}</InfoText>
              <span style={{ marginLeft: "0.4rem", marginRight: "0.4rem" }}>
                ·
              </span>
              <InfoText>{post.user}</InfoText>
              <span style={{ marginLeft: "0.4rem", marginRight: "0.4rem" }}>
                ·
              </span>
              <InfoText>{post.category}</InfoText>
            </InfoBox>
            
          </InfoWrap>
        </Grid>
       
        <Grid>
          <ContentBox>{post.content}</ContentBox>
        </Grid>
        <Grid margin="1rem 0px 0px 0px">
          <CommentBox>
            <div style={{ display: "flex", alignItems: "center" }}>
              <Input
                _onChange={(e) => {
                  setComment(e.target.value);
                }}
                placeholder="댓글 내용을 입력하세요."
              />
              <CommentAddBtn onClick={addComment}>게시</CommentAddBtn>
            </div>
            <CommentListBox>
              {/* 댓글이 있는 게시글이면 댓글 표시, 없으면 빈값 */}
              {comment_list ? (
                comment_list.map((p, idx) => {
                  return <Comment key={p._id} {...p} />;
                })
              ) : (
                <></>
              )}
            </CommentListBox>
          </CommentBox>
        </Grid>
      </Wrapper>
    </React.Fragment>
  );
};

StoreDetail.defaultProps = {
  title:
    "제목이 들어갈 자리입니다. 그래서 아무도 제목말고는 볼 수 없어요. 진짜에요.",
  user: "작성자",
  createdAt: "2000-00-00",
  category: "카테고리",
  commentCnt: 0,
  recommendCnt: 0,
  img:
    "https://cdn.crowdpic.net/list-thumb/thumb_l_1ED169F054035E14E5A306D7947BC544.jpg",
  content: "내용이 들어가는 자리입니다.",
  comment_user: "박민경",
  comment_content: "이게 대체 뭔소리에요??",
  comment_createdAt: "2021-04-13",
  is_like: false,
};

const CommentListBox = styled.div`
  margin-top: 1.5rem;
`;

const Button = styled.button`
  width: auto;
  height: 35px;
  margin: 0px;
  border: 0px solid;
  background-color: #ccd6f1;
  border-radius: 10px;
  font-weight: 700;
  font-size: 1rem;
  box-shadow: rgb(0 0 0 / 30%) 0px 1.5px 2.5px 0px;
`;

const CommentAddBtn = styled.button`
  width: 4.5rem;
  margin-left: 0.5rem;
  padding: 0.75rem 4px;
  align-items: center;
  border: 0px solid;
  background-color: #ccd6f1;
  border-radius: 10px;
  font-weight: 700;
  font-size: 1rem;
  box-shadow: rgb(0 0 0 / 30%) 0px 1.5px 2.5px 0px;
  @media all and (max-width: 414px) {
    height: 2.4rem;
    font-size: 0.8rem;
    width: 3rem;
  }
  @media all and (max-width: 375px) {
    height: 2.4rem;
    font-size: 0.8rem;
    width: 3rem;
  }
`;

const Wrapper = styled.div`
  width: 50rem;
  height: 100%;
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
  @media all and (min-width: 1024px) {
    width: 50%;
  }
  @media all and (max-width: 768px) {
    width: 60%;
  }
  @media all and (max-width: 414px) {
    margin-top: 1rem;
    width: 80%;
    padding: 1rem;
  }
  @media all and (max-width: 375px) {
    width: 80%;
    padding: 1rem;
    margin-top: 1rem;
  }
`;

const ContentBox = styled.div`
  overflow: scroll;
  box-sizing: border-box;
  border: 1px solid #dddddd;
  width: 100%;
  font-size: 1.3rem;
  padding: 12px 4px;
  height: 25rem;
  padding: 2rem;
  margin-top: 1rem;
  @media all and (max-width: 1024px) {
    height: 10rem;
  }
  @media all and (max-width: 414px) {
    font-size: 0.7rem;
  }
  @media all and (max-width: 375px) {
    font-size: 0.7rem;
  }
`;

const CommentBox = styled.div`
  box-sizing: border-box;
  border: 1px solid #dddddd;
  width: 100%;
  font-size: 1.3rem;
  padding: 12px 4px;
  height: 100%;
  background-color: #f5f8ff;
  padding: 2rem;
  @media all and (max-width: 414px) {
    font-size: 0.8rem;
    padding: 0.7rem;
  }
  @media all and (max-width: 375px) {
    font-size: 0.8rem;
    padding: 0.7rem;
  }
`;

const InfoBox = styled.div`
  font-size: 0.75rem;
  line-height: 1.5;
  color: rgb(134, 142, 150);
`;

const InfoText = styled.span`
  font-size: 1rem;
  line-height: 1.5;
  color: rgb(134, 142, 150);
  @media all and (max-width: 414px) {
    font-size: 0.7rem;
  }
  @media all and (max-width: 375px) {
    font-size: 0.7rem;
  }
`;

const InfoWrap = styled.div`
  margin: 0.7rem 0px;
  display: flex;
  box-sizing: border-box;
  justify-content: space-between;
`;

const Topbutton = styled.div`
  display: flex;
  justify-content: flex-end;
  margin: 0px 0px 0px 0px;

  @media all and (max-width: 414px) {
    & > div > button {
      font-size: 0.5rem;
      height: 2rem;
    }
  }

  @media all and (max-width: 375px) {
    & > div > button {
      font-size: 0.5rem;
      height: 2rem;
    }
  }
`;

export default StoreDetail;