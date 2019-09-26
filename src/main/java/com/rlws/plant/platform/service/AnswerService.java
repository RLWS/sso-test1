package com.rlws.plant.platform.service;

import com.rlws.plant.platform.po.Answer;

import java.util.List;

public interface AnswerService {
    //用户回答问题
    boolean userAnswerQuestion(Answer answer);

    //判断用户是否回答过该问题
    Answer selectUserAnswerQuestion(Answer answer);

    //获取某个问题下的所有回答
    List<Answer> getAllAnswerByQuestionId(int id);

    //用户举报一个回答
    Answer userReportAnswer(int id);

    //根据AnswerId获取一条Answer数据(optimal)最优答案
    Answer selectOptimalAnswerById(int answerId);

    //用户点赞一条回答
    boolean userClickOneAnswer(int answerId);

    //删除一条Answer数据
    boolean deleteOneAnswer(int answerId);
}
