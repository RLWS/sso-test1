package com.rlws.plant.platform.mapper;

import com.rlws.plant.platform.po.Collect;
import com.rlws.plant.platform.po.PageVo;

import java.util.List;

public interface CollectMapper {

    //根据Praise查询是否存在该条数据
    Collect selectCollectByCollect(Collect collect);

    //插入一条Praise数据
    int insertOneCollect(Collect collect);

    //删除一条Collect数据
    int deleteOneCollect(int collectId);

    //根据userId查询List<Collect>的数量Count
    int selectCollectByUserIdCount(int userId);

    //根据userId查询List<Collect>
    List<Collect> selectCollectByUserId(PageVo pageVo);
}
