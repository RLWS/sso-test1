package com.rlws.plant.platform.controller;

import com.alibaba.fastjson.JSON;
import com.rlws.plant.platform.po.Category;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.service.CategoryService;
import com.rlws.plant.platform.service.QuestionService;
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
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private QuestionService questionService;

    //前往user页面
    @RequestMapping(value = "user", method = RequestMethod.GET)
    public String user() {
        return "user/user";
    }

    //前往user_release页面
    @RequestMapping(value = "user_release", method = RequestMethod.GET)
    public String user_release(HttpServletRequest request) {
        List<Category> categories = categoryService.selectAllCategory(null);
        request.setAttribute("categories", categories);
        return "user/user-question-answer";
    }

    //点击类别进行查询,跳转到对应类别的问题列表
    @RequestMapping(value = "to_category_result", method = RequestMethod.GET)
    public String gotoCategoryResult(int category_id, HttpServletRequest request) {
        request.setAttribute("category_id", category_id);
        return "query-category-result";
    }

    //根据类别来查询某一类的新闻
    @ResponseBody
    @RequestMapping(value = "get_list_category_question_ajax", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    public String getListCategoryQuestionAjax(int category_id, int page_current, int page_size) {
        Map<String, Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setId(category_id);
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current - 1) * page_size);
        List<Question> questions = questionService.selectQuestionByCategoryId(pageVo);
        pageVo.setPage_count(questionService.selectQuestionByCategoryIdCount(category_id));
        map.put("questions", questions);
        map.put("pageVo", pageVo);
        String s = JSON.toJSONString(map);
        System.out.println(s);
        return s;
    }

    //管理员获取所有的类别
    @ResponseBody
    @RequestMapping(value = "manager_get_all_category", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    public String managerGetAllCategory(int page_current, int page_size) {
        Map<String, Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current - 1) * page_size);
        List<Category> categories = categoryService.selectLimitCategory(pageVo);
        pageVo.setPage_count(categoryService.selectAllCategory(new Category()).size());
        map.put("categories", categories);
        map.put("pageVo", pageVo);
        String s = JSON.toJSONString(map);
        System.out.println(s);
        return s;
    }

    //管理员添加一条类别
    @ResponseBody
    @RequestMapping(value = "manager_add_one_category", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    public Boolean managerAddOneCategory(Category category) {
        boolean b = categoryService.insertOneCategory(category);
        return b;
    }

    //管理员删除一条类别
    @ResponseBody
    @RequestMapping(value = "manager_delete_one_category", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    public Boolean managerDeleteOneCategory(int category_id) {
        boolean b = categoryService.deleteOneCategory(category_id);
        return b;
    }

    //管理员获取一条类别
    @ResponseBody
    @RequestMapping(value = "manager_select_one_category", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    public String managerSelectOneCategory(int category_id) {
        Category category = categoryService.selectOneCategoryById(category_id);
        String s = JSON.toJSONString(category);
        return s;
    }

    //管理员更新一条类别
    @ResponseBody
    @RequestMapping(value = "manager_update_one_category", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    public boolean managerUpdateOneCategory(Category category) {
        boolean b = categoryService.updateOneCategory(category);
        return b;
    }
}
