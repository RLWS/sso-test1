package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.CategoryMapper;
import com.rlws.plant.platform.po.Category;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    //获取所有植物的类别
    public List<Category> selectAllCategory(Category category) {
        return categoryMapper.selectAllCategory(category);
    }

    //根据Id获取一条植物类别
    public Category selectOneCategoryById(int categoryId) {
        Category category = categoryMapper.selectOneCategoryById(categoryId);
        return category;
    }

    //删除一个植物类别
    public boolean deleteOneCategory(int categoryId) {
        int i = categoryMapper.deleteOneCategory(categoryId);
        return i>0?true:false;
    }

    //插入一个植物类别
    public boolean insertOneCategory(Category category) {
        int i = categoryMapper.insertOneCategory(category);
        return i>0?true:false;
    }

    //修改一个植物类别
    public boolean updateOneCategory(Category category) {
        int i = categoryMapper.updateOneCategory(category);
        return i>0?true:false;
    }

    //查询一部分植物类别Ajax
    public List<Category> selectLimitCategory(PageVo pageVo) {
        List<Category> categories = categoryMapper.selectLimitCategory(pageVo);
        return categories;
    }
}
