package com.hqyj.zsj.service.impl;

import com.hqyj.zsj.mapper.UserMapper;
import com.hqyj.zsj.service.UserService;
import com.hqyj.zsj.utils.MD5Util;
import com.hqyj.zsj.utils.ResultInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public ResultInfo login(String userName, String password) {
        // subject：shiro的主体，也就是当前登录的对象
        Subject subject = SecurityUtils.getSubject();
        // 判断当前用户是否登录了
        if (!subject.isAuthenticated()) { // isAuthenticated方法：判断用户是否登录，登录了返回true，没登录返回false
            // 未登录的情况
            // 通过当前登录用户的账号和密码，创建出来一个token，token中就包含了当前用户登录信息
            AuthenticationToken token = new UsernamePasswordToken(userName, password);
            System.out.println(userName);
            System.out.println(password);
            // 把token扔给shiro中的login方法，执行登录，如果账号不存在或者密码不正确都会抛出异常，我们这里通过try catch来捕获处理
            try {
                subject.login(token);
                return new ResultInfo(200,"登录成功",userName);
            }catch (UnknownAccountException unknownAccountException){ // 用户不存在异常
                return new ResultInfo(-1,"账户不存在",userName);
            }catch (IncorrectCredentialsException incorrectCredentialsException){ // 密码不正确异常
                return new ResultInfo(-2,"密码不匹配");
            }catch (Exception e){ // 其他异常
                return new ResultInfo(-3,"其他异常");
            }
        }
        // 登录了的情况
        return new ResultInfo(-4,"当前用户已经登录了",userName);
    }

    @Override
    public ResultInfo register(String username, String email, String password) {

        Integer result=userMapper.registerUser(username, email, MD5Util.md5(username,password));
        System.out.println(username+"==="+email+"==="+ MD5Util.md5(username,password));
        if (result>0){
            return new ResultInfo(200,"注册成功",null);
        }
        return new ResultInfo(500,"注册失败",null);
    }
}
