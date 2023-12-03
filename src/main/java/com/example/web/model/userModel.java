package com.example.web.model;

import lombok.Data;

import java.sql.RowId;
import java.sql.Timestamp;

@Data
public class userModel {
    private String nickname;
    private String pw;
    private int status;
    private Timestamp inactive_date;
    private Timestamp created_at;
    private Timestamp updated_at;
}
