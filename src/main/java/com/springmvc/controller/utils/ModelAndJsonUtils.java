package com.springmvc.controller.utils;

import org.codehaus.jackson.map.ObjectMapper;

import java.io.IOException;

public class ModelAndJsonUtils {

    public static String ModelToJson(Object o){
        if(o == null){
            return "";
        }
        ObjectMapper mapper = new ObjectMapper();
        String json = "";
        try {
            json = mapper.writeValueAsString(o);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return json;
    }


    public static String ModelToJsonWithBase64(Object o){
        if(o == null){
            return "";
        }
        ObjectMapper mapper = new ObjectMapper();
        String json = "";
        try {
            json = mapper.writeValueAsString(o);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(json);
        return Base64.encode(json);
    }
}
