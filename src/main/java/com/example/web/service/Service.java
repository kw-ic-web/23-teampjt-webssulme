package com.example.web.service;

import com.example.web.mapper.Mapper;
import com.example.web.model.freeBoardModel;
import com.example.web.model.loginModel;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@org.springframework.stereotype.Service
public class Service {

    @Autowired
    private Mapper mapper;

    // 로그인
    public List<loginModel> loginCheck(String nickname, String pw) {
        return mapper.loginCheck(nickname, pw);
    }

    // 회원가입
    public String getLoginIdList(String nickname){
        return mapper.getLoginIdList(nickname);
    }

    public boolean insertUser(String nickname, String pw){
        if (mapper.insertUser(nickname, pw))
            return true;
        return false;
    }

    // 자유게시판
    // 자유게시판 메인페이지 목록을 가져옴
    public List<freeBoardModel> getFreeBoardList(){
        return mapper.getFreeBoardList();
    }

    // 자유게시판 새 글 등록하기
    public boolean insertFreeBoardNewContent(String user_nickname, String title, String content){
        if (mapper.insertFreeBoardNewContent(user_nickname, title, content))
            return true;
        return false;
    }

    // 자유게시판에 등록된 자신의 글을 가져옴
    public List<freeBoardModel> getMyFreeBoardContentList(String user_nickname){
        return mapper.getMyFreeBoardContentList(user_nickname);
    }
}
