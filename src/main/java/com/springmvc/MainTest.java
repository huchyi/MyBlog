package com.springmvc;

import com.springmvc.db.UserDao;
import com.springmvc.db.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class MainTest {

    @Autowired
    private static UserService userService;

    public static void main(String[] args) throws IOException {
        Map<String,String> map = new HashMap<String, String>();
        map.put("userid","123");
        map.put("userphone","13312345678");
        map.put("email","123@gmail.com");
        map.put("psw", "123");
        userService.login(map);
    }
}
