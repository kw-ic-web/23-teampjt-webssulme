package com.example.web.controller;

import com.example.web.model.testModel;
import com.example.web.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
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

    @ResponseBody
    @GetMapping("/join/idCheck/{nickname}")
    public boolean loginIdCheck(@PathVariable("nickname") String nickname, Model model) throws Exception{
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
}
