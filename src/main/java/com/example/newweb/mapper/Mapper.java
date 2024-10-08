package com.example.newweb.mapper;

import com.example.newweb.model.*;

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

    // 완료한 글내용 가져오기
    public freeBoardModel getCompleteContent(int id);

    // 자유게시판의 특정 글의 댓글 가져옴
    public List<freeBoardCommentModel> getFreeBoardCommentList(int free_board_id);

    // 자우게시판의 특절 글에 댓글 작성하기
    public boolean insertFreeBoardComment(int free_board_id, String user_nickname, String content);


    // 마이페이지
    // 자유게시판에 등록된 내 글을 가져옴
    public List<freeBoardModel> getMyFreeBoardContentList(String user_nickname);

    public List<storeCommentModel> getMypageCommentList(String user_nickname);

    // 자유게시판에 등록된 글 수정
    public boolean putFreeBoardContent(int id, String title, String content, Timestamp updated_at);

    // 자유게시판에 등록된 글 삭제
    public boolean deleteFreeBoardContent(int id);

    // 프로필 가져오기
    public userModel getMypageProfile(String nickname);

    // 프로필 편집
    public boolean postMypageProfile(String nickname, String pw, Timestamp updated_at);

    // 메인페이지
    // 메인페이지 카테고리 클릭시, 해당 카테고리 가게 목록
    public List<storeModel> getCategoryStoreList(String category);

    public storeModel getStore(int store_id);

    // 해당 가게의 후기 목록을 가져옴
    public List<storeCommentModel> getStoreCommentList(String store_id);

    // 해당 가게에 후기 추가
    public boolean insertStoreComment(String user_nickname, int store_id, String content);
}
