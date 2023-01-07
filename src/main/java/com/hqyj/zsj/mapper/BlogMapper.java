package com.hqyj.zsj.mapper;

import com.hqyj.zsj.pojo.Blog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BlogMapper {
    List<Blog> blogList(@Param("blogState")Integer blogState,@Param("blogTitle") String blogTitle);
}
