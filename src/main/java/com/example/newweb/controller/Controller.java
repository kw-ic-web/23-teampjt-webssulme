package com.example.newweb.controller;

import com.example.newweb.model.*;
import com.example.newweb.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@org.springframework.stereotype.Controller
public class Controller {

    @Autowired
    Service service;

    // 메인페이지
    // 메이페이지 보여주기
    @RequestMapping("/")
    public String showMain(Model model) throws Exception{
        try {
            return "main";
        } catch (Exception e){
            System.out.println("메인페이지 로딩 실패");
            System.out.println(e);
            return null;
        }
    }

    // 메인페이지 가게 목록 페이지 로딩
    @RequestMapping("/storeList")
    public String showStoreList(Model model) throws Exception{
        try {
            return "storeList";
        } catch (Exception e){
            System.out.println("메인페이지 가게 목록 페이지 로딩 성공");
            System.out.println(e);
            return null;
        }
    }

    // 메인페이지 해당 가게 상세 페이지 로딩
    @RequestMapping("/storeView")
    public String showStoreView(Model model) throws Exception{
        try {
            return "storeView";
        } catch (Exception e){
            System.out.println("메인페이지 해당 가게 상세 페이지 로딩 실패");
            System.out.println(e);
            return null;
        }
    }

    // 메인페이지에서 카테고리 클릭시, 해당 카테고리 음식점 목록
    @ResponseBody
    @GetMapping("/category/{category}")
    public List<storeModel> getCategoryStoreList(@PathVariable("category") String category) throws Exception{
        try {
            List<storeModel> storeList = service.getCategoryStoreList(category);

            return storeList;
        } catch (Exception e){
            System.out.println(category  + " 카테고리 가게 리스트를 가져오는데 실패하였습니다.");
            System.out.println(e);
            return null;
        }
    }

    // 카테고리 별로 분류된 목록 중, 특정 음식점 정보 가져오기
    @ResponseBody
    @GetMapping("/store/{store_id}")
    public storeModel getStore(@PathVariable("store_id") int store_id) throws Exception{
        try {
            storeModel storeInfo = service.getStore(store_id);
            System.out.println("가게 정보를 가져오는데 성공하였습니다.");

            return storeInfo;
        } catch (Exception e){
            System.out.println("가게 정보를 가져오는데 실패하였습니다.");
            System.out.println(e);
            return null;
        }
    }

    // 가게 후기 목록 가져오기
    @ResponseBody
    @GetMapping("/store/comment/{store_id}")
    public List<storeCommentModel> getStoreCommentList(@PathVariable("store_id") String store_id) throws Exception{
        try {
            List<storeCommentModel> storeCommentList = service.getStoreCommentList(store_id);

            return  storeCommentList;
        } catch (Exception e) {
            System.out.println(store_id + "의 가게 후기를 가져오는 과정에서 오류가 발생했습니다.");
            System.out.println(e);
            return null;
        }
    }

    // 가게 후기 작성
    @ResponseBody
    @PostMapping("/store/comment/{user_nickname}/{store_id}/{content}")
    public boolean insertStoreComment(@PathVariable("user_nickname") String user_nickname,
                                     @PathVariable("store_id") int store_id, @PathVariable("content") String content) throws Exception{
        try {
            storeCommentModel storeComment = new storeCommentModel();
            storeComment.setUser_nickname(user_nickname);
            storeComment.setStore_id(store_id);
            storeComment.setContent(content);
            boolean result = service.insertStoreComment(user_nickname, store_id, content);
            System.out.println(user_nickname + "유저의 " + store_id + "가게의 후기가 작성되었습니다.");

            return result;
        } catch (Exception e) {
            System.out.println(store_id + "의 가게 후기를 작성하는 과정에서 오류가 발생했습니다.");
            System.out.println(e);
            return false;
        }
    }

    // 로그인
    // 로그인 페이지
    @GetMapping("/login")
    public String show(Model model) throws Exception{
        try {
            return "login";
        } catch (Exception e){
            System.out.println("로그인 페이지 로딩 실패");
            System.out.println(e);
            return null;
        }
    }

    // 로그인 체크
    @ResponseBody
    @PostMapping("/login/check/{nickname}/{pw}")
    public List<userModel> loginCheck(@PathVariable("nickname") String nickname, @PathVariable("pw") String pw) throws Exception{
        try {
            List<userModel> userInfo = service.loginCheck(nickname, pw);
            System.out.println(userInfo);

//            Map<String, Object> data = new HashMap<>();
//            data.put("nickname", userInfo);
            
            // 해당 아이디 정보가 있으면
            if (userInfo.size() != 0){
                return userInfo;
            }else {
                return null;
            }
        } catch (Exception e){
            System.out.println(e);
            return null;
        }
    }

    
    // 회원가입
    // 회원가입 페이지
    @GetMapping("join")
    public String showJoinPage(Model model) throws Exception{
        try {
            return "join";
        } catch (Exception e){
            System.out.println("회원가입 페이지 로딩 실패");
            System.out.println(e);
            return null;
        }
    }

    // ID 중복 확인
    @ResponseBody
    @GetMapping("/join/idCheck/{nickname}")
    public boolean joinIdCheck(@PathVariable("nickname") String nickname, Model model) throws Exception{
        try {
            // DB에서 nickname이 있는지 검사
            String idList = service.getLoginIdList(nickname);

            // nickname이 null이 아니고 디비에 있으면 true, 없으면 false
            if (nickname != null && nickname.equals(idList)){
                return true;
            } else{
                return false;
            }
        } catch (Exception e){
            System.out.println(e);
            return false;
        }
    }

    // 회원가입 기능
    @ResponseBody
    @PostMapping("/join/insert/{nickname}/{pw}")
    public boolean insertUser(@PathVariable("nickname") String nickname, @PathVariable("pw") String pw, Model model) throws  Exception{
        try {
            // user nickname, pw를 DB에 넣고, 그 결과를 result에 저장
            boolean result = service.insertUser(nickname, pw);
            System.out.println(result);
            System.out.println("DB에 nickname: " + nickname + " / pw: " + pw + " 을 저장하였습니다.");

            return result;

        } catch (Exception e){
            System.out.println("DB에 사용자 정보를 저장하지 못했습니다.");
            System.out.println(e);
            return false;
        }
    }


    // 자유게시판
    // 자유게시판 메인 페이지 로딩
    @GetMapping("/freeboard")
    public String showFreeBoardMainPage() throws Exception{
        try {
            return "free_boardList";
        } catch (Exception e){
            System.out.println("자유게시판 메인페이지 로딩 실패");
            System.out.println(e);
            return null;
        }
    }

    // 자유게시판 글 작성 페이지 로딩
    @GetMapping("/freeboardwrite")
    public String showFreeBoardWritePage() throws Exception{
        try {
            return "free_boardWrite";
        } catch (Exception e){
            System.out.println("자유게시판 글 작성 로딩 실패");
            System.out.println(e);
            return null;
        }
    }

    // 자유게시판 글 수정 페이지 로딩
    @GetMapping("/freeboardedit")
    public String showFreeBoardEditPage() throws Exception{
        try {
            return "free_boardEdit";
        } catch (Exception e){
            System.out.println("자유게시판 글 수정 로딩 실패");
            System.out.println(e);
            return null;
        }
    }

    // 자유게시판 자신이 작성한 글 페이지 로딩
    @GetMapping("/freeboardview")
    public String showFreeBoardViewPage() throws Exception{
        try {
            return "free_boardView";
        } catch (Exception e){
            System.out.println("자유게시판 자신이 작성한 글 페이지 실패");
            System.out.println(e);
            return null;
        }
    }


    // 자유게시판 목록 리스트 가져오기 (list.html)
    @ResponseBody
    @GetMapping("/freeboard/getfreeboardlist")
    public List<freeBoardModel> getFreeBoardList(Model model) throws Exception{
        try {
            List<freeBoardModel> freeBoardList = service.getFreeBoardList();
            System.out.println(freeBoardList);
            return freeBoardList;

        } catch (Exception e){
            System.out.println("자유게시판 목록을 가져오지 못했습니다.");
            System.out.println(e);
            return null;
        }
    }

    // 자유게시판 새 글 작성한 것을 데이터베이스에 등록 (write.html)
    @ResponseBody
    @PostMapping("/freeboard/insertnewcontent/{user_nickname}/{title}/{content}")
    public boolean insertNewContent(@PathVariable("user_nickname") String user_nickname,
                                    @PathVariable("title") String tile,
                                    @PathVariable("content") String content) throws Exception{
        try {
            boolean result = service.insertFreeBoardNewContent(user_nickname, tile, content);
            System.out.println("자유게시판 새글 등록에 성공하였습니다.");
            return result;

        } catch (Exception e){
            System.out.println("자유게시판 새글 등록에 실패하였습니다.");
            System.out.println(e);
            return false;
        }
    }

    // 자유게시판에 작성한 글 다시 보여주기
    @ResponseBody
    @GetMapping("/freeboard/complete/{id}")
    public freeBoardModel getCompleteContent(@PathVariable("id") int id) throws Exception{
        try{
            freeBoardModel completeContent = service.getCompleteContent(id);

            if (completeContent.getContent() != null) {
                System.out.println("방금 작성한 새글을 불러오는데 성공하였습니다.");
                return completeContent;
            } else {
                System.out.println("방금 작성한 새글을 불러오는데 실패하였습니다.");
                return null;
            }
        }catch (Exception e){
            System.out.println("방금 작성한 새글을 불러오는데 실패하였습니다.");
            System.out.println(e);
            return null;
        }
    }

    // 작성한 자유게시판 글을 수정 (edit.html)
    @ResponseBody
    @PutMapping("/freeboard/putcontent/{id}/{title}/{content}")
    public boolean putFreeBoardContent(@PathVariable("id") int id,
                                       @PathVariable("title") String title,
                                       @PathVariable("content") String content) throws Exception{
        try {
            boolean result = service.putFreeBoardContent(id, title, content);
            if (result){
                System.out.println("글을 수정하였습니다.");
                return true;
            } else {
                System.out.println("글을 수정하는데 실패하였습니다.");
                return false;
            }
        } catch (Exception e) {
            System.out.println("글을 수정하는데 실패하였습니다.");
            System.out.println(e);
            return false;
        }
    }

    // 작성한 자유게시판 글을 삭제(edit.html)
    @ResponseBody
    @DeleteMapping("/freeboard/deletecontent/{id}")
    public boolean deleteFreeBoardContent(@PathVariable("id") int id) throws Exception{
        try {
            boolean result = service.deleteFreeBoardContent(id);
            if (result){
                System.out.println("글을 삭제하였습니다.");
                return true;
            } else {
                System.out.println("글을 삭제하는데 실패하였습니다.");
                return false;
            }
        } catch (Exception e) {
            System.out.println("글을 삭제하는데 실패하였습니다.");
            System.out.println(e);
            return false;
        }
    }

    // 자유게시판 특정 글의 댓글 가져오기
    @ResponseBody
    @GetMapping("/freeboard/getcontent/{free_board_id}")
    public List<freeBoardCommentModel> getFreeBoardCommentList(@PathVariable("free_board_id") int free_board_id) throws Exception{
        try {
            List<freeBoardCommentModel> freeBoardCommentList = service.getFreeBoardCommentList(free_board_id);

            System.out.println("자유게시판 글의 댓글을 가져오는데 성공하였습니다.");
            return freeBoardCommentList;
        } catch (Exception e) {
            System.out.println("자유게시판 글의 댓글을 가져오는데 실패하였습니다.");
            System.out.println(e);
            return null;
        }
    }

    // 자유게시판 특정 글에 댓글 작성하기
    @ResponseBody
    @PostMapping("/freeboard/insertcontent/{free_board_id}/{user_nickname}/{content}")
    public boolean insertFreeBoardComment(@PathVariable("free_board_id") int free_board_id,
                                          @PathVariable("user_nickname") String user_nickname,
                                          @PathVariable("content") String content) throws Exception{
        try {
            boolean result = service.insertFreeBoardComment(free_board_id, user_nickname, content);

            System.out.println("자유게시판 글에 댓글을 작성하였습니다.");
            return result;
        } catch (Exception e) {
            System.out.println("자유게시판 글에 댓글을 작성하는데 실패하였습니다.");
            System.out.println(e);
            return false;
        }
    }


    // 마이페이지
    // 마이페이지 메인 페이지 로딩
    @GetMapping("/mypage")
    public String showMyPage() throws Exception{
        try {
            return "mypage";
        } catch (Exception e){
            System.out.println("마이페이지 로딩 실패");
            System.out.println(e);
            return "null";
        }
    }

    // 프로필 변경 페이지 로딩
    @GetMapping("/mypage/profile")
    public String showMyPageProfile() throws Exception{
        try {
            return "editmyprofile";
        } catch (Exception e){
            System.out.println("프로필 변경 페이지 로딩 실패");
            System.out.println(e);
            return "null";
        }
    }

    // 마이페이지 내가 작성한 자유게시판 글 페이지 로딩
    @GetMapping("/mypage/myfreepost")
    public String showMyPageMyFreePost() throws Exception{
        try {
            System.out.println("마이페이지 내가 작성한 자유게시판 글 페이지 로딩 성공");
            return "myfreepost";
        } catch (Exception e){
            System.out.println("마이페이지 내가 작성한 자유게시판 글 페이지 로딩 실패");
            System.out.println(e);
            return "null";
        }
    }

    // 마이페이지 내가 작성한 후기 목록 페이지 로딩
    @GetMapping("/mypage/mypost")
    public String showMyPageMyPost() throws Exception{
        try {
            System.out.println("마이페이지 내가 작성한 후기 목록 페이지 로딩 성공");
            return "mypost";
        } catch (Exception e){
            System.out.println("마이페이지 내가 작성한 후기 목록 페이지 로딩 실패");
            System.out.println(e);
            return "null";
        }
    }

    // 마이페이지에 자신이 작성한 자유게시판 글의 리스트를 가져오기
    @ResponseBody
    @GetMapping("/mypage/contentlist/{nickname}")
    public List<freeBoardModel> getMyFreeBoardContentList(@PathVariable("nickname") String user_nickname) throws Exception{
        try {
            List<freeBoardModel> myFreeBoardContentList = service.getMyFreeBoardContentList(user_nickname);
            System.out.println("마이페이지에 등록된 자신의 글을 가져오는데 성공하였습니다.");
            return myFreeBoardContentList;

        } catch (Exception e){
            System.out.println("마이페이지에 등록된 자신의 글을 가져오는데 실패하였습니다.");
            System.out.println(e);
            return null;
        }
    }

    // 자신이 작성한 가게 후기 가져오기
    @ResponseBody
    @GetMapping("/mypage/commentlist/{user_nickname}")
    public List<storeCommentModel> getMypageCommentList(@PathVariable("user_nickname") String user_nickname) throws Exception{
        try {
            List<storeCommentModel> mypageCommentList = service.getMypageCommentList(user_nickname);

            return  mypageCommentList;
        } catch (Exception e){
            System.out.println("등록한 자신의 댓글을 가져오는 과정에서 오류가 발생하였습니다.");
            System.out.println(e);
            return null;
        }
    }

    // 프로필 가져오기
    @ResponseBody
    @GetMapping("/mypage/profile/{nickname}")
    public userModel getMypageProfile(@PathVariable("nickname") String nickname) throws Exception{
        try {
            userModel info = service.getMypageProfile(nickname);

            return info;
        } catch (Exception e){
            System.out.println("자신의 프로필을 가져오는 과정에서 오류가 발생하였습니다.");
            System.out.println(e);
            return null;
        }
    }

    // 프로필 편집하기(비밀번호)
    @ResponseBody
    @PutMapping("/mypage/profile/{nickname}/{pw}")
    public boolean postMypageProfile(@PathVariable("nickname") String nickname, @PathVariable("pw") String pw) throws Exception{
        try {
            boolean result = service.postMypageProfile(nickname, pw);

            System.out.println(nickname + "의 유저의 비밀번호를 " + pw + "로 정상적으로 변경하였습니다.");
            return result;
        } catch (Exception e){
            System.out.println("프로필을 수정하는 과정에서 오류가 발생하였습니다.");
            System.out.println(e);
            return false;
        }
    }
}
