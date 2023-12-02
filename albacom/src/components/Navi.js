import "./Navi.css";
import React from "react";
import { Link } from "react-router-dom";

const Navi = () => {
   return (
    <div className="nav__bar">
            <ul className="nav__menu">   
            <Link to="/" style={{ marginTop: "10px", marginLeft: "10px" }}>
            <div className="white_font"> 홈 </div>
            </Link>

            <Link to="/PostListPage" style={{ marginTop: "10px", marginLeft: "10px" }}><div className="white_font"> 후기 목록 </div></Link>
            <Link to="/freeboardpage" style={{ marginTop: "10px", marginLeft: "10px" }}><div className="white_font"> 자유게시판 </div></Link>
            <Link to="/MyPage" style={{ marginTop: "10px", marginLeft: "10px" }}><div className="white_font"> 마이페이지 </div></Link>
            </ul>
  </div>
  );
};

export default Navi;

