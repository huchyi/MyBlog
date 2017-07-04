package com.springmvc.db.dao;

import com.springmvc.db.model.ArticleModel;

import java.util.List;
import java.util.Map;

public interface ArticleDao {

    ArticleModel getArticleById(int id);

    int getPageCount();

    List<ArticleModel> getPageNumData(Map<String,Integer> map);

    List<ArticleModel> getArticleAll();

    List<ArticleModel> getArticleByuserid(String userid);

    ArticleModel getArticleLast();

    int insertOne(ArticleModel articleModel);

    int updateOne(ArticleModel articleModel);

    int updateChangeIsPrivate(ArticleModel articleModel);

    void updateReadTimes(int id);

}
