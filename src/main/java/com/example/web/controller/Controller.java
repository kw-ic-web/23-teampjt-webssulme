package com.example.web.controller;

import com.example.web.model.freeBoardModel;
import com.example.web.model.loginModel;
import com.example.web.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    public boolean loginCheck(@PathVariable("nickname") String nickname, @PathVariable("pw") String pw) throws Exception{
        try {
            List<loginModel> userInfo = service.loginCheck(nickname, pw);
            System.out.println(userInfo);
            
            // 해당 아이디 정보가 있으면
            if (userInfo.size() != 0){
                return true;
            }else {
                return false;
            }
        } catch (Exception e){
            System.out.println(e);
            return false;
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
    
    // 자유게시판에 자신이 작성한 글의 리스트를 가져오기 (view.html)
    @GetMapping("/freeboard/contentlist/{nickname}")
    public List<freeBoardModel> getMyFreeBoardContentList(@PathVariable("nickname") String user_nickname) throws Exception{
        try {
            List<freeBoardModel> myFreeBoardContentList = service.getMyFreeBoardContentList(user_nickname);
            System.out.println("자유게시판에 등록된 자신의 글을 가져오는데 성공하였습니다.");
            return myFreeBoardContentList;
            
        } catch (Exception e){
            System.out.println("자유게시판에 등록된 자신의 글을 가져오는데 실패하였습니다.");
            System.out.println(e);
            return null;
        }
    }
}
