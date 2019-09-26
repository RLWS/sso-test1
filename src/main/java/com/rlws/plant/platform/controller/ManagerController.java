package com.rlws.plant.platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

@Controller
public class ManagerController {

    @Autowired
    private HttpServletRequest myRequest;

    //跳转到管理员(用户管理)
    @RequestMapping(value = {"manager_to_user"},method = RequestMethod.GET)
    public String managerToUser(){
        return "manager/user-manager";
    }

    //跳转到管理员(问题管理)
    @RequestMapping(value = "manager_to_question",method = RequestMethod.GET)
    public String managerToQuestion(){
        return "manager/question-manager";
    }

    //跳转到管理员(举报管理)
    @RequestMapping(value = "manager_to_report",method = RequestMethod.GET)
    public String managerToReport(){
        return "manager/report-manager";
    }

    //跳转到管理员(申请管理)
    @RequestMapping(value = "manager_to_apply",method = RequestMethod.GET)
    public String managerToApply(){
        return "manager/apply-manager";
    }

    //跳转到管理员(文章管理)
    @RequestMapping(value = "manager_to_recommendation",method = RequestMethod.GET)
    public String managerToRecommendation(){
        return "manager/recommendation-manager";
    }

    //跳转到管理员(类别管理)
    @RequestMapping(value = "manager_to_category",method = RequestMethod.GET)
    public String managerToCategory(){
        return "manager/category-manager";
    }

    //退出管理员登录
    @RequestMapping(value = "manager_exit",method = RequestMethod.GET)
    public String managerExit(HttpServletRequest request){
        request.getSession().setAttribute("manager",null);
        return "redirect:login";
    }

    //管理员修改申请条件
    @ResponseBody
    @RequestMapping(value = "manager_update_apply_count",method = RequestMethod.GET)
    public boolean updateApplyCount(String num,HttpServletRequest request){
        int count = Integer.parseInt(num);
        ServletContext application = myRequest.getSession().getServletContext();
        application.setAttribute("BestAnswerCount",num);
        int countUpdate = Integer.parseInt(application.getAttribute("BestAnswerCount").toString()) ;
        if (count == countUpdate) {
            return true;
        }
        return false;
    }
}
