package com.example.web.service;

import com.example.web.mapper.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

@org.springframework.stereotype.Service
public class Service {

    @Autowired
    private Mapper mapper;

    public String getLoginIdList(String nickname){
        return mapper.getLoginIdList(nickname);
    }

    public boolean insertUser(String nickname, String pw){
        if (mapper.insertUser(nickname, pw))
            return true;
        return false;
    }
}
