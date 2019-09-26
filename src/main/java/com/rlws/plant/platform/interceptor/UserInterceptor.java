package com.rlws.plant.platform.interceptor;

import com.rlws.plant.platform.po.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.net.URLEncoder;

@PropertySource("classpath:/plant-platform.properties")
public class UserInterceptor implements HandlerInterceptor {

    @Value("${sso.login.url}")
    private String url;

    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        User user = (User) httpServletRequest.getSession().getAttribute("user");
        if (user == null) {
            String encodeURL = URLEncoder.encode(httpServletRequest.getRequestURL().toString(), "utf-8");
            //String decodeURL = URLDecoder.decode(httpServletRequest.getRequestURL().toString(), "utf-8");
//            httpServletResponse.sendRedirect("https://www.baidu.com");
            httpServletResponse.sendRedirect("http://"+url + "/index?requestUrl=" + encodeURL);
            System.out.println(url + "/index?requestUrl=" + encodeURL);
            return false;
        }else {
            System.out.println("not null");
        }
//        Map<String, String[]> parameterMap = httpServletRequest.getParameterMap();
//        String tokens = parameterMap.get("token")[0];
//        if (tokens != null && tokens != "") {
//
//        }
        return true;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
