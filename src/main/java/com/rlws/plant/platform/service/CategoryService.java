package com.rlws.plant.platform.service;

import com.rlws.plant.platform.po.Category;
import com.rlws.plant.platform.po.PageVo;

import java.util.List;

public interface CategoryService {

    //获取所有植物的类别
    List<Category> selectAllCategory(Category category);

    //根据Id获取一条植物类别
    Category selectOneCategoryById(int categoryId);

    //删除一个植物类别
    boolean deleteOneCategory(int categoryId);

    //插入一个植物类别
    boolean insertOneCategory(Category category);

    //修改一个植物类别
    boolean updateOneCategory(Category category);

    //获取所有的植物类别Ajax
    List<Category> selectLimitCategory(PageVo pageVo);
}
