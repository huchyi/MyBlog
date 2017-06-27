package com.springmvc.db.dao;

import com.springmvc.db.model.User;

import java.util.Map;

public interface UserDao {

    User login(Map<String, String> map);

    boolean register(Map<String, String> map);

    User getUserByUserId(String userid);
}
