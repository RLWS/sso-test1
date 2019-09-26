package com.rlws.plant.platform.mapper;

import com.rlws.plant.platform.po.Answer;

import java.util.List;

public interface AnswerMapper {

    //插入一条Answer数据
    int insertOneAnswer(Answer answer);

    //判断用户是否回答过该问题
    Answer selectUserAnswerQuestion(Answer answer);

    //根据Id获取List<Answer>
    List<Answer> selectListAnswerByQuestionId(int answerId);

    //根据Id获取Answer
    Answer selectAnswerById(int answerId);

    //根据AnswerId获取一条Answer数据(optimal)最优答案
    Answer selectOptimalAnswerById(int answerId);

    //更新一条Answer数据
    int updateOneAnswer(Answer answer);

    //删除一条Answer数据
    int deleteOneAnswer(int answerId);
}
