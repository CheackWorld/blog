package com.hqyj.zsj.utils;

import com.hqyj.zsj.mapper.BlogMapper;
import com.hqyj.zsj.pojo.Blog;
import com.hqyj.zsj.service.BlogService;
import org.apache.shiro.crypto.hash.SimpleHash;

import java.util.List;

public class MD5Util {
    public static String md5(String username, String password) {
        // username作为密码加密的盐
        // password作为加密的元数据
        /*
         * 参数：加密算法名字、加密的元数据、加密的盐、加密迭代的次数
         * */
        return new SimpleHash("MD5", password, username, 1024).toString();
    }

    public static void main(String[] args) {
        System.out.println(md5("lisi", "123456789"));

    }
}
