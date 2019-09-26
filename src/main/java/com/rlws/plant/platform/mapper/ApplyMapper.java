package com.rlws.plant.platform.mapper;

import com.rlws.plant.platform.po.Apply;
import com.rlws.plant.platform.po.PageVo;

import java.util.List;

public interface ApplyMapper {

    //插入一条Reply数据
    int insertOneApply(Apply apply);

    //获取一条Apply数据
    Apply selectOneApply(int applyId);

    //获取所有的数据
    List<Apply> selectAllApply(PageVo pageVo);

    //获取所有的数据数量Count
    int selectAllApplyCount();

    //删除一条Apply数据
    int deleteOneApply(int applyId);

    //更新一条Apply数据
    int updateOneApply(Apply apply);

}
