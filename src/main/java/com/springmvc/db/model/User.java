package com.springmvc.db.model;

import java.io.Serializable;
import java.util.Map;

/**
 * @author gacl
 *         users表所对应的实体类
 */
public class User implements Serializable {

    //实体类的属性和表的字段名称一一对应
    private int id;
    private String username;
    private String psw;
    private String userid;
    private String userphone;
    private String email;

    public User() {
    }

    public User(int id, String username, String psw, String userid, String userphone, String email) {
        this.id = id;
        this.username = username;
        this.psw = psw;
        this.userid = userid;
        this.userphone = userphone;
        this.email = email;
    }

    public void setMap(Map<String, String> map) {
        for (String keyStr : map.keySet()) {
            if (keyStr.equals("id")) {
                setId(Integer.valueOf(map.get(keyStr)));
            } else if (keyStr.equals("username")) {
                setUsername(map.get(keyStr));
            } else if (keyStr.equals("psw")) {
                setPsw(map.get(keyStr));
            } else if (keyStr.equals("userid")) {
                setUserid(map.get(keyStr));
            } else if (keyStr.equals("userphone")) {
                setUserphone(map.get(keyStr));
            } else if (keyStr.equals("email")) {
                setEmail(map.get(keyStr));
            }
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPsw() {
        return psw;
    }

    public void setPsw(String psw) {
        this.psw = psw;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUserphone() {
        return userphone;
    }

    public void setUserphone(String userphone) {
        this.userphone = userphone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}