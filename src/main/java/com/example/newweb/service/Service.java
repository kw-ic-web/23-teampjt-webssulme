package com.example.newweb.service;

import com.example.newweb.mapper.Mapper;
import com.example.newweb.model.freeBoardModel;
import com.example.newweb.model.storeCommentModel;
import com.example.newweb.model.storeModel;
import com.example.newweb.model.userModel;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@org.springframework.stereotype.Service
public class Service {

    @Autowired
    private Mapper mapper;

    // 로그인
    public List<userModel> loginCheck(String nickname, String pw) {
        return mapper.loginCheck(nickname, pw);
    }

    // 회원가입
    public String getLoginIdList(String nickname){
        return mapper.getLoginIdList(nickname);
    }

    public boolean insertUser(String nickname, String pw){
        Timestamp updated_at = new Timestamp(new Date().getTime());
        if (mapper.insertUser(nickname, pw, updated_at))
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

    // 방금 작성한 자유게시판 글을 불러옴
    public freeBoardModel getCompleteContent(int id){
        return  mapper.getCompleteContent(id);
    }


    // 마이페이지
    // 자유게시판에 등록된 자신의 글을 가져옴
    public List<freeBoardModel> getMyFreeBoardContentList(String user_nickname){
        return mapper.getMyFreeBoardContentList(user_nickname);
    }

    // 자신이 작성한 후기글 가져오기
    public List<storeCommentModel> getMypageCommentList(String user_nickname){
        return mapper.getMypageCommentList(user_nickname);
    }

    // 작성한 자유게시판 글 수정
    public boolean putFreeBoardContent(int id, String title, String content) throws Exception{
        Timestamp updated_at = new Timestamp(new Date().getTime());
        return mapper.putFreeBoardContent(id, title, content, updated_at);
    }

    // 메인페이지
    // 메인페이지 카테고리 클릭시, 해당 카테고리 가게 목록 리스트
    public List<storeModel> getCategoryStoreList(String category) throws Exception{
        List<storeModel> storeList = mapper.getCategoryStoreList(category);
        return storeList;
    }

    // 해당 가게 후기 가져오기
    public List<storeCommentModel> getStoreCommentList(String store_id) throws Exception{
        return mapper.getStoreCommentList(store_id);
    }
}
