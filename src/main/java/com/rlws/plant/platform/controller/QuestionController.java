package com.rlws.plant.platform.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.rlws.plant.platform.po.*;
import com.rlws.plant.platform.service.AnswerService;
import com.rlws.plant.platform.service.CategoryService;
import com.rlws.plant.platform.service.QuestionService;
import com.rlws.plant.platform.service.UserService;
import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class QuestionController {

    @Autowired
    private QuestionService questionService;

    @Autowired
    private AnswerService answerService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;

    private int questionCount = 0;

    //用户添加一条新闻
    @RequestMapping(value = "user_add_one_question", method = RequestMethod.POST)
    public String userReleaseQuestion(Question question, HttpServletRequest request) {
        question.setTime(new Date());
        boolean b = questionService.userReleaseQuestion(question);
        if (b && question.getUrgent() == 1) {
            User user = userService.selectOneUserById(question.getUser_id());
            user.setFrequency(user.getFrequency() - 1);
            boolean b1 = userService.updateUser(user);
            if (b1) {
                request.getSession().setAttribute("user", user);
            }
        }
        return "user/user";
    }

    //点击问题标题跳转到问题详情
    @RequestMapping(value = "title_go_details", method = RequestMethod.GET)
    public String userClickTitle(HttpServletRequest request, @Autowired(required = true) int id) {
        //获取问题详情内容
        Question question = questionService.selectTitleToDetails(id);
        //获取问题具体回答
        List<Answer> allAnswer = answerService.getAllAnswerByQuestionId(id);
        //获取右边列表
        List<Question> questions = questionService.selectOneWeekLimitTitle(6);
        //获取问题的回复数量
        int i = questionService.selectQuestionAnswerCount(id);
        //根据AnswerId获取最佳回答
        int optimal = question.getOptimal();
        if (optimal != 0) {
            Answer answer = answerService.selectOptimalAnswerById(optimal);
            request.setAttribute("optimal", answer);
        }
        request.setAttribute("questionAnswerCount", i);
        request.setAttribute("allAnswer", allAnswer);
        request.setAttribute("question", question);
        request.setAttribute("questions", questions);
        return "details";
    }

    //首页初始化问题列表
    @RequestMapping(value = {"index", ""}, method = RequestMethod.GET)
    public String index(HttpServletRequest request) {
        System.out.println("-----------------------------test----------------------------");
        //定义全局作用域的申请值
        ServletContext application = request.getSession().getServletContext();
        if (application.getAttribute("BestAnswerCount") == null)
            application.setAttribute("BestAnswerCount", 99);
        List<Question> questionDetails = questionService.selectNewTitle(6);
        List<Question> questions = questionService.selectOneWeekLimitTitle(6);
        List<Category> categories = categoryService.selectAllCategory(null);
        //30tian
        List<Question> questionsUrgent = questionService.selectUrgentQuestion(6);
        request.setAttribute("questionsUrgent", questionsUrgent);
        request.getSession().setAttribute("categories", categories);
        request.setAttribute("questionDetails", questionDetails);
        System.out.println("----------" + questionsUrgent);
        request.setAttribute("questions", questions);
        return "/index";
    }

    //问题搜索功能实现
    @RequestMapping(value = "search_result", method = RequestMethod.GET)
    public String searchResult(String searchTitle, HttpServletRequest request) throws IOException {
        List<Question> questions = questionService.userSearcherQuestion(searchTitle);
        questionCount = questions.size();
        request.setAttribute("page_count", (int) Math.ceil((double) questionCount / 7));
        request.getSession().setAttribute("searchTitle", searchTitle);
        request.setAttribute("questions", questions);
        return "/query-result";
    }

    //问题搜索功能实现Ajax异步请求
    @RequestMapping(value = "search_result_ajax", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String ajaxSearchResult(String searchTitle, int page_current, int page_size) throws IOException {
        Map<String, Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_count(questionCount);
        pageVo.setPage_current(page_current);
        pageVo.setPage_size(page_size);
        pageVo.setPage_start((page_current - 1) * page_size);
        List<Question> questions = questionService.userSearcherQuestionAjax(pageVo, searchTitle);
        map.put("questions", questions);
        map.put("pageVo", pageVo);
        String json = JSON.toJSONString(map);
        return json;
    }

    //用户的所有问题获取Ajax异步请求
    @RequestMapping(value = "user_all_question", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllUserQuestion(String user_id, int page_current, int page_size) {
        System.out.println(user_id + page_current + page_size);
        Map<String, Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_count(questionService.selectUserAllQuestionCountByUserId(Integer.parseInt(user_id)));
        pageVo.setId(Integer.parseInt(user_id));
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current - 1) * page_size);
        List<Question> userAllQuestionByUserId = questionService.getUserAllQuestionByUserId(pageVo);
        map.put("questions", userAllQuestionByUserId);
        map.put("pageVo", pageVo);
        String json = JSON.toJSONString(map);
        return json;
    }

    //用户提交最佳答案的Ajax异步请求
    @RequestMapping(value = "user_chooce_answer_optimal", method = RequestMethod.GET)
    @ResponseBody
    public boolean userClickPraise(int answer_id, int question_id) {
        System.out.println(answer_id + "-----" + question_id);
        Question question = questionService.selectTitleToDetails(question_id);
        question.setOptimal(answer_id);
        question.setUser_id(question.getUser().getId());
        question.setCategory_id(question.getCategory().getId());
        System.out.println(question);
        boolean b = questionService.updateOneQuestionOptimal(question);
        //最佳答案成功后给回答用户的紧急次数加一
        if (b) {
            Answer answer = answerService.selectOptimalAnswerById(answer_id);
            User user = userService.selectOneUserById(answer.getUser_id());
            user.setFrequency(user.getFrequency() + 1);
            boolean b1 = userService.updateUser(user);
        }
        return b;
    }

    //跳转到等我回答页面
    @RequestMapping(value = "question_no_answer", method = RequestMethod.GET)
    public String waitMeAnswer() {
        return "/wait-me-answer";
    }

    //获取所有未回答的问题
    @RequestMapping(value = "question_no_answer_ajax", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String questionNotAnswer(int page_current, int page_size) {
        Map<String, Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_count(questionService.questionNotAnswerCount());
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current - 1) * page_size);
        List<Question> questions = questionService.questionNotAnswer(pageVo);
        map.put("questions", questions);
        map.put("pageVo", pageVo);
        String s = JSON.toJSONString(map);
        System.out.println(s);
        return s;
    }

    //获取所有用户回答过的问题
    @RequestMapping(value = "get_all_question_user_answer_ajax", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllQuestionUserAnswer(int user_id, int page_current, int page_size) {
        Map<String, Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setId(user_id);
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current - 1) * page_size);
        List<Question> questions = questionService.selectUserAllAnswerQuestion(pageVo);
        pageVo.setPage_count(questionService.selectUserAllAnswerQuestionCount(user_id));
        map.put("questions", questions);
        map.put("pageVo", pageVo);
        String s = JSON.toJSONString(map);
        System.out.println(s);
        return s;
    }

    //点击用户获取用户的历史提问
    @RequestMapping(value = "to_user_all_history_question", method = RequestMethod.GET)
    public String toUserHistoryQuestion(int id, String username, HttpServletRequest request) {
        request.setAttribute("userId", id);
        request.setAttribute("username", username);
        return "historical-questions";
    }

    //获取所有用户回答过的问题
    @RequestMapping(value = "get_all_question_ajax", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllQuestion(int page_current, int page_size) {
        Map<String, Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current - 1) * page_size);
        List<Question> questions = questionService.selectAllQuestion(pageVo);
        pageVo.setPage_count(questionService.selectAllQuestionCount());
        map.put("questions", questions);
        map.put("pageVo", pageVo);
        String s = JSON.toJSONString(map);
        System.out.println(s);
        return s;
    }

    //manager问题修改功能实现Ajax异步请求
    @RequestMapping(value = "manager_editor_question", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String managerEditorQuestion(String question_id) throws IOException {
        Question question = questionService.selectTitleToDetails(Integer.parseInt(question_id));
        String json = JSON.toJSONString(question);
        return json;
    }

    //manager问题修改更新功能实现
    @RequestMapping(value = "manager_update_one_question", method = RequestMethod.POST)
    public String managerUpdateOneQuestion(Question question) {
        System.out.println(question);
        boolean b = questionService.updateOneQuestionOptimal(question);
        return "redirect:manager_to_question";
    }

    //manager问题删除
    @RequestMapping(value = "manager_delect_one_question", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public boolean managerDelectOneQuestion(String question_id) {
        boolean b = questionService.delectOneQuestionById(Integer.parseInt(question_id));
        return b;
    }

    //过滤前台传过来的时间格式
    @InitBinder
    public void InitBinder(ServletRequestDataBinder binder) {
        //注册自定义的编辑器,后面的true代表的是 允许为null  false 不允许null
        binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));
    }

    //manager搜索查询用户信息
    @RequestMapping(value = "manager_select_Question", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String managerSelectQuestion(String search, int page_current, int page_size) {
        System.out.println("------------------" + search);
        Map<String, Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setSearch(search);
        pageVo.setPage_count(questionService.selectMoHuQuestionCount(search));
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current - 1) * page_size);
        List<Question> questions = questionService.selectMoHuQuestion(pageVo);
        map.put("questions", questions);
        map.put("pageVo", pageVo);
        String json = JSON.toJSONString(map);
        return json;
    }
}
