package com.hqyj.zsj.mapper;

import com.hqyj.zsj.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    User selectUserByUsername(String username);
    Integer register(User user);
    List<User> userList(@Param("username") String username, @Param("userState") Integer userState);
    Integer changeUserState(@Param("userState") Integer userState, @Param("userName") String userName);
}
