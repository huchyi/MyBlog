package com.springmvc.db.dao;

import com.springmvc.db.mapper.ArticleMapper;
import com.springmvc.db.model.ArticleModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("articleDao")
public class ArticleDaoImpl implements ArticleDao {

    @Autowired
    private ArticleMapper articleMapper;

    public ArticleModel getArticleById(int id) {
        return articleMapper.getArticleById(id);
    }

    public int getPageCount() {
        return articleMapper.getPageCount();
    }

    public List<ArticleModel> getPageNumData(int pageNum) {
        return articleMapper.queryPageNumData(pageNum);
    }

    public List<ArticleModel> getArticleAll() {
        return articleMapper.getArticleAll();
    }

    public List<ArticleModel> getArticleByuserid(String userid) {
        return articleMapper.getArticleByUserid(userid);
    }

    public ArticleModel getArticleLast() {
        return articleMapper.getArticleLast();
    }

    public int insertOne(ArticleModel articleModel) {
        return articleMapper.insertOne(articleModel);
    }

    public int updateOne(ArticleModel articleModel) {
        return articleMapper.updateOne(articleModel);
    }
}
