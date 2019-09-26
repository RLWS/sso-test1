package com.rlws.plant.platform.service;

import com.rlws.plant.platform.po.Collect;
import com.rlws.plant.platform.po.PageVo;

import java.util.List;

public interface CollectService {

    //查询判断该用户是否点赞过该问题
    boolean userClickQuestion(int user_id,int question_id);

    //插入一条Praise数据
    boolean insertOneCollect(Collect praise);

    //删除一条Collect数据
    boolean deleteOneCollect(int collectId);

    //根据userId查询List<Collect>的数量Count
    int selectUserAllCollectQuestionCount(int userId);

    //根据userId查询List<Collect>
    List<Collect> selectUserAllCollectQuestion(PageVo pageVo);
}
