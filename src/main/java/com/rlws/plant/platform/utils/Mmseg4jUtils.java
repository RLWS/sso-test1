package com.rlws.plant.platform.utils;

import com.chenlb.mmseg4j.*;

import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

/**
 * Mmseg4j 分词工具类
 * <p>Title: Mmseg4jUtils</p>
 */
public final class Mmseg4jUtils {
    /* 分词功能 */
/*    public static List<String> getMnseg(String txt) throws IOException {
        List<String> list = new ArrayList<String>();
        list.add(txt);
        //新建一个文件对象，词典的目录
        File file = new File("static/dic/float.dic");
        //建立词典实例，与比较老的版本中不相同。不能直接new。
        Dictionary dic = Dictionary.getInstance(file);
        Seg seg = null;
        seg = new ComplexSeg(dic);
        MMSeg mmSeg = new MMSeg(new StringReader(txt), seg);
        Word word = null;
        while ((word = mmSeg.next()) != null) {
            if (word != null && word.getLength() > 1) {
                list.add(word.toString());
            }
        }
        return list;
    }*/

    public static List<String> getMnseg(String txt) throws IOException {
        List<String> list = new ArrayList<String>();
        list.add(txt);
        Dictionary dic = Dictionary.getInstance("static/dic/");
        Seg seg = null;
        seg = new ComplexSeg(dic);
        MMSeg mmSeg = new MMSeg(new StringReader(txt), seg);
        Word word = null;
        while ((word = mmSeg.next()) != null) {
            if (word != null && word.getLength() > 1) {
                list.add(word.toString());
            }
        }
        return list;
    }

    /* 去除非中文 */
    public static String clearNotChinese(String buff) {

        String tmpString = buff.replaceAll("(?i)[^a-zA-Z0-9\u4E00-\u9FA5]", "");//去掉所有中英文符号
        char[] carr = tmpString.toCharArray();
        for (int i = 0; i < tmpString.length(); i++) {
            if (carr[i] < 0xFF) {
                carr[i] = ' ';//过滤掉非汉字内容
            }
        }
        return String.copyValueOf(carr).trim();
    }

    /* 实现关键字标记List */
    public static String titleConversion(String title , List<String> list){
        for (String str:list) {
            String name = "<b style=\"color: #fd8e3d\">"+ str +"</b>";
            title = title.replaceAll(str,name);
        }
        return title;
    }

    /* 实现关键字标记String */
    public static String titleConversion(String title , String search){
        String name = "<b style=\"color: #fd8e3d\">"+ search +"</b>";
        title = title.replaceAll(search,name);
        return title;
    }
}
