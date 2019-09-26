package com.rlws.plant.platform.service;

import com.rlws.plant.platform.po.Manager;

public interface ManagerService {

    //管理员登录
    Manager managerLogin(String email);
}
