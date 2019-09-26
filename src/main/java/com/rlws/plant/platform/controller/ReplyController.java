package com.rlws.plant.platform.controller;

import com.rlws.plant.platform.po.Reply;
import com.rlws.plant.platform.service.impl.ReplyServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
public class ReplyController {

    @Autowired
    private ReplyServiceImpl replyService;

    //用户对回答进行评论
    @RequestMapping(value = "user_reply_answer" , method = RequestMethod.POST)
    @ResponseBody
    public boolean userReplyAnswer(Reply reply){
        reply.setTime(new Date());
        return replyService.userReplyAnswer(reply);
    }
}
