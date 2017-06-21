package com.springmvc.db.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="article")
public class ArticleModel {
    @Id
    public int id;

    @Column
    public int article_id;
    public String userid;
    public String username;
    public String title;
    public String describes;
    public String content;
    public String img_url;
    public String create_time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getArticle_id() {
        return article_id;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescribes() {
        return describes;
    }

    public void setDescribes(String describes) {
        this.describes = describes;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }

    public String getCreate_time() {
        return create_time;
    }

    public void setCreate_time(String create_time) {
        this.create_time = create_time;
    }

    public void addAllData(ArticleModel articleModel){
        setArticle_id(articleModel.getArticle_id());
        setTitle(articleModel.getTitle());
        setDescribes(articleModel.getDescribes());
        setContent(articleModel.getContent());
        setImg_url(articleModel.getImg_url());
        setCreate_time(articleModel.getCreate_time());
    }
}
