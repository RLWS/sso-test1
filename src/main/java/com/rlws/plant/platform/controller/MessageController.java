package com.rlws.plant.platform.controller;

import com.alibaba.fastjson.JSON;
import com.rlws.plant.platform.mapper.UserMapper;
import com.rlws.plant.platform.po.Message;
import com.rlws.plant.platform.po.Reply;
import com.rlws.plant.platform.po.User;
import com.rlws.plant.platform.service.MessageService;
import com.rlws.plant.platform.service.impl.ReplyServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private UserMapper userMapper;

    //用户前往我的消息页面
    @RequestMapping(value = "user_to_message" , method = RequestMethod.GET)
    public String userToMessage(String id , String username, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        List<User> users = userMapper.selectAllMessageUser(user.getId());
        request.setAttribute("userList",users);
        request.setAttribute("userId", id);
        request.setAttribute("username", username);
        return "user/user-message";
    }

    //用户发送一条message信息
    @RequestMapping(value = "user_send_message_ajax" , method = RequestMethod.POST , produces = "application/json;charset=utf-8")
    @ResponseBody
    public String userSendMessage(Message message){
        Map<String,Object> map = new HashMap<String, Object>();
        message.setTime(new Date());
        message.setHandle(0);
        System.out.println(message);
        boolean b = messageService.insertOneMessage(message);
        map.put("boolean",b);
        if (b){
            map.put("message",message);
        }else {
            map.put("message","");
        }
        String s = JSON.toJSONString(map);
        return s;
    }

    //用户发送一条message信息
    @RequestMapping(value = "user_get_all_message_ajax" , method = RequestMethod.GET , produces = "application/json;charset=utf-8")
    @ResponseBody
    public String userGetAllMessage(Message message){
        Map<String,Object> map = new HashMap<String, Object>();
        List<Message> userAllMessage = messageService.getUserAllMessage(message);
        User user = userMapper.selectOneUserById(message.getUser_id_j());
        map.put("allMessage",userAllMessage);
        map.put("otherUser",user);
        String s = JSON.toJSONString(map);
        return s;
    }
}
