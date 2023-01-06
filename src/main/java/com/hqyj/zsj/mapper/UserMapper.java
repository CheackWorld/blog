package com.hqyj.zsj.mapper;

import com.hqyj.zsj.pojo.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    User selectUserByUsername(String username);
    Integer registerUser(String username, String email,String password);
}
