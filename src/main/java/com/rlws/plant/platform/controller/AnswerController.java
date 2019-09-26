package com.rlws.plant.platform.controller;

import com.alibaba.fastjson.JSON;
import com.rlws.plant.platform.po.Answer;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.service.AnswerService;
import com.rlws.plant.platform.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
public class AnswerController {

    @Autowired
    private AnswerService answerService;

    @Autowired
    private QuestionService questionService;

    //用户回答问题
    @RequestMapping(value = "user_answer_question" , method = RequestMethod.POST)
    @ResponseBody
    public boolean userAnswer(@Autowired(required = true)Answer answer){
        boolean b = false;
        //判断是否回答过该问题
        Answer answer1 = answerService.selectUserAnswerQuestion(answer);
        if (answer1 == null){
            answer.setTime(new Date());
            b = answerService.userAnswerQuestion(answer);
        }
        return b;
    }

    //用户举报实现
    @RequestMapping(value = "user_report" , method = RequestMethod.GET)
    public String userReport(String  question_id , String answer_id , HttpServletRequest request){
        if (question_id != null || "".equals(question_id)){
            Question question = questionService.selectQuestionById(Integer.parseInt(question_id));
            request.setAttribute("question",question);
        }else {
            Answer answer = answerService.userReportAnswer(Integer.parseInt(answer_id));
            request.setAttribute("answer",answer);
        }
        return "report";
    }

    //根据question_id获取该问题的所有答案
    @RequestMapping(value = "user_choose_optimal_answer" , method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllAnswerByQuestionId(String questionId){
        List<Answer> allAnswerByQuestionId = answerService.getAllAnswerByQuestionId(Integer.parseInt(questionId));
        String s = JSON.toJSONString(allAnswerByQuestionId);
        System.out.println(s);
        return s;
    }

    //manager删除一条回答
    @RequestMapping(value = "manager_delete_one_answer", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public boolean managerDelectOneAnswer(String answer_id){
        boolean b = answerService.deleteOneAnswer(Integer.parseInt(answer_id));
        Question question = questionService.selectQuestionDetailsByAnswerId(Integer.parseInt(answer_id));
        if (question != null){
            question.setOptimal(0);
            System.out.println(question);
            boolean b1 = questionService.updateOneQuestionOptimal(question);
        }
        return b;
    }
}
