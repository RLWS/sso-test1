package com.rlws.plant.platform.service.impl;

import com.rlws.plant.platform.mapper.ReportMapper;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.Question;
import com.rlws.plant.platform.po.Report;
import com.rlws.plant.platform.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportMapper reportMapper;

    public boolean insertOneReport(Report report) {
        int i = reportMapper.insertOneReport(report);
        return i > 0 ? true : false;
    }

    //删除一条Report信息
    public boolean deleteOneReport(int reportId) {
        int i = reportMapper.deleteOneReport(reportId);
        return i > 0 ? true : false;
    }

    //查询出所有的Report信息(Question)
    public List<Report> selectAllReportQuestion(PageVo pageVo) {
        List<Report> reports = reportMapper.selectAllReportQuestion(pageVo);
        return reports;
    }

    //查询出所有的Report信息(Question)的数量Count
    public int selectAllReportQuestionCount() {
        int i = reportMapper.selectAllReportQuestionCount();
        return i;
    }

    //查询出所有的Report信息(Answer)
    public List<Report> selectAllReportAnswer(PageVo pageVo) {
        List<Report> reports = reportMapper.selectAllReportAnswer(pageVo);
        return reports;
    }

    //查询出所有的Report信息(Answer)的数量Count
    public int selectAllReportAnswerCount() {
        int i = reportMapper.selectAllReportAnswerCount();
        return i;
    }
}
