import React from "react";
import styled from "styled-components";
import { Link } from "react-router-dom";
import {useNavigate } from "react-router-dom";
import { useDispatch } from "react-redux";
import { pwdCheck } from "../shared/check";

import { actionCreators as userActions } from "../redux/modules/user";

const SignUp = () => {
  const dispatch = useDispatch();

  const navigate = useNavigate();

  const [id, setId] = React.useState("");
  const [pwd, setPwd] = React.useState("");
  const [pwdcheck, setPwdCheck] = React.useState("");

  const signup = () => {
    // 값이 하나라도 없다면 alert 띄워주기
    if (!id || !pwd || !pwdcheck) {
      window.alert("모든 내용을 입력해주세요!");
      return;
    }
  
    // 비밀번호 정규표현식에 맞지 않을 때
    if (!pwdCheck(pwd)) {
      window.alert("8~16자리의 영문과 숫자를 조합해주세요!");
      return;
    }
    // 비밀번호와 비밀번호확인이 일치하지 않을 때
    if (pwd !== pwdcheck) {
      window.alert("비밀번호가 일치하지 않습니다. 다시 입력 해주세요.");
      return;
    }

    dispatch(userActions.signUpDB(id, pwd,navigate));
  };


  return (
    <React.Fragment>
      <Div>
        <H1>회원가입</H1>
        <P>아이디</P>
        <Input
          onChange={(e) => {
            setId(e.target.value);
          }}
          placeholder="사용하실 닉네임 겸 아이디를 입력해주세요."
        />  
        
        <P>비밀번호</P>
        <Input
          type="password"
          onChange={(e) => {
            setPwd(e.target.value);
          }}
          placeholder="비밀번호를 입력해주세요."
        ></Input>
        <P>비밀번호 확인</P>
        <Input
          type="password"
          onChange={(e) => {
            setPwdCheck(e.target.value);
          }}
          placeholder="비밀번호를 한번 더 입력해주세요."
        ></Input>

        <Button onClick={signup}>회원가입</Button>
       
      </Div>
    </React.Fragment>
  );
};

export default SignUp;

const Div = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 32rem;
  margin: 0px auto;
  margin-top: 6.25rem;
  border: 2px solid #f9ebff;
  border-radius: 20px;
  padding: 50px 50px 50px 50px;
  background-color: #f4f4f4;
  @media all and (max-width: 414px) {
    width: auto;
    margin: 1rem;
    & h1 {
      font-size: 1.5rem;
    }
  }
  @media all and (max-width: 375px) {
    width: auto;
    margin: 1rem;
    & h1 {
      font-size: 1.5rem;
    }
  }
`;

const P = styled.p`
  font-size: 20px;
  color:#000000;
  margin: 0px auto;
  margin-bottom: 5px;
  margin-left: 50px;
  margin-top: 10px;
  @media all and (max-width: 414px) {
    margin-left: 0;
    font-size: 1rem;
  }
  @media all and (max-width: 375px) {
    margin-left: 0;
    font-size: 1rem;
  }
`;

const Input = styled.input`
  width: 25rem;
  height: 40px;
  margin: 0px auto;
  padding-left: 5px;
  @media all and (max-width: 414px) {
    width: 100%;
  }
  @media all and (max-width: 375px) {
    width: 100%;
  }
`;

const Button = styled.button`
  width: 12.5rem;
  height: 3rem;
  margin: 30px auto;
  background-color: #ffcc00;
  border: 0px solid #e6ccef;
  border-radius: 5px;
  font-size: 1rem;
`;

const H1 = styled.h1`
  display: flex;
  justify-content: center;
  margin: 0px auto;
  margin-bottom: 30px;
`;

// export default SignUp;
