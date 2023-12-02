import React from "react";
import { Route, Routes } from "react-router-dom";
// import { useDispatch, useSelector } from "react-redux";
import Header from "./components/Header";
import Navi from "./components/Navi";
// import { ConnectedRouter } from "connected-react-router";
// import { history } from "./redux/store";
import './App.css';
import { getCookie } from "./shared/cookie";
import { useDispatch } from "react-redux";
import { actionCreators as userActions } from "./redux/modules/user";
// import EditFreeTalk from "./pages/EditFreeTalk";
// import EditPost from "./pages/EditPost";
import FreeBoardPage from "./pages/FreeBoardPage";
// import CreateFreeTalk from "./pages/CreateFreeTalk";
import Login from "./pages/Login";
import Main from "./pages/Main";
import SignUp  from "./pages/SignUp";

// const Main = lazy(() => import("./pages/Main"));
// const Login = lazy(() => import("./pages/Login"));
// const SignUp = lazy(() => import("./pages/SignUp"));
// import MyPage from "./pages/MyPage";
// import CreatePost from "./pages/CreatePost";

// import StoreDetail  from "./pages/StoreDetail";
import PostListPage from "./pages/PostListPage";



function App() {
  const dispatch = useDispatch();
  const cookie = getCookie("is_login") ? true : false;

  // 쿠키가 있으면 새로고침 시 회원정보를 불러와 is_login = true를 유지 시켜준다.(로그인 후 날아가는 유저정보 유지장치)
  React.useEffect(() => {
    if (cookie) {
      dispatch(userActions.getUserDB());
    }
  },  [cookie, dispatch]);;

  return (
    <React.Fragment>
      <div className="App">
      <Header />
      <Navi />
            <Routes>
              <Route path= "/" element={<Main />} />
              <Route path="/login" element={<Login />} />
              <Route path="/signup" element={<SignUp />} />
              <Route path="/postlistpage" element={<PostListPage/>} />
              <Route path="/freeboardpage" element={<FreeBoardPage/>} />
            </Routes>
        
    </div>
    </React.Fragment>
  
  );
}

export default App;

// function App() {
  
//   return (
//     <div className="App">
//       <Routes>
//         <Route path="/" element = {<Main />} />
//         <Route path="/mypage" element = {<MyPage />} />
//         <Route path="/Signup" element = {<SignUp />} />
//         <Route path="/createpost" element = {<CreatePost />} />
//         <Route path="/createfreetalk" element = {<CreateFreeTalk />} />
//         <Route path="/freeboard/:tagname" element = {<FreeBoardPage />} />
        

//         <Route path="/editfreetalk/:freetalkid" element = {<EditFreeTalk />} />
//         <Route path="/editpost/:postid" element = {<EditPost />} />

//         <Route path="/StoreDetail/:postid" element = {<StoreDetail />} />
//         <Route path="/StoreList" element = {<StoreList />} />
  

//         <Route path="/Login" element = {<Login />} />

//       </Routes>
//     </div>
//   );
// }
