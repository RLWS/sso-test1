package com.rlws.plant.platform.controller;

import com.alibaba.fastjson.JSON;
import com.rlws.plant.platform.po.Apply;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.po.User;
import com.rlws.plant.platform.service.ApplyService;
import com.rlws.plant.platform.service.QuestionService;
import com.rlws.plant.platform.service.ReplyService;
import com.rlws.plant.platform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ApplyController {

    @Autowired
    private ApplyService applyService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private ReplyService replyService;

    @Autowired
    private UserService userService;

    //用户申请达人Ajax
    @ResponseBody
    @RequestMapping(value = "user_apply_talent_ajax",method = RequestMethod.POST ,produces = "application/json;charset=utf-8")
    public boolean userApplyTalent(Apply apply){
        apply.setTime(new Date());
        boolean b = applyService.insertOneApply(apply);
        return b;
    }

    //manager获取所有申请达人的数据Ajax
    @RequestMapping(value = "get_all_apply_user_ajax",method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllReportAnswer(int page_current ,int page_size){
        Map<String,Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current-1)*page_size);
        List<Apply> applies = applyService.selectAllApply(pageVo);
        pageVo.setPage_count(applyService.selectAllApplyCount());
        map.put("applies",applies);
        map.put("pageVo",pageVo);
        String s = JSON.toJSONString(map);
        return s;
    }

    //manager获取申请用户的详情
    @RequestMapping(value = "manager_get_user_message",method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String managerGetUserMessage(String user_id){
        int userId = Integer.parseInt(user_id);
        Map<String,Object> map = new HashMap<String, Object>();
        //获取用户发布问题的数量
        int questionCount = questionService.selectUserAllQuestionCountByUserId(userId);
        //获取用户回答问题的数量
        int answerCount = questionService.selectUserAllAnswerQuestionCount(userId);
        //获取用户评论回答的数量
        int replyCount = replyService.selectUserReplyCount(userId);
        //获取最佳回复数量
        int bestCount = userService.selectUserBestAnswerCount(userId);
        map.put("questionCount",questionCount);
        map.put("answerCount",answerCount);
        map.put("replyCount",replyCount);
        map.put("bestCount",bestCount);
        String s = JSON.toJSONString(map);
        return s;
    }

    //manager删除一条Appay数据Ajax
    @ResponseBody
    @RequestMapping(value = "manager_delete_one_apply",method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    public boolean managerDeleteOneApply(String apply_id){
        boolean b = applyService.deleteOneApply(Integer.parseInt(apply_id));
        return b;
    }

    //manager同意用户申请为达人用户
    @ResponseBody
    @RequestMapping(value = "manager_agree_user_apply",method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    public boolean managerAgreeUserApply(String apply_id , String user_id){
        User user = userService.selectOneUserById(Integer.parseInt(user_id));
        user.setPower(2);
        boolean b = userService.updateUser(user);
        if (b){
            Apply apply = applyService.selectOneApply(Integer.parseInt(apply_id));
            apply.setHandle(1);
            b = applyService.updateOneApply(apply);
        }
        return b;
    }
}
