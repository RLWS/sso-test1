package com.rlws.plant.platform.service;

import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;

import java.io.IOException;
import java.util.List;

public interface QuestionService {

    //用户对问题进行发布
    boolean userReleaseQuestion(Question question);

    //更新一条Question数据,将最佳答案记录进去
    boolean updateOneQuestionOptimal(Question question);

    //当用户点击页面标签是,根据Id来从数据库获取一个Question对象
    Question selectQuestionById(int id);

    //获取最新发布的num条新闻
    List<Question> selectNewQuestion(int num);

    //获取最近一周点赞最多的num条数据
    List<Question> selectOneWeekLimitTitle(int num);

    //获取最近一个月回答最多的num条数据
    List<Question> selectOneWeekMostAnswerQuestion(int num);

    //获取最新发布的num条新闻
    List<Question> selectNewTitle(int num);

    //当用户点击页面Title时,根据Id来从数据库获取一个QuestionDetails对象
    Question selectTitleToDetails(int id);

    //用户查询并获取查询结果List<Question>
    List<Question> userSearcherQuestion(String txt) throws IOException;

    //用户查询并获取查询结果List<Question>异步实现Ajax
    List<Question> userSearcherQuestionAjax(PageVo pageVo ,String searchTitle) throws IOException;

    //根据userId查询一个Question集合
    List<Question> getUserAllQuestionByUserId(PageVo pageVo);

    //根据categoryId查询一个Question集合的数量Count
    int selectQuestionByCategoryIdCount(int categoryId);

    //根据categoryId查询一个Question集合
    List<Question> selectQuestionByCategoryId(PageVo pageVo);

    //根据userId获取该用户的所有问题数量
    int selectUserAllQuestionCountByUserId(int userId);

    //查询出所有未回答的问题
    List<Question> questionNotAnswer(PageVo pageVo);

    //查询出所有未回答的问题的数量
    int questionNotAnswerCount();

    //查询出用户回答过的所有问题
    List<Question> selectUserAllAnswerQuestion(PageVo pageVo);

    //查询出用户回答过的所有问题的数量
    int selectUserAllAnswerQuestionCount(int userId);

    //查询一条问题的回答数量
    int selectQuestionAnswerCount(int questionId);

    //获取所有的question的List -->
    List<Question> selectAllQuestion(PageVo pageVo);

    //获取所有的question的数量Count
    int selectAllQuestionCount();

    //删除一条Question数据
    boolean delectOneQuestionById(int questionId);

    //manager模糊查询Question的Id和Title字段
    List<Question> selectMoHuQuestion(PageVo pageVo);

    //manager模糊查询Question的Id和Title字段Count
    int selectMoHuQuestionCount(String search);

    //查询最近num天的紧急处理问题
    List<Question> selectUrgentQuestion(int num);

    //根据最佳答案查询一条Question详细数据
    Question selectQuestionDetailsByAnswerId(int answerId);
}
