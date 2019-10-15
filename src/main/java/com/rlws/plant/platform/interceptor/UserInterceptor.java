package com.rlws.plant.platform.interceptor;

import com.rlws.plant.platform.po.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map;

@PropertySource("classpath:/plant-platform.properties")
public class UserInterceptor implements HandlerInterceptor {

    @Value("${sso.login.url}")
    private String url;

    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        User user = (User) httpServletRequest.getSession().getAttribute("user");
        if (user == null) {
            Enumeration<String> paraNames = httpServletRequest.getParameterNames();
            StringBuilder condition = new StringBuilder();
            for (Enumeration<String> e = paraNames; e.hasMoreElements(); ) {
                String thisName = e.nextElement();
                String thisValue = httpServletRequest.getParameter(thisName);
                System.out.println("param的key:" + thisName + "--------------param的value:" + thisValue);
                if ("token".equals(thisName)) {//token存在
                    return true;
                } else {//token不存在
                    condition.append(thisName).append("=").append(thisValue).append("&");
                }
            }
            System.out.println(httpServletRequest.getRequestURL().toString() + condition);
            //请求的url编码
            String encodeURL = URLEncoder.encode(httpServletRequest.getRequestURL().toString() + "?" + condition, "utf-8");
            //页面重定向到注册中心
            httpServletResponse.sendRedirect("http://" + url + "/index?requestUrl=" + encodeURL);
            System.out.println(url + "/index?requestUrl=" + encodeURL);
            return false;
        }
        return true;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
