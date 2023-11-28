package com.example.web.mapper;

import com.example.web.model.freeBoardModel;
import com.example.web.model.userModel;

import java.sql.Timestamp;
import java.util.List;

@org.apache.ibatis.annotations.Mapper
public interface Mapper {

    // 로그인
    // id, pw를 입력받아 있는 해당 아이디 비번 리턴
    public List<userModel> loginCheck(String nickname, String pw);

    // 회원가입
    // 입력받은 nickname과 DB를 비교하여 같은 것이 있으면 true 반환, 아니면 false 반환
    public String getLoginIdList(String nickname);

    // 사용자 정보 DB에 저장
    public boolean insertUser(String nickname, String pw, Timestamp updated_at);

    // 자유게시판
    // 자유게시판 메인 페이지 목록 리스트를 가져옴
    public List<freeBoardModel> getFreeBoardList();

    // 자유게시판 새글 등록하기
    public boolean insertFreeBoardNewContent(String user_nickname, String title, String content);

    // 자유게시판에 등록된 내 글을 가져옴
    public List<freeBoardModel> getMyFreeBoardContentList(String user_nickname);

    // 자유게시판에 등록된 글 수정
    public boolean putFreeBoardContent(int id, String title, String content, Timestamp updated_at);
}
