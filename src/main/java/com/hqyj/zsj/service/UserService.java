package com.hqyj.zsj.service;

import com.hqyj.zsj.pojo.User;
import com.hqyj.zsj.utils.ResultInfo;

public interface UserService {
    ResultInfo login(String userName,String password);
    ResultInfo register(User user);
    ResultInfo userList(Integer page, Integer size,String username,Integer userState);

}
