package com.springmvc.db;

import com.springmvc.db.model.ArticleModel;

import java.util.List;

public interface ArticleService extends IService<ArticleModel> {

    /**
     * 根据条件分页查询
     *
     * @param country
     * @param page
     * @param rows
     * @return
     */
    List<ArticleModel> selectByCountry(ArticleModel country, int page, int rows);

}
