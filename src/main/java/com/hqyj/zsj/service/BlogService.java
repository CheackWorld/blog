package com.hqyj.zsj.service;

import com.hqyj.zsj.pojo.Article;
import com.hqyj.zsj.pojo.Blog;
import com.hqyj.zsj.utils.ResultInfo;

public interface BlogService {
    ResultInfo blogList(Integer page, Integer size,String blogTitle,Integer blogState);
    ResultInfo changeBlogState(Integer blogState,String blogTitle,String userName);
    ResultInfo updateBlog(String blogTitle,String blogType,String userName);
    ResultInfo deleteBlog(String blogTitle,String userName);
    ResultInfo selectBlogType();
    ResultInfo addBlog(Article article);
    ResultInfo myBlogList(Integer page, Integer size,Integer blogState,String userName);
}
