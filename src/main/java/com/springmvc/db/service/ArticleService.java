package com.springmvc.db.service;

import com.springmvc.db.model.ArticleModel;

import java.util.List;


public interface ArticleService {

    ArticleModel getArticleById(int id);

    int getPageCount();

    List<ArticleModel> getPageNumData(int pageNum);

    List<ArticleModel> getArticleAll();

    List<ArticleModel> getArticleByuserid(String userid);

    ArticleModel getArticleLast();

    int insertOne(ArticleModel articleModel);

    int updateOne(ArticleModel articleModel);
}
