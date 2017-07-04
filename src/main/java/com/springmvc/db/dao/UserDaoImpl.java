package com.springmvc.db.dao;

import com.springmvc.db.mapper.UserMapper;
import com.springmvc.db.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao{

    @Autowired
    private UserMapper userMapper;

    public User login(Map<String, String> map) {
        return userMapper.login(map);
    }

    public boolean register(Map<String, String> map) {
        return userMapper.register(map);
    }

    public User getUserByUserId(String userid) {
        return userMapper.getUserByUserId(userid);
    }

    @Override
    public User isRegister(Map<String, String> map) {
        return userMapper.isRegister(map);
    }

}
