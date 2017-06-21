package com.springmvc.db;

import com.springmvc.db.model.ArticleModel;
import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class ArticleDB {

    public static ArticleDB articleDB;

    public static ArticleDB getInstence() {
        if (articleDB == null) {
            articleDB = new ArticleDB();
        }
        return articleDB;
    }

    public ArticleModel getArticleById(int id) {
        /**
         * 映射sql的标识字符串，
         * me.gacl.mapping.userMapper是userMapper.xml文件中mapper标签的namespace属性的值，
         * getUser是select标签的id属性值，通过select标签的id属性值就可以找到要执行的SQL
         */
        String statement = "mapping.ArticleMapper.getArticleById";//映射sql的标识字符串
        //执行查询返回一个唯一user对象的sql
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        ArticleModel articleModel = sqlSession.selectOne(statement, id);
        sqlSession.close();

        ObjectMapper mapper = new ObjectMapper();
        //User类转JSON
        String json = null;
        try {
            json = mapper.writeValueAsString(articleModel);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(json);

        return articleModel;
    }

    public int getPageCount() {
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        List<ArticleModel> list = sqlSession.selectList("mapping.ArticleMapper.getPageCount");
        sqlSession.close();
        return list.size();
    }

    public List<ArticleModel> getPageNumData(int pageNum) {
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        List<ArticleModel> list = sqlSession.selectList("mapping.ArticleMapper.getPageData", (pageNum - 1) * 10);
        sqlSession.close();
        return list;
    }


    public List<ArticleModel> getArticleAll() {
        /**
         * 映射sql的标识字符串，
         * me.gacl.mapping.userMapper是userMapper.xml文件中mapper标签的namespace属性的值，
         * getUser是select标签的id属性值，通过select标签的id属性值就可以找到要执行的SQL
         */
        String statement = "mapping.ArticleMapper.getArticleAll";//映射sql的标识字符串
        //执行查询返回一个唯一user对象的sql
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        List<ArticleModel> articleModels = sqlSession.selectList(statement);
        sqlSession.close();

        ObjectMapper mapper = new ObjectMapper();
        //User类转JSON
        String json = null;
        try {
            json = mapper.writeValueAsString(articleModels);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(json);

        return articleModels;
    }

    public List<ArticleModel> getArticleByuserid(String userid) {
        String statement = "mapping.ArticleMapper.getArticleByUserid";//映射sql的标识字符串
        //执行查询返回一个唯一user对象的sql
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        List<ArticleModel> articleModels = sqlSession.selectList(statement,userid);
        sqlSession.close();

        ObjectMapper mapper = new ObjectMapper();
        //User类转JSON
        String json = null;
        try {
            json = mapper.writeValueAsString(articleModels);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(json);

        return articleModels;
    }

    public ArticleModel getArticleLast() {

        String statement = "mapping.ArticleMapper.getArticleLast";//映射sql的标识字符串
        //执行查询返回一个唯一user对象的sql
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        ArticleModel articleModel = sqlSession.selectOne(statement);
        sqlSession.close();

        ObjectMapper mapper = new ObjectMapper();
        //User类转JSON
        String json = null;
        try {
            json = mapper.writeValueAsString(articleModel);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(json);

        return articleModel;
    }

    public int insertOne(ArticleModel articleModel) {
        String statement = "mapping.ArticleMapper.insertArticle";//映射sql的标识字符串
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        int row = sqlSession.insert(statement, articleModel);
        sqlSession.commit();
        sqlSession.close();
        System.out.println("row:" + row);
        return row;
    }

    public int updateOne(ArticleModel articleModel) {
        String statement = "mapping.ArticleMapper.updateArticle";//映射sql的标识字符串
        SqlSession sqlSession = DBHelper.getInstance().getSession();
        int row = sqlSession.update(statement, articleModel);
        sqlSession.commit();
        sqlSession.close();
        System.out.println("row:" + row);
        return row;
    }

}
