package com.hqyj.zsj.mapper;

import com.hqyj.zsj.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    //登录查验
    User selectUserByUsername(String username);
    //用户注册
    Integer register(User user);
    //用户列表
    List<User> userList(@Param("username") String username, @Param("userState") Integer userState);
    //修改用户状态
    Integer changeUserState(@Param("userState") Integer userState, @Param("userName") String userName);
    //根据用户名删除用户
    Integer deleteUserByUserName(String userName);
    //根据用户名修改用户信息
    Integer updateUserByUserName(User user);

    Integer addUser(User user);

    User checkUserName(String userName);
}
