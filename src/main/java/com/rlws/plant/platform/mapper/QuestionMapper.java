package com.rlws.plant.platform.mapper;

import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;

import java.util.List;

public interface QuestionMapper {
    //插入一个question行
    int insertOneQuestion(Question question);

    //根据id主键来查询一条数据
    Question selectByPrimaryKey(int id);

    //获取最新插入的几条数据
    List<Question> selectLimitQuestion(int num);

    //获取最近一周点赞最多的num条数据
    List<Question> selectOneWeekLimitTitle(int num);

    //获取最近一个月回答最多的num条数据
    List<Question> selectOneWeekMostAnswerQuestion(int num);

    //获取最新插入的几条数据
    List<Question> selectLimitTitle(int num);

    //根据id主键来查询一条数据
    Question selectQuestionDetailsById(int id);

    //更新一条question数据
    int updateOneQuestion(Question question);

    //根据Title模糊查询Question集合
    List<Question> selectQuestionByBlurryTitle(List<String> list);

    //根据Title模糊查询Question集合Ajax
    List<Question> selectQuestionByBlurryTitleAjax(PageVo pageVo);

    //根据user.id查询一个Question集合
    List<Question> selectQuestionByUserId(PageVo pageVo);

    //根据categoryId查询一个Question集合的数量Count
    int selectQuestionByCategoryIdCount(int categoryId);

    //根据categoryId查询一个Question集合
    List<Question> selectQuestionByCategoryId(PageVo pageVo);

    //根据userId获取该用户的所有问题数量
    int selectUserAllQuestionByUserId(int userId);

    //查询出所有未回答的问题
    List<Question> selectQuestionAnswerZero(PageVo pageVo);

    //查询出所有未回答的问题的数量
    int selectQuestionAnswerZeroCount();

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
    int delectOneQuestionById(int questionId);

    //manager模糊查询Question的Id和Title字段
    List<Question> selectMoHuQuestion(PageVo pageVo);

    //manager模糊查询Question的Id和Title字段Count
   int selectMoHuQuestionCount(String search);

    //查询最近num天的紧急处理问题
    List<Question> selectUrgentQuestion(int num);

    //根据最佳答案查询一条Question详细数据
    Question selectQuestionDetailsByAnswerId(int answerId);
}
