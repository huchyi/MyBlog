package com.springmvc.controller;

import com.springmvc.controller.utils.ImageUploadUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Date;

//url:  http://localhost:8080/file/
@Controller  //告诉DispatcherServlet相关的容器， 这是一个Controller，
@RequestMapping(value = "/file")  //类级别的RequestMapping，告诉DispatcherServlet由这个类负责处理以及URL。HandlerMapping依靠这个标签来工作
public class FileController {
    /**
     * 上传单个文件操作
     *
     * @param file
     * @return
     */
    @RequestMapping(value = "/doUpload", method = RequestMethod.POST)
    @ResponseBody
    public String doUploadFile(HttpServletResponse response, HttpServletRequest request, @RequestParam("upload") MultipartFile file) {
        response.setContentType("text/html; charset=UTF-8");
        String savePath = request.getSession().getServletContext().getRealPath("upload/userImage");
        String fileName = "";
        if (!file.isEmpty()) {
            try {
                //放在项目所在的资源文件。
                fileName = System.currentTimeMillis() + file.getOriginalFilename();
                FileUtils.copyInputStreamToFile(file.getInputStream(), new File(savePath,fileName));
            } catch (IOException e) {
                e.printStackTrace();
                return "fail";
            }
        }
        String string = "";
        try {
            String ss = " <script type=\"text/javascript\">";
            ss = ss + "alert(\"图片路径: "+ savePath +"\\"+ fileName +"\");";
            ss = ss + "</script>";
            string = new String(ss.getBytes("UTF-8"), "iso-8859-1");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        System.out.println(">>>>>>>>>>>>:" + string);
        return string;
    }

    /*
     * 采用file.Transto 来保存上传的文件
     */
    @RequestMapping("doUpload2")
    @ResponseBody
    public String  fileUpload2(@RequestParam("upload") CommonsMultipartFile file) throws IOException {
        long  startTime=System.currentTimeMillis();
        System.out.println("fileName："+file.getOriginalFilename());
        String path="E:/"+new Date().getTime()+file.getOriginalFilename();

        File newFile=new File(path);
        //通过CommonsMultipartFile的方法直接写文件（注意这个时候）
        file.transferTo(newFile);
        long  endTime=System.currentTimeMillis();
        System.out.println("方法二的运行时间："+String.valueOf(endTime-startTime)+"ms");
        return "success";
    }

    /**
     * ckeditor图片上传
     *
     * @Title imageUpload
     * @param request
     * @param response
     */
    @RequestMapping("doUpload3")
    public void imageUpload(HttpServletRequest request, HttpServletResponse response) {
        String DirectoryName = "upload"+ File.separator +"userImage";
        try {
//            String savedDir = request.getSession().getServletContext().getRealPath("/");
//            String savedDir2 = request.getSession().getServletContext().getRealPath("/" + DirectoryName);
//            String savedDir3 = request.getSession().getServletContext().getRealPath("");
//            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>savedDir:" + savedDir);
//            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>savedDir2:" + savedDir2);
//            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>savedDir3:" + savedDir3);
            ImageUploadUtil.ckeditor(request, response, DirectoryName);
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
