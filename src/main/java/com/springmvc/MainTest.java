package com.springmvc;

import com.springmvc.db.ArticleDB;
import com.springmvc.db.UserDB;
import com.springmvc.db.model.ArticleModel;
import com.springmvc.db.model.User;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class MainTest {
    public static void main(String[] args) throws IOException {
        Map<String,String> map = new HashMap<String, String>();
        map.put("userid","123");
        map.put("userphone","13312345678");
        map.put("email","123@gmail.com");
        map.put("psw", "123");
        UserDB.getInstence().login(map);




//        ArticleDB.getInstence().getArticleById(1);
//        ArticleDB.getInstence().getArticleAll();
//        ArticleDB.getInstence().insertOne(new ArticleModel());

//        ArticleDB.getInstence().getPageNumData(2);
//        ArticleDB.getInstence().getPageCount();

//        ArticleModel articleModel = new ArticleModel();
//        articleModel.setArticle_id(3);
//        articleModel.setTitle("python研发");
//        articleModel.setDescribes("这是描述python研发的内容,这是描述python研发的内容.");
//        articleModel.setContent("这是描述python研发的内容,这是描述python研发的内容,这是描述python研发的内容,这是描述python研发的内容," +
//                "这是描述python研发的内容,这是描述python研发的内容,这是描述python研发的内容,这是描述python研发的内容,这是描述python研发的内容,这" +
//                "是描述python研发的内容,这是描述python研发的内容,这是描述python研发的内容,这是描述python研发的内容,这是描述python研发的内容,这是" +
//                "描述python研发的内容");
//        articleModel.setImg_url("");
//        articleModel.setCreate_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
//
//
//        for (int i = 0; i < 30; i++) {
//            ArticleDB.getInstence().insertOne(articleModel);
//        }


//        ArticleModel articleModel = new ArticleModel();
//        articleModel.setId(206);
//        articleModel.setArticle_id((int) System.currentTimeMillis());
//        articleModel.setTitle("这是描述python");
//        articleModel.setDescribes("这是描述python");
//        articleModel.setContent("这是描述python这是描述python");
//        articleModel.setCreate_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
//        ArticleDB.getInstence().updateOne(articleModel);
    }
}
