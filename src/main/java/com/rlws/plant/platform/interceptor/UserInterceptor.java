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

@PropertySource("classpath:/plant-platform.properties")
public class UserInterceptor implements HandlerInterceptor {

    @Value("${sso.login.url}")
    private String url;

    private String token = null;

    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        User user = (User) httpServletRequest.getSession().getAttribute("user");
        if (user == null) {
            StringBuilder condition = new StringBuilder();
            Enumeration<String> paraNames = httpServletRequest.getParameterNames();
            for (Enumeration<String> e = paraNames; e.hasMoreElements(); ) {
                String thisName = e.nextElement();
                String thisValue = httpServletRequest.getParameter(thisName);
                if ("token".equals(thisName)) {//token存在
                    token = thisValue;
                    return true;
                } else {//token不存在
                    condition.append(thisName).append("=").append(thisValue).append("&");
                }
            }
            String urlT = httpServletRequest.getRequestURL().toString();
            //请求的url编码
            String encodeURL = URLEncoder.encode(urlT, "utf-8");
            //请求的condition编码
            String conditionT = URLEncoder.encode(condition.toString(), "utf-8");
            //页面重定向到注册中心
            httpServletResponse.sendRedirect("http://" + url + "/index?requestUrl=" + encodeURL+"&condition="+conditionT);
            System.out.println("http://" + url + "/index?requestUrl=" + encodeURL+"&condition="+conditionT);
            return false;
        }
        return true;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) {
        modelAndView.addObject("token",token);
    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        System.out.println("token::::"+token);
    }
}
