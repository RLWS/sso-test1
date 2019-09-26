package com.rlws.plant.platform.mapper;

import com.rlws.plant.platform.po.Manager;

public interface ManagerMapper {

    //查询一条Manager信息
    Manager selectManagerById(String email);
}
