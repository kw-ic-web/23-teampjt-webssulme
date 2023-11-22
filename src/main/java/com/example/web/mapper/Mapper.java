package com.example.web.mapper;

import java.util.List;

@org.apache.ibatis.annotations.Mapper
public interface Mapper {
    public Integer showIndex();

    // 입력받은 nickname과 DB를 비교하여 같은 것이 있으면 true 반환, 아니면 false 반환
    public String getLoginIdList(String nickname);

    // 사용자 정보 DB에 저장
    public boolean insertUser(String nickname, String pw);
}
