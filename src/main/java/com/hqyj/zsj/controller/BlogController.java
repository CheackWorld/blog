package com.hqyj.zsj.controller;
import com.hqyj.zsj.service.BlogService;
import com.hqyj.zsj.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/blog")
public class BlogController {
    @Autowired
    private BlogService blogService;


    /*
     * url：http://localhost:8080/article/selectArticleByName
     * */

    @GetMapping("blogList")
    public ResultInfo blogList(Integer page,Integer size,Integer blogState,String blogTitle){
        return blogService.blogList(page, size,blogTitle,blogState);
    }

}
