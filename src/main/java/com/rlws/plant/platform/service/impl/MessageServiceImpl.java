package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.MessageMapper;
import com.rlws.plant.platform.po.Message;
import com.rlws.plant.platform.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageMapper messageMapper;

    //插入一条Message数据
    public boolean insertOneMessage(Message message) {
        int i = messageMapper.insertOneMessage(message);
        return i > 0 ? true : false;
    }

    //根据用户的Id获取所有Message
    public List<Message> getUserAllMessage(Message message) {
        List<Message> userAllMessage = messageMapper.getUserAllMessage(message);
        return userAllMessage;
    }
}
