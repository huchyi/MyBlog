package com.springmvc.db;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.InputStream;

public class DBHelper {

    public static DBHelper dbHelper;
//    private static SqlSession session;
    SqlSessionFactory sessionFactory;

    public DBHelper(){
    }

    public static DBHelper getInstance(){
        if(dbHelper == null){
            dbHelper = new DBHelper();
        }
        return dbHelper;
    }

    public SqlSession getSession(){
        if(sessionFactory == null){
            //mybatis的配置文件
            String resource = "spring-mybatis.xml";
            //使用类加载器加载mybatis的配置文件（它也加载关联的映射文件）
            InputStream is = ArticleDao.class.getClassLoader().getResourceAsStream(resource);
            //构建sqlSession的工厂
            sessionFactory = new SqlSessionFactoryBuilder().build(is);
        }
        //使用MyBatis提供的Resources类加载mybatis的配置文件（它也加载关联的映射文件）
        //Reader reader = Resources.getResourceAsReader(resource);
        //构建sqlSession的工厂
        //SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(reader);
        //创建能执行映射文件中sql的sqlSession
//        session = sessionFactory.openSession();
        return sessionFactory.openSession();
    }
}
