package com.rlws.plant.platform.utils;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class HttpClientUtils {

    private static final String GET = "get";
    private static final String POST = "post";

    private static final String CONNECTION = "keep-alive";
    private static final String USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36";

    /**
     * get请求
     *
     * @param url 请求地址
     * @return BaseResult
     */
    public static String get(String url) {
        return createHttpCline(GET, url, null, null);
    }

    /**
     * get请求
     *
     * @param url    请求地址
     * @param cookie 需发送的cookie
     * @return BaseResult
     */
    public static String get(String url, String cookie) {
        return createHttpCline(GET, url, cookie, null);
    }

    /**
     * post请求
     *
     * @param url 请求地址
     * @return BaseResult
     */
    public static String post(String url) {
        return createHttpCline(POST, url, null, null);
    }

    /**
     * post请求
     *
     * @param url    请求地址
     * @param cookie 需发送的cookie
     * @return BaseResult
     */
    public static String post(String url, String cookie) {
        return createHttpCline(POST, url, cookie, null);
    }

    /**
     * post请求
     *
     * @param url    请求地址
     * @param cookie 需发送的cookie
     * @param map    请求参数
     * @return BaseResult
     */
    public static String post(String url, String cookie, Map<String, String> map) {
        return createHttpCline(POST, url, cookie, map);
    }

    /**
     * post请求
     *
     * @param url 请求地址
     * @param map 请求参数
     * @return BaseResult
     */
    public static String post(String url, Map<String, String> map) {
        return createHttpCline(POST, url, null, map);
    }

    /**
     * 发起请求
     *
     * @param request 请求方式  get/post
     * @param url     请求地址
     * @param cookie  请求cookie
     * @param map     请求参数
     * @return 返回的数据
     * @throws IOException
     */
    private static String createHttpCline(String request, String url, String cookie, Map<String, String> map) {
        String data = "";
        try {
            CloseableHttpClient httpClient = HttpClientBuilder.create().build();
            HttpGet httpGet = null;
            HttpPost httpPost = null;
            CloseableHttpResponse execute = null;

            //get请求
            if (GET.equals(request)) {
                httpGet = new HttpGet(url);
                httpGet.addHeader("Connection", CONNECTION);
                httpGet.addHeader("User-Agent", USER_AGENT);
                httpGet.addHeader("Cookie", cookie);
                //发起请求
                execute = httpClient.execute(httpGet);
            }
            //post请求
            else if (POST.equals(request)) {
                httpPost = new HttpPost(url);
                httpPost.addHeader("Connection", CONNECTION);
                httpPost.addHeader("User-Agent", USER_AGENT);
                httpPost.addHeader("Cookie", cookie);
                //填入参数
                List prams = null;
                if (map != null) {
                    prams = new ArrayList<NameValuePair>();
                    Set<String> keys = map.keySet();
                    for (String key : keys) {
                        prams.add(new BasicNameValuePair(key, map.get(key)));
                    }
                }
                //设置编码,避免乱码
                httpPost.setEntity(new UrlEncodedFormEntity(prams, "utf-8"));
                //发起请求
                execute = httpClient.execute(httpPost);
            }
            HttpEntity entity = execute.getEntity();
            data = EntityUtils.toString(entity);
            return data;
        } catch (IOException e) {
            e.printStackTrace();

        }
        return data;
    }
}
