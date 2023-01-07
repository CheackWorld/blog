package com.hqyj.zsj.controller;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class SystemController {
    // 没有登录访问的页面
    @GetMapping("/login")
    public String login(){
        return "login";
    }

    // 退出登录
    @GetMapping("/logout")
    public String logout(){
        // 清空一下shiro
        SecurityUtils.getSubject().logout();
        return "login";
    }
    //去后台
    @GetMapping("/goBackstageIndex")
    public String goBackstageIndex(){
        return "backstageIndex";
    }
    //去后台
    @GetMapping("/backstageIndex")
    public String backstageIndex(){
        return "backstageIndex";
    }

    @GetMapping("/index")
    public String index(){
        return "index";
    }
    //注册
    @GetMapping("/register")
    public String register(){
        return "index";
    }
    // userList
    @GetMapping("/userList")
    public String userList(){
        return "user-list";
    }
    // blackList
    @GetMapping("blackList")
    public String blackList(){
        return "black-list";
    }
    //blogList
    @GetMapping("blogList")
    public String blogList(){
        return "blog-list";
    }
    //blogBlackList
    @GetMapping("downBlogList")
    public String blogBlackList(){
        return "downBlog-list";
    }
    //blogMessageList
    @GetMapping("blogMessageList")
    public String blogMessageList(){
        return "blogMessage-list";
    }
    // welcome
    @GetMapping("/welcome")
    public String welcome(){
        return "welcome";
    }
}
