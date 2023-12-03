import React from "react";
import styled from "styled-components";

const Post = (props) => {
  return (
    <React.Fragment>
      <PostBox>
        <ImageWrap>
          <ImageMain src={props.img}></ImageMain>
        </ImageWrap>
        <InfoWrap>
          <InfoBox>
            <InfoText>{props.category}</InfoText>
            <span style={{ marginLeft: "0.25rem", marginRight: "0.25rem" }}>
              ·
            </span>
            <InfoText>좋아요 {props.recommendCnt}</InfoText>
            <span style={{ marginLeft: "0.25rem", marginRight: "0.25rem" }}>
              ·
            </span>
            <InfoText>댓글 {props.commentCnt}</InfoText>
          </InfoBox>
        </InfoWrap>
        <TitleText>{props.title}</TitleText>
        <TailInfo>
          by <b>{props.user}</b>
        </TailInfo>
      </PostBox>
    </React.Fragment>
  );
};

Post.defaultProps = {
  _id: null,
  title:
    "제목이 들어갈 자리입니다. 그래서 아무도 제목말고는 볼 수 없어요. 진짜에요.",
  user: "작성자",
  commentCnt: 0,
  recommendCnt: 0,
  img:
    "https://cdn.crowdpic.net/list-thumb/thumb_l_1ED169F054035E14E5A306D7947BC544.jpg",
  category: "카테고리",
};

const PostBox = styled.div`
  width: 18rem;
  background: white;
  border-radius: 4px;
  box-shadow: rgb(0 0 0 / 10%) 0px 4px 16px 0px;
  transition: box-shadow 0.25s ease-in 0s, transform 0.25s ease-in 0s;
  margin: 1rem;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  :hover {
    transform: translateY(-4px);
    box-shadow: rgb(0 0 0 / 15%) 0px 12px 20px 0px;
  }

  @media (max-width: 1024px) {
    width: 21rem;
  }
  @media (max-width: 768px) {
    width: 34rem;
  }

  @media (max-width: 540px) {
    width: 22rem;
  }
  @media (max-width: 414px) {
    width: 19rem;
  }
  @media (max-width: 375px) {
    width: 16.5rem;
  }
  @media (max-width: 280px) {
    width: 12rem;
  }
`;

const ImageWrap = styled.div`
  & {
    padding-top: 52.1921%;
  }
  width: 100%;
  position: relative;
`;

const ImageMain = styled.img`
  position: absolute;
  top: 0px;
  left: 0px;
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
  src: ${(props) => props.src};
`;

const InfoBox = styled.div`
  font-size: 0.75rem;
  line-height: 1.5;
  color: rgb(134, 142, 150);
`;

const InfoText = styled.span`
  font-size: 0.75rem;
  line-height: 1.5;
  color: rgb(134, 142, 150);
`;

const InfoWrap = styled.div`
  padding: 1rem;
  display: flex;
  flex: 1 1 0%;
  flex-direction: column;
`;

const TitleText = styled.h4`
  font-size: 1rem;
  max-width: 280px;
  white-space: normal;
  -webkit-line-clamp: 2;
  margin: 0px 0px 1rem 1rem;
  line-height: 1.5;
  word-break: break-word;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
  color: rgb(33, 37, 41);
`;

const TailInfo = styled.span`
  font-size: 0.75rem;
  border-top: 1px solid rgb(248, 249, 250);
  padding: 0.625rem 1rem;
  line-height: 1.5;
  color: rgb(134, 142, 150);
`;

export default Post;
