package com.hqyj.zsj.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Blog {
    private Integer blogId;
    private String blogTitle;
    private String blogTime;
    private String blogContent;
    private String blogType;
    private Integer blogState;
    private User user;
}
