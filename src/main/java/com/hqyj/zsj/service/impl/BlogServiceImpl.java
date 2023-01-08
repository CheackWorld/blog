package com.hqyj.zsj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.zsj.mapper.BlogMapper;
import com.hqyj.zsj.pojo.Article;
import com.hqyj.zsj.pojo.Blog;
import com.hqyj.zsj.pojo.BlogType;
import com.hqyj.zsj.service.BlogService;
import com.hqyj.zsj.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

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

        // 把blogList封装在pageInfo对象中
        PageInfo<Blog> articlePageInfo = new PageInfo<>(blogList);
        return new ResultInfo(200,"博客列表",articlePageInfo);
    }

    @Override
    public ResultInfo changeBlogState(Integer blogState, String blogTitle, String userName) {
        Integer result = blogMapper.changeBlogState(blogState, blogTitle, userName);
        if (result>0){
            return new ResultInfo(200,"审核成功",null);
        }
        return new ResultInfo(500,"审核失败",null);
    }

    @Override
    public ResultInfo updateBlog(String blogTitle, String blogType, String userName) {
        Integer result = blogMapper.updateBlog(blogTitle, blogType, userName);
        if (result>0){
            return new ResultInfo(200,"修改成功",null);
        }
        return new ResultInfo(500,"修改失败",null);
    }

    @Override
    public ResultInfo deleteBlog(String blogTitle, String userName) {
        Integer result = blogMapper.deleteBlog(blogTitle, userName);
        System.out.println(blogTitle+"==="+userName);
        if(result>0){
            return new ResultInfo(200,"删除成功",null);
        }
        return new ResultInfo(500,"删除失败",null);
    }

    @Override
    public ResultInfo selectBlogType() {
        List<BlogType> list=blogMapper.selectBlogType();
        List<Map<String, Object>> dataList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> oneMap = new HashMap<>();
            oneMap.put("value",list.get(i).getNum());
            oneMap.put("name",list.get(i).getBlogType());
            dataList.add(oneMap);
        }
        System.out.println(dataList);
        return new ResultInfo(200,"博客列表",dataList);
    }

    @Override
    public ResultInfo addBlog(Article article) {
        Integer result = blogMapper.addBlog(article);
        if (result>0){
            return new ResultInfo(200,"添加成功",null);
        }
        return new ResultInfo(500,"添加失败",null);
    }

    @Override
    public ResultInfo myBlogList(Integer page, Integer size,Integer blogState, String userName) {
        // 开启分页
        PageHelper.startPage(page,size);
        List<Blog> list = blogMapper.myBlogList(blogState, userName);
        PageInfo<Blog> pageInfo = new PageInfo<>(list);
        return new ResultInfo(200,"我的博客列表",pageInfo);
    }
}
