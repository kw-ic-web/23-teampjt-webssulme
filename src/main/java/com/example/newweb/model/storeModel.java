package com.example.newweb.model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class storeModel {
    private int id;
    private String name;
    private String category;
    private String location;
    private String phone_num;
    private String explain;
    private Timestamp created_at;
    private Timestamp updated_at;
}
