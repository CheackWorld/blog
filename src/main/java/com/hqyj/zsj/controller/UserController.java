package com.hqyj.zsj.controller;

import com.hqyj.zsj.service.UserService;
import com.hqyj.zsj.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
    @GetMapping("/register")
    public ResultInfo register(String userName,String email,String password){
        return userService.register(userName, email, password);
    }
}
