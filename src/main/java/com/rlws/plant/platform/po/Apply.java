package com.rlws.plant.platform.po;

import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;
import java.util.Date;

public class Apply implements Serializable {
    private int id;
    private String content;
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date time;
    private int handle;
    private int user_id;
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getHandle() {
        return handle;
    }

    public void setHandle(int handle) {
        this.handle = handle;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "Apply{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", time=" + time +
                ", handle=" + handle +
                ", user_id=" + user_id +
                ", user=" + user +
                '}';
    }
}
