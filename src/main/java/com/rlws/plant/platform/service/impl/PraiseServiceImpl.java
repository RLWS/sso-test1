package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.PraiseMapper;
import com.rlws.plant.platform.po.Praise;
import com.rlws.plant.platform.service.PraiseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PraiseServiceImpl implements PraiseService {

    @Autowired
    private PraiseMapper praiseMapper;

    //判断回答是否已被点赞过
    public Praise selectPraiseByPraise(Praise praise) {
        Praise praise1 = praiseMapper.selectPraiseByPraise(praise);
        return praise1;
    }

    //点赞回答成功,存入数据库中
    public boolean insertOnePraise(Praise praise) {
        int i = praiseMapper.insertOnePraise(praise);
        return i > 0 ? true : false;
    }
}
