package com.rlws.plant.platform.mapper;

import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.User;

import java.util.List;

public interface UserMapper {

    //根据id主键来对用户表进行查询
    User selectByPrimaryKey(User user);

    //根据id主键来对用户表进行查询
    User selectOneUserById(int userId);

    //更新user表数据
    int updateUser(User user);

    //插入user表数据
    int insertOneUser(User user);

    //根据userId获取用户获取最佳回答的数量Count
    int selectUserBestAnswerCount(int userId);

    //获取所有的用户的数量Count
    int selectAllUserCount();

    //获取用户的所有数量Ajax
    List<User> selectAllUser(PageVo pageVo);

    //删除一条User数据
    int delectOneUser(int userId);

    //模糊查询关键字段Count
    int selectMainUserCount(String str);

    //模糊查询关键字段
    List<User> selectMainUser(PageVo pageVo);

    //获取所有有信息来往的List<User>
    List<User> selectAllMessageUser(int userId);

}
