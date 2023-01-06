package com.hqyj.zsj.utils;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResultInfo {
    private Integer status;
    private String msg;
    private Object data;

    public ResultInfo(Integer status, String msg) {
        this.status = status;
        this.msg = msg;
    }
}

