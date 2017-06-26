package com.springmvc.controller;

import com.springmvc.controller.utils.Base64;
import com.springmvc.controller.utils.DESUtil;
import com.springmvc.controller.utils.ModelAndJsonUtils;
import com.springmvc.db.ArticleDB;
import com.springmvc.db.UserDB;
import com.springmvc.db.model.ArticleModel;
import com.springmvc.db.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller  //告诉DispatcherServlet相关的容器， 这是一个Controller，
@RequestMapping(value = "/article")  //类级别的RequestMapping，告诉DispatcherServlet由这个类负责处理以及URL。HandlerMapping依靠这个标签来工作
public class ArticleController {

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
        ArrayList<ArticleModel> articleModels = (ArrayList<ArticleModel>) ArticleDB.getInstence().getArticleAll();
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
//        return "myhome";
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("myhome");
        return modelAndView;
    }

    /**
     * 通过userid得到所有的文章列表*****暂时没用到
     */
    @RequestMapping(value = "/getArticleListByUserid", method = RequestMethod.GET)
    @ResponseBody
    public String getArticleList(String userid) {
        ArrayList<ArticleModel> articleModels = (ArrayList<ArticleModel>) ArticleDB.getInstence().getArticleByuserid(userid);
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
        return String.valueOf(ArticleDB.getInstence().getPageCount());
    }

    /**
     * 根据页数获取数据
     */
    @RequestMapping(value = "/getPageNumData", method = RequestMethod.GET)
    @ResponseBody
    public String getPageNumData(String pageNum) {

        List<ArticleModel> articleModels = ArticleDB.getInstence().getPageNumData(Integer.valueOf(pageNum));
        if (articleModels == null || articleModels.size() <= 0) {
            return "fail";
        }
        return ModelAndJsonUtils.ModelToJsonWithBase64(articleModels);
    }


    /**
     * 展示详情页
     */
    @RequestMapping(value = "/showDetails", method = RequestMethod.GET)
    public ModelAndView showDetails(String id) {
        System.out.println("============showDetails  id:" + id);
        ArticleModel articleModel = ArticleDB.getInstence().getArticleById(Integer.valueOf(id));
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
        if (id != null && !id.equals("") && !id.equals("0")) {
            ArticleModel articleModel = ArticleDB.getInstence().getArticleById(Integer.valueOf(id));
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
    public ModelAndView insert(HttpServletRequest req) {
        ModelAndView modelAndView = new ModelAndView();
        //取得表单数据
        ArticleModel articleModel = new ArticleModel();

        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String username = req.getParameter("username");
        String userid = req.getParameter("userid");
        String title = req.getParameter("title");
        String des = req.getParameter("des");
        String content = req.getParameter("content");

        articleModel.setArticle_id(String.valueOf(System.currentTimeMillis()));
        articleModel.setUserid(userid);
        articleModel.setUsername(username);
        articleModel.setTitle(title);
        articleModel.setDescribes(des);
        articleModel.setContent(content);

        if(userid == null || userid.equals("")){
            modelAndView.addObject("msg", "请登录");
            modelAndView.setViewName("fail");
            return modelAndView;
        }else{
            User user = UserDB.getInstence().getUserByUserId(userid);
            if(user == null || user.getId() <= 0){
                modelAndView.addObject("msg", "请先注册");
                modelAndView.setViewName("fail");
                return modelAndView;
            }
        }


        int row = ArticleDB.getInstence().insertOne(articleModel);
        if (row <= 0) {
            modelAndView.addObject("msg", "提交失败");
            modelAndView.setViewName("fail");
            return modelAndView;
        }
        ArticleModel articleModel1 = ArticleDB.getInstence().getArticleLast();
        if (articleModel1 == null) {
            modelAndView.addObject("msg", "获取数据失败");
            modelAndView.setViewName("fail");
            return modelAndView;
        }
        modelAndView.addObject("articleModel", articleModel1);
        modelAndView.setViewName("detailsPage");
        return modelAndView;
    }

    /**
     * 更新文章
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView update(HttpServletRequest req) {
        ModelAndView modelAndView = new ModelAndView();
        //取得表单数据
        ArticleModel articleModel = new ArticleModel();
        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String userid = req.getParameter("userid");
        String id = req.getParameter("id");
        String title = req.getParameter("title");
        String des = req.getParameter("des");
        String content = req.getParameter("content");
        String psw = req.getParameter("psw");
        //密码解密
        if(psw == null || psw.equals("")){
            modelAndView.addObject("msg", "账号不正确");
            modelAndView.setViewName("fail");
            return modelAndView;
        }else{
            psw = new DESUtil().decrypt(psw);
        }

        //首先进行账号的验证
        Map<String, String> map = new HashMap<String, String>();
        map.put("userid", userid);
        map.put("psw", psw);
        User user = UserDB.getInstence().login(map);
        if(user == null || user.getId()<= 0){
            modelAndView.addObject("msg", "账号不正确");
            modelAndView.setViewName("fail");
            return modelAndView;
        }

        articleModel.setArticle_id(String.valueOf(System.currentTimeMillis()));
        articleModel.setUserid(userid);
        articleModel.setTitle(title);
        articleModel.setDescribes(des);
        articleModel.setContent(content);
        if (id != null && !id.equals("")) {
            articleModel.setId(Integer.valueOf(id));
            int row = ArticleDB.getInstence().updateOne(articleModel);
            if (row <= 0) {
                modelAndView.addObject("msg", "用户信息不正确");
                modelAndView.setViewName("fail");
                return modelAndView;
            }
        } else {
            int row = ArticleDB.getInstence().insertOne(articleModel);
            if (row <= 0) {
                modelAndView.addObject("msg", "提交失败");
                modelAndView.setViewName("fail");
                return modelAndView;
            }
        }
        modelAndView.setViewName("detailsPage");
        modelAndView.addObject("articleModel", articleModel);
        return modelAndView;
    }

}
