package com.rlws.plant.platform.controller;

import com.alibaba.fastjson.JSON;
import com.rlws.plant.platform.po.Answer;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.po.Report;
import com.rlws.plant.platform.service.AnswerService;
import com.rlws.plant.platform.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ReportController {

    @Autowired
    private ReportService reportService;

    @Autowired
    private AnswerService answerService;

    //用户举报功能实现
    @RequestMapping(value = "user_report_manager" , method = RequestMethod.POST)
    public String userReportQeustionOrAnswer(Report report ,String questionId , String answerId , HttpServletRequest request){
        if (questionId == null || "".equals(questionId)){
            report.setAnswer_id(Integer.parseInt(answerId));
        }else{
            report.setQuestion_id(Integer.parseInt(questionId));
        }
        boolean b = reportService.insertOneReport(report);
        if (b){
            request.setAttribute("message","举报成功");
            return "report";
        }
        request.setAttribute("message","举报失败,请通过右边的联系方式与管理员联系");
        return "report";
    }

    //获取所有被举报的问题
    @RequestMapping(value = "get_report_question_ajax",method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllReportQuestion(int page_current ,int page_size){
        Map<String,Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current-1)*page_size);
        List<Report> reports = reportService.selectAllReportQuestion(pageVo);
        pageVo.setPage_count(reportService.selectAllReportQuestionCount());
        map.put("reports",reports);
        map.put("pageVo",pageVo);
        String s = JSON.toJSONString(map);
        return s;
    }

    //获取所有被举报的回答
    @RequestMapping(value = "get_report_answer_ajax",method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllReportAnswer(int page_current ,int page_size){
        Map<String,Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current-1)*page_size);
        List<Report> reports = reportService.selectAllReportAnswer(pageVo);
        pageVo.setPage_count(reportService.selectAllReportAnswerCount());
        map.put("reports",reports);
        map.put("pageVo",pageVo);
        String s = JSON.toJSONString(map);
        return s;
    }

    //manager举报删除
    @RequestMapping(value = "manager_delete_one_report", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public boolean managerDelectOneReport(String report_id){
        boolean b = reportService.deleteOneReport(Integer.parseInt(report_id));
        return b;
    }

    //manager回答详情查看
    @RequestMapping(value = "manager_search_one_answer", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String managerSearchAnswerById(String answer_id){
        Answer answer = answerService.selectOptimalAnswerById(Integer.parseInt(answer_id));
        String s = JSON.toJSONString(answer);
        return s;
    }
}
