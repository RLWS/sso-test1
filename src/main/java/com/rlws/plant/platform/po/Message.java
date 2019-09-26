package com.rlws.plant.platform.po;

import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;
import java.util.Date;

public class Message implements Serializable {
    private int id;
    private String content;
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date time;
    private int user_id_j;
    private int user_id_f;
    private int handle;
    private User user_f;
    private User user_j;

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

    public int getUser_id_j() {
        return user_id_j;
    }

    public void setUser_id_j(int user_id_j) {
        this.user_id_j = user_id_j;
    }

    public int getUser_id_f() {
        return user_id_f;
    }

    public void setUser_id_f(int user_id_f) {
        this.user_id_f = user_id_f;
    }

    public int getHandle() {
        return handle;
    }

    public void setHandle(int handle) {
        this.handle = handle;
    }

    public User getUser_f() {
        return user_f;
    }

    public void setUser_f(User user_f) {
        this.user_f = user_f;
    }

    public User getUser_j() {
        return user_j;
    }

    public void setUser_j(User user_j) {
        this.user_j = user_j;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", time=" + time +
                ", user_id_j=" + user_id_j +
                ", user_id_f=" + user_id_f +
                ", handle=" + handle +
                ", user_f=" + user_f +
                ", user_j=" + user_j +
                '}';
    }
}
