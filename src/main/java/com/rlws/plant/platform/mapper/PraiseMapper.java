package com.rlws.plant.platform.mapper;

import com.rlws.plant.platform.po.Praise;

public interface PraiseMapper {

    //根据Praise查询是否存在该条数据
    Praise selectPraiseByPraise(Praise praise);

    //插入一条Praise数据
    int insertOnePraise(Praise praise);
}
