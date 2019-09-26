package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.ReplyMapper;
import com.rlws.plant.platform.po.Reply;
import com.rlws.plant.platform.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    //用户评论回答
    public boolean userReplyAnswer(Reply reply) {
        int i = replyMapper.insertOneReply(reply);
        return i > 0 ? true : false;
    }

    //根据userId查询该用户的评论数量Count
    public int selectUserReplyCount(int userId) {
        int i = replyMapper.selectUserReplyCount(userId);
        return i;
    }
}
