package com.rlws.plant.platform.po;

import java.io.Serializable;

public class Praise implements Serializable {
    private int id;
    private int user_id;
    private int answer_id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getAnswer_id() {
        return answer_id;
    }

    public void setAnswer_id(int answer_id) {
        this.answer_id = answer_id;
    }

    @Override
    public String toString() {
        return "Praise{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", answer_id=" + answer_id +
                '}';
    }
}
