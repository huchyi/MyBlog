package com.springmvc.db.service;

import com.springmvc.db.dao.ArticleDao;
import com.springmvc.db.model.ArticleModel;
import com.springmvc.redis.service.ArticleRedisService;
import org.apache.log4j.Level;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("articleService")
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleDao articleDao;

    @Autowired
    private ArticleRedisService articleRedisService;

    private Logger logger  = LogManager.getLogger(ArticleServiceImpl.class);

    public ArticleModel getArticleById(int id) {
//        ArticleModel articleModel = articleRedisService.getArticleById(id);
//        if (articleModel != null) {
//            System.out.println(">>>>>>>>>>>>ArticleServiceImpl redis:" + articleModel.getId());
//            return articleModel;
//        }
//        articleModel = articleDao.getArticleById(id);
//        System.out.println(">>>>>>>>>>>>ArticleServiceImpl db:" + articleModel.getId());
//        if (articleModel != null) {
//            articleRedisService.insertOne(articleModel);
//            return articleModel;
//        }
//        return null;
        return articleDao.getArticleById(id);
    }

    public int getPageCount() {
        int size = articleRedisService.getPageCount();
        if (size >= 0) {
            logger.info("getPageCount redis:" + size);
//            System.out.println(">>>>>>>>>>>>ArticleServiceImpl getPageCount redis:" + size);
            return size;
        }
        size = articleDao.getPageCount();
        if (size >= 0) {
            logger.info("getPageCount db:" + size);
//            System.out.println(">>>>>>>>>>>>ArticleServiceImpl getPageCount db:" + size);
            articleRedisService.setPageCount(size);
            return size;
        }
        return 0;
    }

    public List<ArticleModel> getPageNumData(Map<String, Integer> map) {
        return articleDao.getPageNumData(map);
    }

    public List<ArticleModel> getArticleAll() {
        return articleDao.getArticleAll();
    }

    public List<ArticleModel> getArticleByuserid(String userid) {
//        List<ArticleModel> articleModels = articleRedisService.getArticleByuserid(userid);
//        if (articleModels != null && articleModels.size() > 0) {
//            return articleModels;
//        }
//        articleModels = articleDao.getArticleByuserid(userid);
//        if (articleModels != null && articleModels.size() > 0) {
//            articleRedisService.setArticleByuserid(userid, articleModels);
//        }
//        return articleModels;
        return articleDao.getArticleByuserid(userid);
    }

    public ArticleModel getArticleLast() {
        return articleDao.getArticleLast();
    }

    public int insertOne(ArticleModel articleModel) {
        int row = articleDao.insertOne(articleModel);
        if (row > 0) {
            if(articleModel.getId() > 0 ){
//                articleRedisService.insertOne(articleModel);
                int num = articleRedisService.getPageCount();
                if(num > -1){
                    articleRedisService.setPageCount(num + row);
                }
//                articleRedisService.setArticleByuserid(articleModel.getUserid(), null);
            }
        }
        return row;
    }

    public int updateOne(ArticleModel articleModel) {
        int row = articleDao.updateOne(articleModel);
//        if (row > 0) {
//            articleRedisService.updateOne(articleModel);
//            articleRedisService.setArticleByuserid(articleModel.getUserid(), null);
//        }
        return row;
    }

    @Override
    public int updateChangeIsPrivate(ArticleModel articleModel) {
        return articleDao.updateChangeIsPrivate(articleModel);
    }
}

