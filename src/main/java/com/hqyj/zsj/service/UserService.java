package com.hqyj.zsj.service;

import com.hqyj.zsj.utils.ResultInfo;

public interface UserService {
    ResultInfo login(String userName,String password);
    ResultInfo register(String username,String email,String password);

}
