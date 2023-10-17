package com.example.web.service;

import com.example.web.mapper.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@org.springframework.stereotype.Service
public class Service {

    @Autowired
    private Mapper mapper;

    public Integer showIndex(){
        return mapper.showIndex();
    }
}
