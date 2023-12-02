import React, { useState } from "react";
import { useDispatch } from "react-redux";
import styled from "styled-components";
import {cate1,cate2,cate3,cate6,cate7,cate8,cate9,cate10,cate11,cate12} from "../util";
import { actionCreators as postActions } from "../redux/modules/post";



const Category = () => {
  const dispatch = useDispatch();
  const [text, setText] = useState("");

  // 버튼 클릭 시 카테고리 값을 text로 보내서 해당된 게시글 목록만 불러오기.
  React.useEffect(() => {
    dispatch(postActions.setPostDB(text));
  }, [dispatch, text]);

  
  return (
    <React.Fragment>
      <Wrap>
        <Div>
        <div style={{ marginBottom: "2.5rem" }}></div>
          <ButtonBox
            onClick={() => {
              setText("편의점");
            }}
          >

          <IconWithText>
            <Icon />
            <Text>편의점</Text>
          </IconWithText>
          </ButtonBox>  
          

          <ButtonBox
            onClick={() => {
              setText("영화관");
            }}
          >
            <IconWithText>
            <Icon1 />
            <Text>영화관</Text>
          </IconWithText>

          </ButtonBox>
          <ButtonBox
            onClick={() => {
              setText("술집");
            }}
          >
            <IconWithText>
            <Icon2 />
            <Text>술집</Text>
          </IconWithText>
          </ButtonBox>

          <ButtonBox
            onClick={() => {
              setText("놀이공원");
            }}
          >
           <IconWithText>
            <Icon3 />
            <Text>놀이공원</Text>
          </IconWithText>
          </ButtonBox>

          <ButtonBox
            onClick={() => {
              setText("피시방");
            }}
          >
            <IconWithText>
            <Icon4 />
            <Text>피시방</Text>
          </IconWithText>
          </ButtonBox>
          
        </Div>
      </Wrap>
      




      <Wrap>
        <Div>
        <div style={{ marginBottom: "2.5rem" }}></div>
          <ButtonBox
            onClick={() => {
              setText("카페");
            }}
          >
            <IconWithText>
            <Icon5 />
            <Text>카페</Text>
          </IconWithText>
          </ButtonBox>

          <ButtonBox
            onClick={() => {
              setText("음식점");
            }}
          >
            <IconWithText>
            <Icon6 />
            <Text>음식점</Text>
          </IconWithText>
          </ButtonBox>
          <ButtonBox
            onClick={() => {
              setText("뷰티");
            }}
          >
            <IconWithText>
            <Icon7 />
            <Text>뷰티</Text>
          </IconWithText>
          </ButtonBox>

          <ButtonBox
            onClick={() => {
              setText("패스트푸드점");
            }}
          >
            <IconWithText>
            <Icon8 />
            <Text>패스트푸드점</Text>
          </IconWithText>
          </ButtonBox>

          <ButtonBox
            onClick={() => {
              setText("일일알바");
            }}
          >
            <IconWithText>
            <Icon9 />
            <Text>일일알바</Text>
          </IconWithText>
          </ButtonBox>
          
        </Div>
      </Wrap>
    </React.Fragment>
  );
};


export default Category;

const Text = styled.div`
  margin-top: 8px; /* 아이콘과 텍스트 사이의 간격 조절 */
`;

const Wrap = styled.div`
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 70px auto 0px auto;

  margin-bottom: 65px;
  box-sizing: border-box;
`;


const Div = styled.div`
  width: 100vw;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  @media (max-width: 1024px) {
    width: 80%;
    height: auto;
    justify-content: center;
  }

  @media (max-width: 767px) {
    width: 100%;
    height: auto;
    justify-content: center;
  }
`;

const ButtonBox = styled.div`
  flex-direction: column;
  text-align: center;
  width: 9rem;
  height: 9rem;
  display: flex;
  font: inherit;
  font-weight: 800;
  font-size: 17px;
  margin: 0px 3rem;

  :hover {
    transition: all 0.3s;
    font-weight: bold;
    transform: translateY(-4px);
  }

  @media (max-width: 1024px) {
    width: 9rem;
    height: auto;
    justify-content: center;
    margin: 0px;
    & div {
      width: 9rem;
      height: 9rem;
      font-size: 15px;
    }
  }

  @media (max-width: 767px) {
    width: 6.5rem;
    height: auto;
    justify-content: center;
    margin: 0px;
    & div {
      width: 6.5rem;
      height: 6.5rem;
      font-size: 15px;
    }
  }
  @media (max-width: 414px) {
    width: 4.7rem;
    height: auto;
    justify-content: center;
    margin: 0px;
    & div {
      width: 5rem;
      height: 5rem;
      font-size: 12px;
    }
  }

  @media (max-width: 375px) {
    width: 5rem;
    height: auto;
    justify-content: center;
    margin: 0px;
    & div {
      width: 5rem;
      height: 5rem;
      font-size: 12px;
    }
  }

  @media (max-width: 280px) {
    width: 6rem;
    height: auto;
    justify-content: center;
    margin: 0px;
    & div {
      width: 5.5rem;
      height: 5.5rem;
      font-size: 12px;
    }
  }
`;

const IconWithText = styled.div`
  display: flex;
  flex-direction: column; /* 세로 방향으로 아이콘과 텍스트를 나열 */
  align-items: center;
  text-align: center;
`;


const Icon = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate8}");
  align-items: flex-end;
  justify-content: center;
  border-radius: 10px;
`;

const Icon1 = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate7}");
  
  align-items: flex-end;
  justify-content: center;
`;

const Icon2 = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate12}");
  align-items: flex-end;
  justify-content: center;
`;

const Icon3 = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate11}");
  align-items: flex-end; 
  justify-content: center; 
`;


const Icon4 = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate10}");
  align-items: flex-end;
  justify-content: center;
  
`;

const Icon5 = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate6}");
  align-items: flex-end;
  justify-content: center;
  border-radius: 10px;
 
`;
const Icon6 = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate9}");
  align-items: flex-end;
  justify-content: center;
  border-radius: 10px;
 
`;
const Icon7 = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate1}");
  align-items: flex-end;
  justify-content: center;
  border-radius: 10px;
 
`;
const Icon8 = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate2}");
  align-items: flex-end;
  justify-content: center;
  border-radius: 10px;
 
`;
const Icon9 = styled.div`
  display: flex;
  width: 7rem;
  height: 7rem;
  background-size: cover;
  background-image: url("${cate3}");
  align-items: flex-end;
  justify-content: center;
  border-radius: 10px;
 
`;