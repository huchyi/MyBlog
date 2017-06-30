package com.springmvc;

import com.springmvc.db.model.User;
import com.springmvc.db.service.UserService;
import com.springmvc.redis.service.UserRedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class MainTest {

    @Autowired
    private static UserRedisService userRedisService;


    public static void main(String[] args) throws IOException {
        //***********************************redis
//        OrderDaoTest orderDaoTest = new OrderDaoTest();
//        orderDaoTest.orderDaoTest();


        //***********************************db
//        Map<String,String> map = new HashMap<String, String>();
//        map.put("userid","123");
//        map.put("userphone","13312345678");
//        map.put("email","123@gmail.com");
//        map.put("psw", "123");
//        userService.login(map);
    }
}
