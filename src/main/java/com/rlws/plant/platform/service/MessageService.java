package com.rlws.plant.platform.service;

import com.rlws.plant.platform.po.Message;

import java.util.List;

public interface MessageService {

    //插入一条Message数据
    boolean insertOneMessage(Message message);

    //根据用户的Id获取所有Message
    List<Message> getUserAllMessage(Message message);

}
