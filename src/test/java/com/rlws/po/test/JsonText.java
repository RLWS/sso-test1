package com.rlws.po.test;

import com.alibaba.druid.support.json.JSONParser;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.junit.Test;

import java.util.ListIterator;

public class JsonText {

    @Test
    public void jsonT(){
        String json = "[\"24\",\"25\"]";
        Object parse = JSON.parse(json);
        JSONArray objects = JSON.parseArray(json);
        for (int i = 0 ; i < objects.size() ; i++){
            Integer integer = objects.getInteger(i);
            System.out.println(integer);
        }


    }
}
