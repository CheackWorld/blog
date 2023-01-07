package com.hqyj.zsj.service;

import com.hqyj.zsj.utils.ResultInfo;

public interface BlogService {
    ResultInfo blogList(Integer page, Integer size,String blogTitle,Integer blogState);
}
