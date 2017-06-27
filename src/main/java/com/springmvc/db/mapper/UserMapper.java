package com.springmvc.db.mapper;

import com.springmvc.db.model.User;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository(value="userMapper")
public interface UserMapper {

    User login(Map<String, String> map);

    boolean register(Map<String, String> map);

    User getUserByUserId(String userid);
}
