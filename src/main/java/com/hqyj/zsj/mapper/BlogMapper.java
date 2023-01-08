package com.hqyj.zsj.mapper;

import com.hqyj.zsj.pojo.Article;
import com.hqyj.zsj.pojo.Blog;
import com.hqyj.zsj.pojo.BlogType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BlogMapper {
    List<Blog> blogList(@Param("blogState")Integer blogState,@Param("blogTitle") String blogTitle);
    Integer changeBlogState(@Param("blogState") Integer blogState,@Param("blogTitle") String blogTitle,@Param("userName") String userName);
    Integer updateBlog(@Param("blogTitle") String blogTitle,@Param("blogType") String blogType,@Param("userName") String userName);
    Integer deleteBlog(@Param("blogTitle") String blogTitle,@Param("userName") String userName);
    List<BlogType> selectBlogType();
    Integer addBlog(Article article);
    List<Blog> myBlogList(@Param("blogState")Integer blogState,@Param("userName") String userName);
}
