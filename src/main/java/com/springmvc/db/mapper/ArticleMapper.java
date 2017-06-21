package com.springmvc.db.mapper;

import com.springmvc.db.model.ArticleModel;
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;

public interface  ArticleMapper extends Mapper<ArticleModel>, MySqlMapper<ArticleModel> {


}
