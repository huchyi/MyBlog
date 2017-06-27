package com.springmvc.db.mapper;

import com.springmvc.db.model.ArticleModel;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;

import java.util.List;
import java.util.Map;

@Repository(value="articleMapper")
public interface  ArticleMapper{
    ArticleModel getArticleById(int id);

    int getPageCount();

    List<ArticleModel> queryPageNumData(Map<String,Integer> map);

    List<ArticleModel> getArticleAll();

    List<ArticleModel> getArticleByUserid(String userid);

    ArticleModel getArticleLast();

    int insertOne(ArticleModel articleModel);

    int updateOne(ArticleModel articleModel);
}
