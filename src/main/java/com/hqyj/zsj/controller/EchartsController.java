package com.hqyj.zsj.controller;

import com.hqyj.zsj.mapper.BlogMapper;
import com.hqyj.zsj.pojo.Blog;
import com.hqyj.zsj.pojo.BlogType;
import com.hqyj.zsj.service.BlogService;
import com.hqyj.zsj.utils.ResultInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
@RequestMapping("/echarts")
public class EchartsController {
    @Autowired
    private BlogService blogService;

    @RequestMapping("/line")
    public ResultInfo line(){
        List<String> stringList = new ArrayList<>();
        stringList.add("星期一");
        stringList.add("星期二");
        stringList.add("星期三");
        List<Integer> integerList = new ArrayList<>();
        integerList.add(100);
        integerList.add(200);
        integerList.add(150);
        Map<String,Object> map = new HashMap<>();
        map.put("stringList",stringList);
        map.put("integerList",integerList);
        return new ResultInfo(200,"line",map);
    }

    @RequestMapping("/pie")
    public ResultInfo pie(){


        //        List<Map<String, Object>> dataList = new ArrayList<>();
//        for (int i = 0; i < 3; i++) {
//            Map<String, Object> oneMap = new HashMap<>();
//            oneMap.put("value",i + 100);
//            oneMap.put("name","hello" + i);
//            dataList.add(oneMap);
//        }
//        return new ResultInfo(200,"饼图",dataList);
        return blogService.selectBlogType();
    }
}
