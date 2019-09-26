package com.rlws.plant.platform.po;

import java.io.Serializable;
import java.util.List;

public class PageVo implements Serializable {

    //根据Id查可用
    private int id;
    //根据List<String>查可以用
    private List<String> strList;

    //根据String查可以用
    private String search;

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }
    private int page_start;
    private int page_size;
    private int page_current;
    private int page_count;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPage_start() {
        return page_start;
    }

    public void setPage_start(int page_start) {
        this.page_start = page_start;
    }

    public int getPage_size() {
        return page_size;
    }

    public void setPage_size(int page_size) {
        this.page_size = page_size;
    }

    public int getPage_current() {
        return page_current;
    }

    public void setPage_current(int page_current) {
        this.page_current = page_current;
    }

    public int getPage_count() {
        return page_count;
    }

    public void setPage_count(int page_count) {
        this.page_count = page_count;
    }

    public List<String> getStrList() {
        return strList;
    }

    public void setStrList(List<String> strList) {
        this.strList = strList;
    }
}
