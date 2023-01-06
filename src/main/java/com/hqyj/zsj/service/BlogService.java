package com.hqyj.zsj.service;

import com.hqyj.zsj.utils.ResultInfo;

public interface BlogService {
    ResultInfo selectAllBlog(Integer page, Integer size,String username);
}
