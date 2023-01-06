package com.hqyj.zsj.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
    private Integer blogId;
    private String blogName;
    private String blogTime;
    private String blogContent;
    private String blogType;
    private User user;
}
