import { createAction, handleActions } from "redux-actions";
import { produce } from "immer";
import { config } from "../../shared/config";
// import {useNavigate } from "react-router-dom";


import axios from "axios";
import { setCookie, deleteCookie, getCookie } from "../../shared/cookie";


// 액션 타입
const LOG_OUT = "LOG_OUT"; // 로그아웃
const GET_USER = "GET_USER"; //회원정보 조회
const SET_USER = "SET_USER"; // 로그인
// 액션 생성함수
const getUser = createAction(GET_USER, (user) => ({ user }));
const setUser = createAction(SET_USER, (user) => ({ user }));
const logOut = createAction(LOG_OUT, (user) => ({ user }));

//  초기값
// is_login : 로그인 상태인지 아닌지 여부 확인
const initialState = {
  user: "",
  is_login: false,
};

// 회원가입
const signUpDB = (id, nick, phone, email, name, pwd, navigate) => {
  return function (dispatch, getState) {
    axios({
      method: "post",
      url: `${config.api}/join`, // 바꿔야 될 것들 (상천이한테 받아서)
      // 회원가입 시 입력 데이터 보내기(보내기만 하면 끝)
      data: {
        user_id:id,
        user_nick_name : nick,
        user_name : name,
        user_passwd : pwd,
        user_phone:phone,
        user_email:email,
      },
    })
      .then(() => {
        window.alert("회원가입을 축하드립니다!");
        navigate('/login');
      })
      .catch((err) => {
        console.log("회원가입 에러", err);
        window.alert("이미 중복된 아이디입니다. 확인해주세요");
      });
  };
};

// 로그인
const LoginDB = (id, pwd,navigate) => {
  return function (dispatch, getState) {
    axios({
      method: "post",
      url: `${config.api}/login`, // 바꿔야 될 것들 (상천이한테 받아서)
      data: {
        user_id: id,
        user_passwd: pwd,
      },
    })
      .then((res) => {
        // console.log(res.data);

        // 서버로부터 받은 토큰 변수에 할당
        const jwtToken = res.data.result.user.token;

        // 서버로 부터 받은 토큰을 쿠키에 저장 (key:value 형태)
        setCookie("is_login", jwtToken);

        // 통신 시 헤더에 default 값으로 저장
        axios.defaults.headers.common["Authorization"] = `${jwtToken}`;

        const user = {
          user_id:id,
          user_name: res.data.result.user.user_name,
        };
        dispatch(setUser(user));
        navigate('/');
      })
      .catch((err) => {
        window.alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
        return;
      });
  };
};

// 로그인 후 회원 정보 조회 => 마이페이지 구현 
const getUserDB = () => {
  return function (dispatch, getState, { history }) {
    // 로그인 시 쿠키에 이미 is_login으로 토큰이 저장되어 있기 때문에
    const jwtToken = getCookie("is_login");
    // console.log(jwtToken);

    // 새로고침하면 헤더 default도 날라가기 때문에 다시 토큰을 달아준다.
    // 백엔드에서 헤더로 넘어온 Authorization 에서 토큰 값에서 토큰값을 뽑아주기로 함.
    axios.defaults.headers.common["Authorization"] = `Bearer ${jwtToken}`;

    // console.log(axios.defaults.headers);

    axios({
      method: "post",
      url: `${config.api}/getUser`,
    })
      .then((res) => {
        // console.log(res);
        const user = { 
          user_id : res.data.user_id,
          user_name : res.daata.user_name,
          user_email: res.data.user_email,
        };
        dispatch(getUser(user));
      })
      .catch((err) => {
        console.log("유저정보 조회 에러", err);
      });
  };
};

// 리듀서
export default handleActions(
  {
    [SET_USER]: (state, action) =>
      produce(state, (draft) => {
        // 로그인시 받은 회원 정보 저장, is_login 상태 true 변경
        draft.user = action.payload.user;
        draft.is_login = true;
      }),
    [LOG_OUT]: (state, action) =>
      produce(state, (draft) => {
        //쿠키 삭제
        deleteCookie("is_login");

        // 유저정보 삭제 하고 로그인상태 false로 변경
        draft.user = null;
        draft.is_login = false;
      }),
    [GET_USER]: (state, action) =>
      produce(state, (draft) => {
        // 로그인상태(is_login) true로 변경
        draft.user = action.payload.user;
        draft.is_login = true;
      }),
  },
  initialState
);

const actionCreators = {
  logOut,
  setUser,
  LoginDB,
  signUpDB,
  getUserDB,
};

export { actionCreators };
