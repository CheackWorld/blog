package com.hqyj.zsj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.zsj.mapper.BlogMapper;
import com.hqyj.zsj.pojo.Blog;
import com.hqyj.zsj.service.BlogService;
import com.hqyj.zsj.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BlogServiceImpl implements BlogService {
    @Autowired
    private BlogMapper blogMapper;

    @Override
    public ResultInfo blogList(Integer page, Integer size,String blogTitle,Integer blogState) {
        // 开启分页
        PageHelper.startPage(page,size);
        // 执行查询
        List<Blog> blogList =  blogMapper.blogList(blogState,blogTitle);
        System.out.println(blogList);
        // 把userList封装在pageInfo对象中
        PageInfo<Blog> articlePageInfo = new PageInfo<>(blogList);
        return new ResultInfo(200,"博客列表",articlePageInfo);
    }
}
