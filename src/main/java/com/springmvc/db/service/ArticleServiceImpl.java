package com.springmvc.db.service;

import com.springmvc.db.dao.ArticleDao;
import com.springmvc.db.model.ArticleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("articleService")
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleDao articleDao;

    public ArticleModel getArticleById(int id) {
        return articleDao.getArticleById(id);
    }

    public int getPageCount() {
        return articleDao.getPageCount();
    }

    public List<ArticleModel> getPageNumData(int pageNum) {
        return articleDao.getPageNumData(pageNum);
    }

    public List<ArticleModel> getArticleAll() {
        return articleDao.getArticleAll();
    }

    public List<ArticleModel> getArticleByuserid(String userid) {
        return articleDao.getArticleByuserid(userid);
    }

    public ArticleModel getArticleLast() {
        return articleDao.getArticleLast();
    }

    public int insertOne(ArticleModel articleModel) {
        return articleDao.insertOne(articleModel);
    }

    public int updateOne(ArticleModel articleModel) {
        return articleDao.updateOne(articleModel);
    }
}

