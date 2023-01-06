package com.hqyj.zsj.controller;

import com.hqyj.zsj.pojo.User;
import com.hqyj.zsj.service.UserService;
import com.hqyj.zsj.utils.MD5Util;
import com.hqyj.zsj.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;


    /*
     * url：http://localhost:8080/user/login
     * */
    @GetMapping("/login")
    public ResultInfo login(String userName, String password){
        return userService.login(userName,password);
    }
    @PostMapping("/register")
    public ResultInfo register(@RequestBody User user){
        user.setPassword(MD5Util.md5(user.getUserName(),user.getPassword()));
        return userService.register(user);
    }

    @GetMapping("/userList")
    public ResultInfo userList(Integer page,Integer size,String username,Integer userState){
        return userService.userList(page, size, username, userState);
    }

}
