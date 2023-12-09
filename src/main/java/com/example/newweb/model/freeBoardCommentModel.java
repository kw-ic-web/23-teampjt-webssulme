package com.example.newweb.model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class freeBoardCommentModel {
    private int id;
    private int free_board_id;
    private String user_nickname;
    private int comment_class;
    private int parent_id;
    private String content;
    private Timestamp created_at;
    private Timestamp updated_at;
}
