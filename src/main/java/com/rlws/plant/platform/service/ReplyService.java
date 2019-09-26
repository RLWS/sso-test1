package com.rlws.plant.platform.service;

import com.rlws.plant.platform.po.Reply;

public interface ReplyService {

    //用户评论回答
    boolean userReplyAnswer(Reply reply);

    //根据userId查询该用户的评论数量Count
    int selectUserReplyCount(int userId);

}
