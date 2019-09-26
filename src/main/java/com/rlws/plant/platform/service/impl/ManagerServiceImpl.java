package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.ManagerMapper;
import com.rlws.plant.platform.po.Manager;
import com.rlws.plant.platform.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    private ManagerMapper managerMapper;

    public Manager managerLogin(String email) {
        Manager manager = managerMapper.selectManagerById(email);
        return manager;
    }
}
