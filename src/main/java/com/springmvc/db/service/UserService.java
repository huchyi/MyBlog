package com.springmvc.db.service;

import com.springmvc.db.model.User;

import java.util.Map;

public interface UserService {

    User login(Map<String, String> map);

    boolean register(Map<String, String> map);

    User getUserByUserId(String userid);

    boolean isLogin(String userid);

    void loginOut(String userid);

    User isRegister(Map<String, String> map);

}
