package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.CollectMapper;
import com.rlws.plant.platform.mapper.QuestionMapper;
import com.rlws.plant.platform.po.Collect;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.service.CollectService;
import com.rlws.plant.platform.utils.Mmseg4jUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CollectServiceImpl implements CollectService {

    @Autowired
    private CollectMapper collectMapper;

    @Autowired
    private QuestionMapper questionMapper;

    //查询判断该用户是否点赞过该问题
    public boolean userClickQuestion(int user_id,int question_id) {
        Collect collect = new Collect();
        collect.setUser_id(user_id);
        collect.setQuestion_id(question_id);
        Collect praise1 = collectMapper.selectCollectByCollect(collect);
        //判断是否已被点赞
        if (praise1 != null){
            //已点赞
            return false;
        }else{
            //未点赞
            int i = collectMapper.insertOneCollect(collect);
            if (i > 0){
                Question question = questionMapper.selectQuestionDetailsById(question_id);
                System.out.println("user_id"+question.getUser_id());
                System.out.println("category_id"+question.getCategory().getId());
                System.out.println(""+question.toString());
                question.setPraise(question.getPraise()+1);
                int i1 = questionMapper.updateOneQuestion(question);
                return i1 > 0 ? true : false;
            }
        }
        return praise1 == null ? false : true;
    }

    //将点赞的用户id和问题id存入Praise表中
    public boolean insertOneCollect(Collect collect) {
        int i = collectMapper.insertOneCollect(collect);
        return i > 0 ? true : false;
    }

    //(用户取消对问题的收藏)删除一条Collect数据
    public boolean deleteOneCollect(int collectId) {
        int i = collectMapper.deleteOneCollect(collectId);
        return i>0?true:false;
    }

    //查询用户所有的收藏问题的总数
    public int selectUserAllCollectQuestionCount(int userId) {
        int i = collectMapper.selectCollectByUserIdCount(userId);
        return i;
    }

    //根据userId查询List<Collect>
    public List<Collect> selectUserAllCollectQuestion(PageVo pageVo) {
        List<Collect> collects = collectMapper.selectCollectByUserId(pageVo);
        for (Collect collect : collects) {
            //去除非中文
            collect.getQuestion().setContent(Mmseg4jUtils.clearNotChinese(collect.getQuestion().getContent()));
        }
        return collects;
    }
}
