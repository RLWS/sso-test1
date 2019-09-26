package com.rlws.plant.platform.controller;

import com.alibaba.fastjson.JSON;
import com.rlws.plant.platform.po.Collect;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.service.CollectService;
import com.rlws.plant.platform.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CollectController {

    @Autowired
    private CollectService collectService;

    @Autowired
    private QuestionService questionService;

    @RequestMapping(value = "user_click_praise" , method = RequestMethod.GET)
    @ResponseBody
    public boolean userClickPraise(int user_id,int question_id){
        //用户收藏是否成功
        System.out.println("-------------"+user_id+"============="+question_id);
        boolean b = collectService.userClickQuestion(user_id, question_id);
        return b;
    }

    //获取用户所有收藏的问题Ajax
    @RequestMapping(value = "get_user_all_collect_question_ajax",method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllQuestionUserAnswer(int user_id , int page_current ,int page_size){
        Map<String,Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setId(user_id);
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current-1)*page_size);
        List<Collect> collects = collectService.selectUserAllCollectQuestion(pageVo);
        pageVo.setPage_count(collectService.selectUserAllCollectQuestionCount(user_id));
        map.put("collects",collects);
        map.put("pageVo",pageVo);
        String s = JSON.toJSONString(map);
        System.out.println(s);
        return s;
    }

    //用户取消收藏的问题
    @RequestMapping(value = "user_cancel_question_ajax",method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public boolean userCancelQuestion(int collect_id,int question_id){
        Question question = questionService.selectTitleToDetails(question_id);
        if (question != null){
            int praise = question.getPraise();
            if (praise > 0){
                question.setPraise(praise - 1);
                boolean b = questionService.updateOneQuestionOptimal(question);
                if (b){
                    return collectService.deleteOneCollect(collect_id);
                }
            }
        }
        return false;
    }

}
