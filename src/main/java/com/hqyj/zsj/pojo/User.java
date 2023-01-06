package com.hqyj.zsj.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Integer userId;
    private String headPic;
    private String userName;
    private String password;
    private String email;
    private Integer userState;
    private Role role;
    public User(String username, String password, String email) {
        this.userName = username;
        this.password = password;
        this.email = email;
    }

}
