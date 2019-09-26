package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.AnswerMapper;
import com.rlws.plant.platform.po.Answer;
import com.rlws.plant.platform.service.AnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnswerServiceImpl implements AnswerService {

    @Autowired
    private AnswerMapper answerMapper;

    //用户回答问题
    public boolean userAnswerQuestion(Answer answer) {
        int i = answerMapper.insertOneAnswer(answer);
        return i > 0 ? true : false;
    }

    //判断用户是否回答过该问题
    public Answer selectUserAnswerQuestion(Answer answer) {
        Answer answer1 = answerMapper.selectUserAnswerQuestion(answer);
        return answer1;
    }

    //获取某个问题下的所有回答
    public List<Answer> getAllAnswerByQuestionId(int id) {
        List<Answer> answers = answerMapper.selectListAnswerByQuestionId(id);
        return answers;
    }

    //用户举报一个回答
    public Answer userReportAnswer(int id) {
        Answer answer = answerMapper.selectAnswerById(id);
        return answer;
    }

    //获取一个最佳回答
    public Answer selectOptimalAnswerById(int answerId) {
        Answer answer = answerMapper.selectOptimalAnswerById(answerId);
        return answer;
    }

    //用户点赞答案
    public boolean userClickOneAnswer(int answerId) {
        Answer answer = answerMapper.selectAnswerById(answerId);
        answer.setPraise(answer.getPraise() + 1);
        int i = answerMapper.updateOneAnswer(answer);
        return i > 0 ? true : false;
    }

    //删除一条Answer数据
    public boolean deleteOneAnswer(int answerId) {
        int i = answerMapper.deleteOneAnswer(answerId);
        return i > 0 ? true : false;
    }
}
