package com.springmvc.db.service;

import com.springmvc.db.dao.UserDao;
import com.springmvc.db.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    public User login(Map<String, String> map) {
        return userDao.login(map);
    }

    public boolean register(Map<String, String> map) {
        return userDao.register(map);
    }

    public User getUserByUserId(String userid) {
        return userDao.getUserByUserId(userid);
    }
}
