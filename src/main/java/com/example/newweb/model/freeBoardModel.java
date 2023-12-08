package com.example.newweb.model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class freeBoardModel {
    private int id;
    private String user_nickname;
    private String title;
    private String content;
    private Timestamp created_at;
    private Timestamp updated_at;
}
