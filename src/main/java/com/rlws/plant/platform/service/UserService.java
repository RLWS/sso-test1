package com.rlws.plant.platform.service;

import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.User;

import java.util.List;

public interface UserService {

    //查询一条User信息 -->
    User selectByPrimaryKey(User user);

    //根据用户email和power来判断能否登录成功
    User userLogin(String email);

    //根据id主键来对用户表进行查询
    User selectOneUserById(int userId);

    //更新用户表数据(密码或其他信息)
    boolean updateUser(User user);

    //插入一条user表数据(注册)
    boolean userRegistration(User user);

    //根据userId获取用户获取最佳回答的数量Count
    int selectUserBestAnswerCount(int userId);

    //获取所有的用户的数量Count
    int selectAllUserCount();

    //获取用户的所有数量Ajax
    List<User> selectAllUser(PageVo pageVo);

    //删除一条User数据
    boolean delectOneUser(int userId);

    //模糊查询关键字段Count
    int selectMainUserCount(String str);

    //模糊查询关键字段
    List<User> selectMainUser(PageVo pageVo);

    //获取所有有信息来往的List<User>
    List<User> selectAllMessageUser(int userId);
}
