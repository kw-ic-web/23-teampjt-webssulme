package com.example.web.controller;

import com.example.web.model.freeBoardModel;
import com.example.web.model.storeCommentModel;
import com.example.web.model.storeModel;
import com.example.web.model.userModel;
import com.example.web.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class Controller {

    @Autowired
    Service service;

    @GetMapping("/test")
    public String test(Model model) throws Exception{
        return "test";
    }

    @GetMapping("/test2")
    public String test2(Model model) throws Exception{
        return "test2";
    }

    // 로그인
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

    // 회원가입
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
            return "list";
        } catch (Exception e){
            System.out.println("자유게시판 메인페이지 로딩 실패");
            System.out.println(e);
            return "error";
        }
    }


    // 자유게시판 목록 리스트 가져오기 (list.html)
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



    // 메인페이지
    // 메인페이지에서 카테고리 클릭시, 해당 카테고리 음식점 목록
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

    // 가게 후기 목록 가져오기
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

    // 마이페이지
    // 마이페이지에 자신이 작성한 자유게시판 글의 리스트를 가져오기
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
}
