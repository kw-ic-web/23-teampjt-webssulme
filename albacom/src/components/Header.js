import React from "react";

import styled from "styled-components";
import {useNavigate } from "react-router-dom";


// import { history } from "../redux/store";
import { useSelector, useDispatch } from "react-redux";
import { getCookie } from "../shared/cookie";
import { actionCreators as userActions } from "../redux/modules/user";
import logo1 from "../shared/Logo1.png";

const Header = () => {
  const navigate = useNavigate();
  const dispatch = useDispatch();
  
  // 먼저 유저 정보를 불러온다.
  const user = useSelector((state) => state.user);
  console.log(user);
  // 쿠키에서 로그인 여부를 가져와, 로그인 상태의 뷰와 비로그인 상태일 때의 뷰를 나눠줌.
  const is_login = getCookie("is_login") ? true : false;
  console.log(is_login);

  // 로그아웃 실행함수
  const logout = () => {
    dispatch(userActions.logOut());
    window.alert("로그아웃 되었습니다.");
    navigate('/');
  };

  return (
    <Div >
      <Logo 
      onClick= {() =>  navigate('/login')}/>
    <Buttondiv>
          {is_login && user ? (
        <>
            <Nickname>
                <Username>{user.user.name}</Username>님
              </Nickname>
              <Button style={{ margin: "7px", marginRight: "5px" }}
              onClick={() => navigate('/write')}>
                새 글 작성
              </Button>
              <Button style={{ margin: "7px", marginRight: "15px" }}
              onClick={logout}>
                로그아웃
              </Button>
        </>
      ) : ( 
        <>

            <Nickname />
              <Button style={{ margin: "7px", marginRight: "15px" }}
              onClick={() => navigate('/login')}>
                로그인
              </Button>
              <Button style={{ margin: "7px", marginRight: "15px" }}
               onClick={() => navigate('/signup')}>
                회원가입
              </Button>
        </>
      )}
    </Buttondiv>
  </Div>

  
  );
};

export default Header;

const Div = styled.div`
  display: flex;
  flex-direction: row;
  width: 100vw;
  height: 75px;
  background-color: #ffffff;
  position: sticky;
  top: 0px;
  z-index: 999;
  align-items: center;
  justify-content: space-between;
  box-sizing: border-box;
`;


const Button = styled.button`
  font: inherit;
  font-size: 0.9rem;
  align-items: center;
  width: 100px;
  height: 35px;
  padding-top: 0.3rem;
  margin: 0px;
  border: 0px solid;
  background-color: #ffcc00;
  border-radius: 10px;
  :hover {
    /* background-color: white; */
    transition: all 0.3s;
    font-weight: bold;
  }
`;

const Buttondiv = styled.div`
  display: flex;
  width: 90%;
  margin: 0px auto;
  justify-content: flex-end;
  align-items: center;
  @media (max-width: 1024px) {
    font-size: 1rem;
    width: 70%;
    margin: 0px;
    & > div {
      width: 90%;
    }
    & > button {
      font-size: 1rem;
      width: 7.5rem;
    }
  }
  @media (max-width: 768px) {
    font-size: 1rem;
    width: 80%;
    & > div {
      width: 70%;
    }
    & > button {
      font-size: 0.9rem;
      width: 7.5rem;
    }
  }
  @media (max-width: 414px) {
    font-size: 0.8rem;
    width: 72%;
    & > div {
      width: 75%;
    }
    & > button {
      font-size: 0.7rem;
      width: 8rem;
    }
  }
  @media (max-width: 375px) {
    font-size: 0.7rem;
    & > div {
      width: 4rem;
      font-size: 0.7rem;
    }
    & > button {
      font-size: 0.5rem;
      width: 4rem;
    }
  }
  @media (max-width: 280px) {
    font-size: 0.5rem;
    width: 65%;
    & > div {
      width: 80%;
    }
    & > button {
      font-size: 0.4rem;
      width: 5rem;
    }
  }
`;

const Logo = styled.div`
  display: flex;
  width: 13rem;
  height: 4.5rem;
  background-size: cover;
  background-image: url("${logo1}");
  align-items: flex-end;
  justify-content: center;
`;



const Nickname = styled.div`
  width: 12.5rem;
  display: flex;
  flex-direction: row;
  justify-content: flex-end;
  margin-right: 10px;
  align-items: center;
`;

const Username = styled.div`
  font-weight: 700;
  width: 7rem;
  margin-right: 5px;
  display: flex;
  justify-content: flex-end;
  font-size: 1rem;
`;
