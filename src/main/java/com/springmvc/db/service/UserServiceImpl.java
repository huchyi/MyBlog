package com.springmvc.db.service;

import com.springmvc.db.dao.UserDao;
import com.springmvc.db.model.User;
import com.springmvc.redis.service.UserRedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserRedisService userRedisService;

    public User login(Map<String, String> map) {
        User user = userRedisService.login(map);
        if (user != null) {
            System.out.println(">>>>>>>>>login  redis:");
            return user;
        }
        System.out.println(">>>>>>>>>login  db:");
        user = userDao.login(map);
        if (user != null) {
            userRedisService.add(user);
            return user;
        }
        return null;
    }


    public boolean register(Map<String, String> map) {
        userRedisService.add(map);
        return userDao.register(map);
    }

    public User getUserByUserId(String userid) {
        return userDao.getUserByUserId(userid);
    }

    @Override
    public boolean isLogin(String userid) {
        User user = userRedisService.getUserByUserId(userid);
        return user != null;
    }

    @Override
    public void loginOut(String userid) {
        userRedisService.loginOut(userid);
    }
}
