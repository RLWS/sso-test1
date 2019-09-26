package com.rlws.po.test;

import com.rlws.plant.platform.utils.Mmseg4jUtils;
import org.junit.Test;
import java.io.IOException;
import java.util.List;

public class Mmseg4JTest {
    @Test
    public void test() throws IOException {
        List<String> mnseg = Mmseg4jUtils.getMnseg("家里的海洋薰衣草怎么变黄了");
        System.out.println(mnseg);
        System.out.println(Math.ceil((double) 4/4));
    }
}