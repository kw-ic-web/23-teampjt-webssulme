package com.example.newweb.service;

import com.example.newweb.mapper.Mapper;
import com.example.newweb.model.*;
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

    // 자유게시판 특정 글의 댓글을 가져옴
    public List<freeBoardCommentModel> getFreeBoardCommentList(int free_board_id){
        return mapper.getFreeBoardCommentList(free_board_id);
    }

    // 자유게시판 특정 글에 댓글 작성하기
    public boolean insertFreeBoardComment(int free_board_id, String user_nickname, String content){
        if(mapper.insertFreeBoardComment(free_board_id, user_nickname, content))
            return true;
        else
            return false;
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

    // 프로필 가져오기
    public userModel getMypageProfile(String nickname) throws Exception{
        return mapper.getMypageProfile(nickname);
    }

    // 프로필 편집
    public boolean postMypageProfile(String nickname, String pw) throws Exception{
        Timestamp updated_at = new Timestamp(new Date().getTime());
        if(mapper.postMypageProfile(nickname, pw, updated_at))
            return true;
        else
            return false;
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

    // 해당 가게에 후기 추가
    public boolean insertStoreComment(String user_nickname, int store_id, String content) throws Exception{
        if (mapper.insertStoreComment(user_nickname, store_id, content))
            return true;
        else
            return false;
    }
}
