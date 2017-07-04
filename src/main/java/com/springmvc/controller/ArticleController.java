package com.springmvc.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPObject;
import com.springmvc.controller.utils.Base64;
import com.springmvc.controller.utils.DESUtil;
import com.springmvc.controller.utils.ModelAndJsonUtils;
import com.springmvc.db.model.ArticleModel;
import com.springmvc.db.model.User;
import com.springmvc.db.service.ArticleService;
import com.springmvc.db.service.UserService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller  //告诉DispatcherServlet相关的容器， 这是一个Controller，
@RequestMapping(value = "/article")  //类级别的RequestMapping，告诉DispatcherServlet由这个类负责处理以及URL。HandlerMapping依靠这个标签来工作
public class ArticleController {

    private Logger logger  = LogManager.getLogger(ArticleController.class);

    @Autowired
    private ArticleService articleService;

    @Autowired
    private UserService userService;

    /**
     * 主页
     */
    @RequestMapping(value = "/showHomePage", method = RequestMethod.GET)
    public ModelAndView showHomePage(HttpServletRequest request) {
//        return "index";
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("index");
        return modelAndView;
    }

    /**
     * 得到所有的文章列表*****暂时没用到
     */
    @RequestMapping(value = "/getArticleList", method = RequestMethod.GET)
    @ResponseBody
    public String getArticleList() {
        ArrayList<ArticleModel> articleModels = (ArrayList<ArticleModel>) articleService.getArticleAll();
        if (articleModels == null || articleModels.size() <= 0) {
            return "";
        }
        return ModelAndJsonUtils.ModelToJsonWithBase64(articleModels);
    }

    /**
     * 我的主页
     */
    @RequestMapping(value = "/showMyHome", method = RequestMethod.GET)
    public ModelAndView showMyHome() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("myhome");
        return modelAndView;
    }

    /**
     * 通过userid得到所有的文章列表
     */
    @RequestMapping(value = "/getArticleListByUserid", method = RequestMethod.GET)
    @ResponseBody
    public String getArticleListByUserid(HttpServletRequest request) {
        String userid = "";
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if ("userid".equals(cookie.getName())){
                userid = cookie.getValue();
            }
        }
        if(userid == null || userid.equals("")){
            return "";
        }
        ArrayList<ArticleModel> articleModels = (ArrayList<ArticleModel>) articleService.getArticleByuserid(userid);
        if (articleModels == null || articleModels.size() <= 0) {
            return "";
        }
        return ModelAndJsonUtils.ModelToJsonWithBase64(articleModels);
    }

    /**
     * 得到文章的数量
     */
    @RequestMapping(value = "/getPageNumCount", method = RequestMethod.GET)
    @ResponseBody
    public String getPageNumCount() {
        return String.valueOf(articleService.getPageCount());
    }

    /**
     * 根据页数获取数据
     */
    @RequestMapping(value = "/getPageNumData", method = RequestMethod.GET)
    @ResponseBody
    public String getPageNumData(int pageNum, int totalCount) {
//        int endNum = totalCount - (pageNum - 1) * 10 - 1;
//        int startNum = endNum - 9 >= 0 ? (endNum - 9) : 0;
//        Map<String, Integer> map = new HashMap<String, Integer>();
//        map.put("startNum", startNum);
//        map.put("endNum", endNum);
        int startNum = 0;
        int size = 10;
        if (totalCount > 10) {
            startNum = totalCount - pageNum * 10;
            if(startNum < 0){
                size =  10 + startNum;
                startNum = 0;
            }
        }
        Map<String, Integer> map = new HashMap<String, Integer>();
        map.put("startNum", startNum);
        map.put("size", size);
        List<ArticleModel> articleModels = articleService.getPageNumData(map);
        if (articleModels == null || articleModels.size() <= 0) {
            return "fail";
        }
        Collections.reverse(articleModels);// 倒序排列
        return ModelAndJsonUtils.ModelToJsonWithBase64(articleModels);
    }

    /**
     * 展示详情页
     */
    @RequestMapping(value = "/showDetails", method = RequestMethod.GET)
    public ModelAndView showDetails(String id) {
        ArticleModel articleModel = articleService.getArticleById(Integer.valueOf(id));
        ModelAndView modelAndView = new ModelAndView();
        if (articleModel == null) {
            modelAndView.setViewName("404");
        } else {
            modelAndView.setViewName("detailsPage");
            modelAndView.addObject("articleModel", articleModel);
        }
        return modelAndView;
    }

    /**
     * 编辑文章,新建文章
     */
    @RequestMapping(value = "/editPage", method = RequestMethod.GET)
    public ModelAndView editPage(String id) {
        ModelAndView modelAndView = new ModelAndView();
        if (id != null && !id.equals("") && !id.equals("-1")) {
            ArticleModel articleModel = articleService.getArticleById(Integer.valueOf(id));
            if (articleModel == null) {
                modelAndView.setViewName("404");
            } else {
                modelAndView.addObject("articleModel", articleModel);
                modelAndView.setViewName("edit_page");
            }
        } else {
            modelAndView.setViewName("create_page");
        }
        return modelAndView;
    }

    /**
     * 插入一篇文章
     */
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    public String insert(HttpServletRequest req) {
//        ModelAndView modelAndView = new ModelAndView();
        //取得表单数据
        ArticleModel articleModel = new ArticleModel();
        String username = req.getParameter("username");
        String userid = req.getParameter("userid");
        String title = req.getParameter("title");
        String des = req.getParameter("des");
        String content = req.getParameter("content");
        String isPrivate = req.getParameter("isPrivate");


        articleModel.setArticle_id(String.valueOf(System.currentTimeMillis()));
        articleModel.setUserid(userid);
        articleModel.setUsername(username);
        articleModel.setTitle(title);
        articleModel.setDescribes(des);
        articleModel.setContent(content);
        articleModel.setIs_private(isPrivate);

        String callJson = "";
        if (userid == null || userid.equals("")) {
            callJson = "{\"code\":\"1\",\"msg\":\"请登录\"}";
            return Base64.encode(callJson);
        } else {
            User user = userService.getUserByUserId(userid);
            if (user == null || user.getId() <= 0) {
                callJson = "{\"code\":\"1\",\"msg\":\"请先注册\"}";
                return Base64.encode(callJson);
            }
        }

        int row = articleService.insertOne(articleModel);
        if (row <= 0) {
            callJson = "{\"code\":\"1\",\"msg\":\"提交失败\"}";
            return Base64.encode(callJson);
        }
        ArticleModel articleModel1 = articleService.getArticleLast();
        if (articleModel1 == null) {
            callJson = "{\"code\":\"1\",\"msg\":\"获取数据失败\"}";
            return Base64.encode(callJson);
        }

        callJson = "{\"code\":\"0\",\"msg\":\"" + articleModel1.getId() + "\"}";
        return Base64.encode(callJson);
    }

    /**
     * 更新文章
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(HttpServletRequest req) {
        //取得表单数据
        ArticleModel articleModel = new ArticleModel();
        String userid = req.getParameter("userid");
        String id = req.getParameter("id");
        String title = req.getParameter("title");
        String des = req.getParameter("des");
        String content = req.getParameter("content");
        String isPrivate = req.getParameter("isPrivate");

        String callJson = "";

        articleModel.setArticle_id(String.valueOf(System.currentTimeMillis()));
        articleModel.setUserid(userid);
        articleModel.setTitle(title);
        articleModel.setDescribes(des);
        articleModel.setContent(content);
        articleModel.setIs_private(isPrivate);
        if (id != null && !id.equals("")) {
            articleModel.setId(Integer.valueOf(id));
            int row = articleService.updateOne(articleModel);
            if (row <= 0) {
                callJson = "{\"code\":\"1\",\"msg\":\"用户信息不正确\"}";
                return Base64.encode(callJson);
            }
        } else {
            int row = articleService.insertOne(articleModel);
            if (row <= 0) {
                callJson = "{\"code\":\"1\",\"msg\":\"提交失败\"}";
                return Base64.encode(callJson);
            }
        }
        callJson = "{\"code\":\"0\",\"msg\":\"" + articleModel.getId() + "\"}";
        return Base64.encode(callJson);
    }


    /**
     * 更新状态
     */
    @RequestMapping(value = "/updatePrivate", method = RequestMethod.GET)
    @ResponseBody
    public String updateIsPrivate(String param) {
        if(param == null || param.equals("")){
            return "fail";
        }
        param = Base64.decode(param);

        JSONObject jsonObject = JSONArray.parseObject(param);
        String userid = jsonObject.getString("userid");
        String id = jsonObject.getString("id");
        String isPrivate = jsonObject.getString("isPrivate");

        if(userid == null || userid.equals("")){
            return "fail";
        }
        if(id == null || id.equals("")){
            return "fail";
        }
        if(isPrivate == null || isPrivate.equals("")){
            return "fail";
        }
        ArticleModel articleModel = new ArticleModel();
        articleModel.setUserid(userid);
        articleModel.setId(Integer.valueOf(id));
        articleModel.setIs_private(isPrivate);

        int row = articleService.updateChangeIsPrivate(articleModel);
        if (row <= 0) {
            return "fail";
        }

        return "success";
    }


}
