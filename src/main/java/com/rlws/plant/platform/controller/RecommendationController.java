package com.rlws.plant.platform.controller;

import com.alibaba.fastjson.JSON;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.po.Recommendation;
import com.rlws.plant.platform.service.QuestionService;
import com.rlws.plant.platform.service.RecommendationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RecommendationController {

    @Autowired
    private RecommendationService recommendationService;

    @Autowired
    private QuestionService questionService;

    //跳转到大人用户中心页面Get
    @RequestMapping(value = "user_talent",method = RequestMethod.GET)
    public String userReleaseRecommendation(){
        return "user/user-talent";
    }

    //跳转到更多推荐页面
    @RequestMapping(value = "more_recommendation" , method = RequestMethod.GET)
    public String moreRecommendation(HttpServletRequest request){
        List<Recommendation> recommendations = recommendationService.selectNewNumRecommendation(6);
        List<Question> rmQuestions = questionService.selectOneWeekLimitTitle(6);
        List<Question> hdQuestions = questionService.selectOneWeekMostAnswerQuestion(6);
        request.setAttribute("recommendations",recommendations);
        request.setAttribute("rmQuestion",rmQuestions);
        request.setAttribute("hdQuestions",hdQuestions);
        return "more-recommendation";
    }

    //跳转到推荐详细页面
    @RequestMapping(value = "to_recommendation_details" , method = RequestMethod.GET)
    public String toRecommendationDetails(HttpServletRequest request , String id){
        Recommendation recommendation = recommendationService.selectRecommendationById(Integer.parseInt(id));
        //获取右边列表
        List<Question> questions = questionService.selectOneWeekLimitTitle(6);
        request.setAttribute("recommendation",recommendation);
        request.setAttribute("questions", questions);
        return "recommended-details";
    }

    //跳转到所有推荐页面
    @RequestMapping(value = "all_recommendation" , method = RequestMethod.GET)
    public String allRecommendation(){
        return "all-recommendation";
    }

    //获取所有的推荐文章(ajax分页)
    @ResponseBody
    @RequestMapping(value = "all_recommendation_ajax" , method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    public String moreRecommendation(int page_current, int page_size){
        Map<String, Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current - 1) * page_size);
        List<Recommendation> recommendations = recommendationService.selectAllRecommendation(pageVo);
        pageVo.setPage_count(recommendationService.selectAllRecommendationCount());
        map.put("recommendations", recommendations);
        map.put("pageVo", pageVo);
        String s = JSON.toJSONString(map);
        return s;
    }

    //达人用户发布推荐文章
    @RequestMapping(value = "user_talent_release",method = RequestMethod.POST)
    public String userTalentReleaseRecommendation(Recommendation recommendation){
        recommendation.setTime(new Date());
        boolean b = recommendationService.userAddOneRecommendation(recommendation);
        return b ? userReleaseRecommendation() : "error";
    }

    //获取达人用户所有发表的推荐文章Ajax
    @ResponseBody
    @RequestMapping(value = "user_talent_get_all_recommendation" , method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    public String userTalentGetAllRecommendation(int page_current ,int page_size,int user_id){
        Map<String,Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setId(user_id);
        pageVo.setPage_count(recommendationService.selectUserIdAllRecommendationCount(user_id));
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current-1)*page_size);
        List<Recommendation> recommendations = recommendationService.selectRecommendationByUserId(pageVo);
        map.put("recommendations",recommendations);
        map.put("pageVo",pageVo);
        String s = JSON.toJSONString(map);
        return s;
    }

    //根据Id删除一条Recommendation数据Ajax
    @ResponseBody
    @RequestMapping(value = {"user_delect_one_recommendation_ajax","manager_delect_one_recommendation_ajax"} , method = RequestMethod.POST)
    public boolean userDelectOneRecommendation(int recommendationId){
        System.out.println("--------------"+recommendationId);
        boolean b = recommendationService.deleteRecommendationById(recommendationId);
        return b;
    }

    //获取所有的推荐文章Ajax
    @ResponseBody
    @RequestMapping(value = "manager_get_all_recommendation" , method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    public String managerGetAllRecommendation(int page_current ,int page_size){
        Map<String,Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_count(recommendationService.selectAllRecommendationCount());
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current-1)*page_size);
        List<Recommendation> recommendations = recommendationService.selectAllRecommendation(pageVo);
        map.put("recommendations",recommendations);
        map.put("pageVo",pageVo);
        String s = JSON.toJSONString(map);
        return s;
    }

    //manager获取推荐详细
    @ResponseBody
    @RequestMapping(value = "manager_get_recommendation_details" , method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    public String ManagerRecommendationDetails(String recommendation_id){
        Recommendation recommendation = recommendationService.selectRecommendationById(Integer.parseInt(recommendation_id));
        String s = JSON.toJSONString(recommendation);
        return s;
    }

    //manager更新一条Recommendation数据
    @RequestMapping(value = "manager_update_one_recommendation",method = RequestMethod.POST)
    public String managerUpdateOneRecommendation(Recommendation recommendation){
        System.out.println("--------------------"+recommendation);
        boolean b = recommendationService.updateOneRecommendation(recommendation);
        return "redirect:manager_to_recommendation";
    }

    //过滤前台传过来的时间格式
    @InitBinder
    public void InitBinder(ServletRequestDataBinder binder) {
        //注册自定义的编辑器,后面的true代表的是 允许为null  false 不允许null
        binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));
    }
}
