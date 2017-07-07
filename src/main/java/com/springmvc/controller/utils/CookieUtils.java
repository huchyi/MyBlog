package com.springmvc.controller.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieUtils {

    public static String getUserId(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        if (null == cookies) {
            return "";
        }
        for (Cookie cookie : cookies) {
            if ("userid".equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return "";
    }

    public static String getUserName(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        if (null == cookies) {
            return "";
        }
        for (Cookie cookie : cookies) {
            if ("username".equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return "";
    }


}
