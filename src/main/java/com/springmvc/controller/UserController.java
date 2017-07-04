package com.springmvc.controller;

import com.springmvc.controller.utils.AccountValidatorUtil;
import com.springmvc.controller.utils.DESUtil;
import com.springmvc.db.model.User;
import com.springmvc.db.service.UserService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller  //告诉DispatcherServlet相关的容器， 这是一个Controller，
@RequestMapping(value = "/user")  //类级别的RequestMapping，告诉DispatcherServlet由这个类负责处理以及URL。HandlerMapping依靠这个标签来工作
public class UserController {
    private Logger logger = LogManager.getLogger(UserController.class);

    @Autowired
    private UserService userService;
    /**
     * 登录
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(@RequestParam String url) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("login");
        modelAndView.addObject("url", url);
        return modelAndView;
    }

    /**
     * 登录验证
     */
    @RequestMapping(value = "/loginRequest", method = RequestMethod.POST)
    @ResponseBody
    public String loginRequest(HttpServletRequest req, HttpServletResponse response) {
        String account = req.getParameter("account");
        String psw = req.getParameter("psw");
        String url = req.getParameter("url");

        Map<String, String> map = new HashMap<String, String>();
        map.put("email", account);
        map.put("userphone", account);
        map.put("userid", account);
        map.put("psw", psw);
        User user = userService.login(map);

        if (user != null && user.getId() > 0) {
            //设置cookie

            // 设置 name 和 url cookie
            Cookie usernameCookie = new Cookie("username",  user.getUsername());
            Cookie useridCookie = new Cookie("userid", user.getUserid());

            // 设置cookie过期时间为12h。
            usernameCookie.setMaxAge(60 * 60 * 12);
            useridCookie.setMaxAge(60 * 60 * 12);

            usernameCookie.setPath("/");
            useridCookie.setPath("/");

            // 在响应头部添加cookie
            response.addCookie(usernameCookie);
            response.addCookie(useridCookie);

            if (url != null && !url.equals("")) {
                return "<script type=\"text/javascript\">" +
                        "window.location.href = \"" + url + "\";" +
                        "</script>";
            } else {
                return "login success";
            }
        }
        return "login fail";
    }

    /**
     * 登出
     */
    @RequestMapping(value = "/loginOut", method = RequestMethod.GET)
    @ResponseBody
    public String loginOut(HttpServletResponse response,HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (null==cookies){
            return "false";
        }
        for (Cookie cookie : cookies) {
            if ("userid".equals(cookie.getName())){
                userService.loginOut(cookie.getValue());
            }
        }
        // 设置 name 和 url cookie
        Cookie usernameCookie = new Cookie("username", "");
        Cookie useridCookie = new Cookie("userid", "");

        // 设置cookie过期时间为12h。
        usernameCookie.setMaxAge(0);
        useridCookie.setMaxAge(0);

        usernameCookie.setPath("/");
        useridCookie.setPath("/");

        // 在响应头部添加cookie
        response.addCookie(usernameCookie);
        response.addCookie(useridCookie);
        return "success";
    }

    /**
     * 注册
     */
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView register(@RequestParam String url) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("register");
        modelAndView.addObject("url", url);
        return modelAndView;
    }

    /**
     * 注册验证
     */
    @RequestMapping(value = "/registerRequest", method = RequestMethod.POST)
    @ResponseBody
    public String registerRequest(HttpServletRequest req, HttpServletResponse response) {

        String username = req.getParameter("username");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String psw = req.getParameter("psw");
        String url = req.getParameter("url");

        if(phone == null || phone.equals("") || !AccountValidatorUtil.isMobile(phone)){
            return "register fail,Please enter the correct cell phone number";
        }

        Map<String, String> map = new HashMap<String, String>();
        map.put("username", username);
        map.put("userphone", phone);
        if (email != null && !email.equals("")) {
            map.put("email", email);
        }
        UUID uuid = UUID.randomUUID();
        map.put("userid", uuid.toString());
        map.put("psw", psw);
        boolean isRegister = userService.register(map);
        if (isRegister) {
            // 设置 name 和 url cookie
            Cookie usernameCookie = new Cookie("username", username);
            Cookie useridCookie = new Cookie("userid", uuid.toString());

            // 设置cookie过期时间为12h。
            usernameCookie.setMaxAge(60 * 60 * 12);
            useridCookie.setMaxAge(60 * 60 * 12);

            usernameCookie.setPath("/");
            useridCookie.setPath("/");

            // 在响应头部添加cookie
            response.addCookie(usernameCookie);
            response.addCookie(useridCookie);

            if (url != null && !url.equals("")) {
                return "<script type=\"text/javascript\">" +
                        "window.location.href = \"" + url + "\";" +
                        "</script>";
            } else {
                return "login success";
            }
        } else {
            return "register fail";
        }
    }


    @ResponseBody
    @RequestMapping(value = "/queryUserIsLogin",method = RequestMethod.GET)
    public String queryUserIsLogin(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        if (null==cookies){
            return "false";
        }
        for (Cookie cookie : cookies) {
            if ("userid".equals(cookie.getName())){
                if(userService.isLogin(cookie.getValue())){
                    return "true";
                }
                cookie.setValue("");
                return "false";
            }
        }
        return "false";
    }
}
