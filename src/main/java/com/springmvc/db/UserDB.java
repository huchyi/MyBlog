package com.springmvc.db;

import com.springmvc.db.model.ArticleModel;
import com.springmvc.db.model.User;
import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public class UserDB {
    public static UserDB userDB;

    public static UserDB getInstence() {
        if (userDB == null) {
            userDB = new UserDB();
        }
        return userDB;
    }

    public User login(Map<String, String> map) {
        String statement = "mapping.userMapper.userLogin";//映射sql的标识字符串
        //执行查询返回一个唯一user对象的sql
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        User user1 = sqlSession.selectOne(statement, map);
        sqlSession.close();

        ObjectMapper mapper = new ObjectMapper();
        //User类转JSON
        String json = null;
        try {
            json = mapper.writeValueAsString(user1);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(json);

        return user1;
    }

    public boolean register(Map<String, String> map) {
        String statement = "mapping.userMapper.addUser";//映射sql的标识字符串
        //执行查询返回一个唯一user对象的sql
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        int row =sqlSession.insert(statement, map);
        sqlSession.commit();
        sqlSession.close();
        return row > 0;
    }

    public User getUserByUserId(String userid){
        String statement = "mapping.userMapper.judgeUser";//映射sql的标识字符串
        //执行查询返回一个唯一user对象的sql
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        User user1 = sqlSession.selectOne(statement, userid);
        sqlSession.close();
        return user1;
    }


}
