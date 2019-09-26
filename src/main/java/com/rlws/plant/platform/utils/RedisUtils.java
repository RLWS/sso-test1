package com.rlws.plant.platform.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

@Component
public class RedisUtils {

    private JedisPool jedisPool;

    private Jedis getJedis(){
        return jedisPool.getResource();
    }

    /**
     * 保存一个永久的String类型
     * @param key   键
     * @param value 值
     * @return
     */
    public String stringSet(String key , String value){
        String set = getJedis().set(key, value);
        return set;
    }

    /**
     * 保存一个限时的String类型
     * @param key   键
     * @param value 值
     * @param expire    时间(单位:秒)
     * @return
     */
    public Long stringSet(String key,String value ,int expire){
        String set = getJedis().set(key, value);
        Long expire1 = getJedis().expire(key, expire);
        return expire1;
    }
}
