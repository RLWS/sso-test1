package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.RecommendationMapper;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.po.Recommendation;
import com.rlws.plant.platform.service.RecommendationService;
import com.rlws.plant.platform.utils.Mmseg4jUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecommendationServiceImpl implements RecommendationService {

    @Autowired
    private RecommendationMapper recommendationMapper;

    //达人用户添加一个推荐文章
    public boolean userAddOneRecommendation(Recommendation recommendation) {
        int i = recommendationMapper.insertOneRecommendation(recommendation);
        return i > 0 ? true : false;
    }

    //大人用户获取自身发布的所有文章
    public List<Recommendation> selectRecommendationByUserId(PageVo pageVo) {
        List<Recommendation> recommendations = recommendationMapper.selectRecommendationByUserId(pageVo);
        for (Recommendation recommendation : recommendations) {
            //去除非中文
            recommendation.setContent(Mmseg4jUtils.clearNotChinese(recommendation.getContent()));
        }
        return recommendations;
    }

    //大人用户获取自身发布的所有文章的数量
    public int selectUserIdAllRecommendationCount(int userId) {
        int i = recommendationMapper.selectUserIdAllRecommendationCount(userId);
        return i;
    }

    //获取文章的详情
    public Recommendation selectRecommendationById(int recommendationId) {
        Recommendation recommendation = recommendationMapper.selectRecommendationById(recommendationId);
        return recommendation;
    }

    //获取最新的num条recommendation数据
    public List<Recommendation> selectNewNumRecommendation(int num) {
        List<Recommendation> recommendations = recommendationMapper.selectNewNumRecommendation(num);
        for (Recommendation recommendation : recommendations) {
            //去除非中文
            recommendation.setContent(Mmseg4jUtils.clearNotChinese(recommendation.getContent()));
        }
        return recommendations;
    }

    //删除一条recommendation数据
    public boolean deleteRecommendationById(int id) {
        int i = recommendationMapper.deleteRecommendationById(id);
        return i > 0 ? true : false;
    }

    //获取所有的推荐文章的数量Count
    public int selectAllRecommendationCount() {
        int i = recommendationMapper.selectAllRecommendationCount();
        return i;
    }

    //获取所有的推荐文章
    public List<Recommendation> selectAllRecommendation(PageVo pageVo) {
        List<Recommendation> recommendations = recommendationMapper.selectAllRecommendation(pageVo);
        for (Recommendation recommendation : recommendations) {
            //去除非中文
            recommendation.setContent(Mmseg4jUtils.clearNotChinese(recommendation.getContent()));
        }
        return recommendations;
    }

    //更新一条Recommendation数据
    public boolean updateOneRecommendation(Recommendation recommendation) {
        int i = recommendationMapper.updateOneRecommendation(recommendation);
        return i > 0 ? true : false;
    }
}
