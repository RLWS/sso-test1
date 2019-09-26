package com.rlws.plant.platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
public class UploadController {

    /**
     * 文件上传
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "upload", method = RequestMethod.POST)
    public Map<String, Object> upload(MultipartFile dropFile, MultipartFile wangEditor, HttpServletRequest request) throws IOException {

        HashMap<String, Object> result = new HashMap<String, Object>();

        MultipartFile howFile = dropFile == null ? wangEditor : dropFile;

        //获取项目上传文件目录的绝对路径
        String uploadPath = request.getSession().getServletContext().getRealPath("/static/upload");

        //判断文件路径是否存在,如果不存在则新建文件夹
        File file = new File(uploadPath);
        if (!file.exists()) {
            file.mkdir();
        }

        //文件名获取
        String fileName = howFile.getOriginalFilename();

        //文件后缀名获取
        String fileSuffix = fileName.substring(fileName.lastIndexOf("."));

        //使用uuid随机生成一个唯一的字符串+后缀名=唯一的文件名
        fileName = UUID.randomUUID() + fileSuffix;

        //新建一个空的file对象
        file = new File(uploadPath, fileName);

        //将文件内容输出到file中
        howFile.transferTo(file);

        //获取服务器地址与端口(协议(http或https)+服务器地址(ip或域名)+服务器端口)
        String serverPath = request.getScheme() + "://" + request.getServerName() + ":" +request.getServerPort();

        if (dropFile != null){
            result.put("filePath",serverPath + "/static/upload/"+fileName);
        }else {
            result.put("errno",0);
            result.put("data",new String[]{serverPath + "/static/upload/"+fileName});
        }
        return result;
    }
}
