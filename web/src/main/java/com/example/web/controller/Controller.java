package com.example.web.controller;

import com.example.web.model.testModel;
import com.example.web.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
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
        testModel testModel = new testModel();
        testModel.setN(service.showIndex());
        System.out.print(testModel);
        return "test2";
    }
}
