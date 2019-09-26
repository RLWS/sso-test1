package com.rlws.plant.platform.controller;

import com.rlws.plant.platform.po.Answer;
import com.rlws.plant.platform.po.Praise;
import com.rlws.plant.platform.service.AnswerService;
import com.rlws.plant.platform.service.PraiseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PraiseController {

    @Autowired
    private PraiseService praiseService;

    @Autowired
    private AnswerService answerService;

    //用户点赞回答
    @RequestMapping(value = "user_click_answer_praise" , method = RequestMethod.GET)
    @ResponseBody
    public boolean userClickPraise(Praise praise){
        System.out.println(praise);
        Praise praise1 = praiseService.selectPraiseByPraise(praise);
        if (praise1 != null){
            return false;
        }else {
            boolean b = praiseService.insertOnePraise(praise);
            boolean b1 = answerService.userClickOneAnswer(praise.getAnswer_id());
            if (b && b1)
                return true;
        }
        return false;
    }
}
