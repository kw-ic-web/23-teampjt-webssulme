import {Routes,Route} from "react-router-dom" ;

import './App.css';

import CommunityPage from "./pages/CommunityPage";
import EditFreeTalk from "./pages/EditFreeTalk";
import EditPost from "./pages/EditPost";
import FreeBoardPage from "./pages/FreeBoardPage";
import CreateFreeTalk from "./pages/CreateFreeTalk";
import Login from "./pages/Login";
import Main from "./pages/Main";
import MyPage from "./pages/MyPage";
import CreatePost from "./pages/CreatePost";
import SignUp  from "./pages/SignUp";
import StoreDetail  from "./pages/StoreDetail";
import StoreList from "./pages/StoreList";


function App() {
  
  return (
    <div className="App">
      <Routes>
        <Route path="/" element = {<Main />} />
        <Route path="/mypage" element = {<MyPage />} />
        <Route path="/signup" element = {<SignUp />} />
        <Route path="/createpost" element = {<CreatePost />} />
        <Route path="/createfreetalk" element = {<CreateFreeTalk />} />
        <Route path="/community" element = {<CommunityPage />} />
        <Route path="/freeboard/:tagname" element = {<FreeBoardPage />} />
        

        <Route path="/editfreetalk/:freetalkid" element = {<EditFreeTalk />} />
        <Route path="/editpost/:postid" element = {<EditPost />} />

        <Route path="/storedetail/:postid" element = {<StoreDetail />} />
        <Route path="/storelist/:postid" element = {<StoreList />} />
  

        <Route path="/login" element = {<Login />} />

      </Routes>
    </div>
  );
}

export default App;
