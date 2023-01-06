package com.hqyj.zsj.shiro;

import com.hqyj.zsj.mapper.UserMapper;
import com.hqyj.zsj.pojo.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

public class MyRealm extends AuthorizingRealm {
    @Autowired
    private UserMapper userMapper;
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        // 在shiro的session取出user信息
        User loginUser = (User) SecurityUtils.getSubject().getSession().getAttribute("loginUser");
        String roleName = loginUser.getRole().getRoleName();
        // 创建一个AuthorizationInfo的对象
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        // 设置角色
        info.addRole(roleName);
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // 1、拿到token中的用户名
        String username = (String) authenticationToken.getPrincipal();
        // 2、通过token中拿到的用户名，查询数据库
        User user = userMapper.selectUserByUsername(username);
        // 把当前用户存入shiro的session
        SecurityUtils.getSubject().getSession().setAttribute("loginUser",user);
        // 3、判断用户是否为null
        if (user == null)
            throw new UnknownAccountException(); // 用户不存在，抛出异常
        // 4、用户存在  参数：当前账户，查询出来的密码，（盐），当前realm
        ByteSource salt = ByteSource.Util.bytes(username); // 得到盐
        return new SimpleAuthenticationInfo(username,user.getPassword(),salt,getName());
    }
}
