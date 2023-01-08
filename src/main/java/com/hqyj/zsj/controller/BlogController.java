package com.hqyj.zsj.controller;
import com.hqyj.zsj.pojo.Article;
import com.hqyj.zsj.pojo.Blog;
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

    @GetMapping("/blogList")
    public ResultInfo blogList(Integer page,Integer size,Integer blogState,String blogTitle){
        return blogService.blogList(page, size,blogTitle,blogState);
    }
    @PutMapping("/changeBlogState/{blogState}/{blogTitle}/{userName}")
    public ResultInfo changeBlogState(@PathVariable("blogState") Integer blogState,
                                      @PathVariable("blogTitle") String blogTitle,
                                      @PathVariable("userName") String userName)
    {
        return blogService.changeBlogState(blogState, blogTitle, userName);
    }
    @DeleteMapping("/deleteBlog/{blogTitle}/{userName}")
    public ResultInfo deleteBlog(@PathVariable("blogTitle") String blogTitle,
                                 @PathVariable("userName") String userName)
    {
        return blogService.deleteBlog(blogTitle, userName);
    }
    @PostMapping("/addBlog")
    public ResultInfo addBlog(@RequestBody Article article){
        return blogService.addBlog(article);
    }
    @GetMapping("/myBlogList")
    public ResultInfo myBlogList(Integer page,Integer size,Integer blogState,String userName){return blogService.myBlogList(page, size, blogState, userName);};

}
