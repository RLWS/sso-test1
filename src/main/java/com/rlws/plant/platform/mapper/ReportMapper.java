package com.rlws.plant.platform.mapper;

import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Report;

import java.util.List;

public interface ReportMapper {

    //插入一条Praise数据
    int insertOneReport(Report report);

    //删除一条Report信息
    int deleteOneReport(int reportId);

    //查询出所有的Report信息(Question)
    List<Report> selectAllReportQuestion(PageVo pageVo);

    //查询出所有的Report信息(Question)的数量Count
    int selectAllReportQuestionCount();

    //查询出所有的Report信息(Answer)
    List<Report> selectAllReportAnswer(PageVo pageVo);

    //查询出所有的Report信息(Answer)的数量Count
    int selectAllReportAnswerCount();
}
