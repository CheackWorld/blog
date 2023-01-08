package com.hqyj.zsj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.zsj.mapper.UserMapper;
import com.hqyj.zsj.pojo.User;
import com.hqyj.zsj.service.UserService;
import com.hqyj.zsj.utils.ResultInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
            // 把token扔给shiro中的login方法，执行登录，如果账号不存在或者密码不正确都会抛出异常，我们这里通过try catch来捕获处理
            try {
                subject.login(token);
                User loginUser = (User) subject.getSession().getAttribute("loginUser");

                return new ResultInfo(200,"登录成功",loginUser);
            }catch (UnknownAccountException unknownAccountException){ // 用户不存在异常
                return new ResultInfo(-1,"账户不存在",userName);
            }catch (IncorrectCredentialsException incorrectCredentialsException){ // 密码不正确异常
                return new ResultInfo(-2,"密码不匹配");
            }catch (Exception e){ // 其他异常
                return new ResultInfo(-3,"其他异常");
            }
        }
        // 登录了的情况
        User loginUser = (User) subject.getSession().getAttribute("loginUser");
        String headPic = loginUser.getHeadPic();
        return new ResultInfo(-4,"当前用户已经登录了",headPic);
    }

    @Override
    public ResultInfo register(User user) {
        Integer result=userMapper.register(user);
        if (result>0){
            return new ResultInfo(200,"注册成功",null);
        }
        return new ResultInfo(500,"注册失败",null);
    }

    @Override
    public ResultInfo userList(Integer page, Integer size, String username, Integer userState) {
        // 开启分页
        PageHelper.startPage(page,size);
        // 执行查询
        List<User> userList =  userMapper.userList(username,userState);
        // 把userList封装在pageInfo对象中
        PageInfo<User> userPageInfo = new PageInfo<>(userList);
        return new ResultInfo(200,"用户列表",userPageInfo);
    }

    @Override
    public ResultInfo changeUserState(Integer userState,String userName ) {
        Integer result = userMapper.changeUserState(userState, userName);
        if (result>0){
            return new ResultInfo(200,"禁用成功",null);
        }
        return new ResultInfo(500,"禁用失败",null);
    }

    //根据用户名删除用户信息
    @Override
    public ResultInfo deleteUserByUserName(String userName) {
        Integer result = userMapper.deleteUserByUserName(userName);
        if (result>0){
            return new ResultInfo(200,"删除成功",null);
        }
        return new ResultInfo(500,"删除失败",null);
    }

    //根据用户名修改用户信息
    @Override
    public ResultInfo updateUserByUserName(User user) {
        Integer result = userMapper.updateUserByUserName(user);
        if (result>0){
            return new ResultInfo(200,"修改成功");
        }
        return new ResultInfo(500,"修改失败");
    }

    @Override
    public ResultInfo addUser(User user) {
        Integer result=userMapper.addUser(user);
        if (result>0){
            return new ResultInfo(200,"添加成功",null);
        }
        return new ResultInfo(500,"添加失败",null);
    }

    @Override
    public ResultInfo checkUserName(String userName) {
        User user = userMapper.checkUserName(userName);
        if (user != null)
            return new ResultInfo(500,"用户存在");
        return new ResultInfo(200,"用户不存在");
    }

}
