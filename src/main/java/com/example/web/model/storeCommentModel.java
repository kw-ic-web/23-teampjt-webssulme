package com.example.web.model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class storeCommentModel {
    private int id;
    private String user_nickname;
    private int store_id;
    private float score;
    private String content;
    private int type;
    private int parent_id;
    private Timestamp created_at;
    private Timestamp updated_at;
}
