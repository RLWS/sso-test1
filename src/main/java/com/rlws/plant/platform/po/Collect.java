package com.rlws.plant.platform.po;

import java.io.Serializable;

public class Collect implements Serializable {

    private int id;
    private int user_id;
    private int question_id;
    private Question question;

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

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

    public int getQuestion_id() {
        return question_id;
    }

    public void setQuestion_id(int question_id) {
        this.question_id = question_id;
    }

    @Override
    public String toString() {
        return "Collect{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", question_id=" + question_id +
                ", question=" + question +
                '}';
    }
}
