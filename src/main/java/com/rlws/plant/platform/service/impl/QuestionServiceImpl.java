package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.QuestionMapper;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.service.QuestionService;
import com.rlws.plant.platform.utils.Mmseg4jUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionMapper questionMapper;

    //用户对问题进行发布
    public boolean userReleaseQuestion(Question question) {
        int i = questionMapper.insertOneQuestion(question);
        return i > 0 ? true : false;
    }

    //更新一条最佳答案
    public boolean updateOneQuestionOptimal(Question question) {
        int i = questionMapper.updateOneQuestion(question);
        return i > 0 ? true : false;
    }

    //根据点击的问题id来获取该问题的详细信息
    public Question selectQuestionById(int id) {
        return questionMapper.selectByPrimaryKey(id);
    }

    //获取最新的num条新闻
    public List<Question> selectNewQuestion(int num) {
        List<Question> questions = questionMapper.selectLimitQuestion(6);
        return questions;
    }

    //获取最近一周最热的num条新闻
    public List<Question> selectOneWeekLimitTitle(int num) {
        List<Question> questions = questionMapper.selectOneWeekLimitTitle(num);
        return questions;
    }

    //获取最近一个月回答最多的num条数据
    public List<Question> selectOneWeekMostAnswerQuestion(int num) {
        List<Question> questions = questionMapper.selectOneWeekMostAnswerQuestion(num);
        return questions;
    }

    //获取最新发布的几条新闻
    public List<Question> selectNewTitle(int num) {
        List<Question> questionDetails = questionMapper.selectLimitTitle(num);
        return questionDetails;
    }

    //当用户点击页面Title时,根据Id来从数据库获取一个QuestionDetails对象
    public Question selectTitleToDetails(int id) {
        Question questionDetails = questionMapper.selectQuestionDetailsById(id);
        return questionDetails;
    }

    //实现用户的搜索功能
    public List<Question> userSearcherQuestion(String txt) throws IOException {
        List<String> mnseg = Mmseg4jUtils.getMnseg(txt);
        List<Question> questions = questionMapper.selectQuestionByBlurryTitle(mnseg);
        for (Question question : questions) {
            //关键字高亮实现
            question.setTitle(Mmseg4jUtils.titleConversion(question.getTitle(), mnseg));
            //去除非中文
            question.setContent(Mmseg4jUtils.clearNotChinese(question.getContent()));
        }
        return questions;
    }

    //实现用户的搜索功能Ajax
    public List<Question> userSearcherQuestionAjax(PageVo pageVo, String searchTitle) throws IOException {
        List<String> mnseg = Mmseg4jUtils.getMnseg(searchTitle);
        pageVo.setStrList(mnseg);
        List<Question> questions = questionMapper.selectQuestionByBlurryTitleAjax(pageVo);
        for (Question question : questions) {
            //关键字高亮实现
            question.setTitle(Mmseg4jUtils.titleConversion(question.getTitle(), mnseg));
            //去除非中文
            question.setContent(Mmseg4jUtils.clearNotChinese(question.getContent()));
        }
        return questions;
    }

    //根据userId查询一个Question集合
    public List<Question> getUserAllQuestionByUserId(PageVo pageVo) {
        List<Question> questions = questionMapper.selectQuestionByUserId(pageVo);
        for (Question question : questions) {
            //去除非中文
            question.setContent(Mmseg4jUtils.clearNotChinese(question.getContent()));
        }
        return questions;
    }

    //根据categoryId查询一个Question集合的数量Count
    public int selectQuestionByCategoryIdCount(int categoryId) {
        int i = questionMapper.selectQuestionByCategoryIdCount(categoryId);
        return i;
    }

    //根据categoryId查询一个Question集合
    public List<Question> selectQuestionByCategoryId(PageVo pageVo) {
        List<Question> questions = questionMapper.selectQuestionByCategoryId(pageVo);
        for (Question question : questions) {
            //去除非中文
            question.setContent(Mmseg4jUtils.clearNotChinese(question.getContent()));
            //关键字高亮实现
            question.getCategory().setContent("<b style=\"color: #fd8e3d\">" + question.getCategory().getContent() + "</b>");
        }
        return questions;
    }

    //根据userId获取该用户的所有问题数量
    public int selectUserAllQuestionCountByUserId(int userId) {
        int i = questionMapper.selectUserAllQuestionByUserId(userId);
        return i;
    }

    //查询出所有未回答的问题
    public List<Question> questionNotAnswer(PageVo pageVo) {
        List<Question> questions = questionMapper.selectQuestionAnswerZero(pageVo);
        for (Question question : questions) {
            //去除非中文
            question.setContent(Mmseg4jUtils.clearNotChinese(question.getContent()));
        }
        return questions;
    }

    //查询出所有未回答的问题的数量
    public int questionNotAnswerCount() {
        return questionMapper.selectQuestionAnswerZeroCount();
    }

    //查询出用户所有回答过的问题
    public List<Question> selectUserAllAnswerQuestion(PageVo pageVo) {
        List<Question> questions = questionMapper.selectUserAllAnswerQuestion(pageVo);
        for (Question question : questions) {
            //去除非中文
            question.setContent(Mmseg4jUtils.clearNotChinese(question.getContent()));
        }
        return questions;
    }

    //查询出用户所有回答过的问题的数量
    public int selectUserAllAnswerQuestionCount(int userId) {
        int i = questionMapper.selectUserAllAnswerQuestionCount(userId);
        return i;
    }

    //查询出一个问题被回答的数量
    public int selectQuestionAnswerCount(int questionId) {
        int i = questionMapper.selectQuestionAnswerCount(questionId);
        return i;
    }

    //获取所有的问题
    public List<Question> selectAllQuestion(PageVo pageVo) {
        List<Question> questions = questionMapper.selectAllQuestion(pageVo);
        for (Question question : questions) {
            //去除非中文
            question.setContent(Mmseg4jUtils.clearNotChinese(question.getContent()));
        }
        return questions;
    }

    //获取所有问题的数量
    public int selectAllQuestionCount() {
        int i = questionMapper.selectAllQuestionCount();
        return i;
    }
    //删除一条Question数据
    public boolean delectOneQuestionById(int questionId) {
        int i = questionMapper.delectOneQuestionById(questionId);
        return i > 0 ? true : false;
    }

    //manager模糊查询Question的Id和Title字段
    public List<Question> selectMoHuQuestion(PageVo pageVo) {
        List<Question> questions = questionMapper.selectMoHuQuestion(pageVo);
        for (Question question : questions) {
            //去除非中文
            question.setContent(Mmseg4jUtils.clearNotChinese(question.getContent()));
            question.setTitle(Mmseg4jUtils.titleConversion(question.getTitle(),pageVo.getSearch()));
        }
        return questions;
    }

    //获取模糊查询结果的Count数
    public int selectMoHuQuestionCount(String search) {
        int i = questionMapper.selectMoHuQuestionCount(search);
        return i;
    }

    //查询最近num天的紧急处理问题
    public List<Question> selectUrgentQuestion(int num) {
        List<Question> questions = questionMapper.selectUrgentQuestion(num);
        return questions;
    }

    //根据最佳答案查询一条Question详细数据
    public Question selectQuestionDetailsByAnswerId(int answerId) {
        Question question = questionMapper.selectQuestionDetailsByAnswerId(answerId);
        return question;
    }


}
