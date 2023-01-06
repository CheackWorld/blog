package com.hqyj.zsj.mapper;

import com.hqyj.zsj.pojo.Blog;

import java.util.List;

public interface BlogMapper {
    List<Blog> selectAllBlog(String username);
}
