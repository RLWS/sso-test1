package com.rlws.plant.platform.service;

import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Recommendation;

import java.util.List;

public interface RecommendationService {

    //达人用户添加一个推荐文章
    boolean userAddOneRecommendation(Recommendation recommendation);

    //根据userId来获取达人用户的所有推荐文章
    List<Recommendation> selectRecommendationByUserId(PageVo pageVo);

    //根据userId来获取他发布的推荐文章数量
    int selectUserIdAllRecommendationCount(int userId);

    //根据RecommendationId来获取Recommendation
    Recommendation selectRecommendationById(int recommendationId);

    //获取最新的num条Recommendation数据
    List<Recommendation> selectNewNumRecommendation(int num);

    //根据Id删除一条Recommendation数据
    boolean deleteRecommendationById(int id);

    //获取所有的推荐文章的数量Count
    int selectAllRecommendationCount();

    //获取所有的推荐文章
    List<Recommendation> selectAllRecommendation(PageVo pageVo);

    //更新一条Recommendation数据
    boolean updateOneRecommendation(Recommendation recommendation);
}
