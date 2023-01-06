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

    @GetMapping("selectAllBlog")
    public ResultInfo selectAllBlog(Integer page,Integer size,String username){
        return blogService.selectAllBlog(page, size,username);
    }
}
