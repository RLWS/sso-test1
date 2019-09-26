package com.rlws.plant.platform.controller;

import com.alibaba.fastjson.JSON;
import com.rlws.plant.platform.po.Category;
import com.rlws.plant.platform.po.Manager;
import com.rlws.plant.platform.po.PageVo;
import com.rlws.plant.platform.po.User;
import com.rlws.plant.platform.service.CategoryService;
import com.rlws.plant.platform.service.ManagerService;
import com.rlws.plant.platform.service.UserService;
import com.rlws.plant.platform.utils.CookieUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ManagerService managerService;

    @Autowired
    private CategoryService categoryService;

    @RequestMapping(value = "login",method = RequestMethod.GET)
    public String login(){
        return "login";
    }

    //(用户登录页)实现用户登录功能
    @RequestMapping(value = "login",method = RequestMethod.POST)
    public String login(@Autowired(required = true) String email,
                        @Autowired(required = true) String password ,
                        @Autowired(required = true) String userRadios,
                        HttpServletRequest request){
        User user = null;
        Manager manager = null;
        //对数据库进行查询,查询是否有该用户名(email)
        if ("user".equals(userRadios)){
            user = userService.userLogin(email);
            if (user != null){
                //如果用户名存在,那么对密码进行配对
                if (user.getPassword().equals(password)){
                    //密码配对正确,将用户名存入到Session中
                    request.getSession().setAttribute("user",user);
                    List<Category> categories = categoryService.selectAllCategory(null);
                    request.getSession().setAttribute("categories",categories);
                    return "redirect:/index";
                }else {
                    request.setAttribute("login","用户名或密码输入错误!");
                    return "/login";
                }
            }
        }else{
            manager = managerService.managerLogin(email);
            if (manager != null){
                if (manager.getPassword().equals(password)){
                    request.getSession().setAttribute("manager",manager);
                    return "redirect:manager_to_user";
                }else {
                    request.setAttribute("login","用户名或密码输入错误!");
                    return "/login";
                }
            }
        }
        request.setAttribute("login","用户名或密码输入错误!");
        return "/login";
    }

    //实现用户注销功能
    @RequestMapping(value = "user_logout",method = RequestMethod.GET)
    public String logout(HttpServletRequest request){
        request.getSession().setAttribute("user",null);
        return "forward:index";
    }

    //(用户注册页)点击链接用get方法跳转到/register页面
    @RequestMapping(value = "register",method = RequestMethod.GET)
    public String register(){
        return "/register";
    }

    //(用户注册页)用户进行用户信息填写提交
    @RequestMapping(value = "register",method = RequestMethod.POST)
    public String userRegister(@Autowired(required = true) User user){
        user.setPower(1);
        boolean b = userService.userRegistration(user);
        return b == false ? "/register" : login();
    }

    //注册用户提交信息判断用户邮箱是否已经注册ajax
    @ResponseBody
    @RequestMapping(value = "register_email_ajax",method = RequestMethod.GET)
    public boolean registerEmail(User user){
        User user1 = userService.selectByPrimaryKey(user);
        if (user1==null){
            return true;
        }
        return false;
    }

    //(修改用户信息页)点击链接用get方法跳转到user/user-change页面
    @RequestMapping(value = "user-change",method = RequestMethod.GET)
    public String GoUserChange(){
        return "user/user-change";
    }

    //(修改用户信息页)点击提交用post方法提交数据到数据库并跳转到user/user-change页面
    @RequestMapping(value = "user-change",method = RequestMethod.POST)
    public String userChange(@Autowired(required = true) String username,
                             @Autowired(required = true) String img ,
                             @Autowired(required = true) String userRadios,
                             HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        int sex = "男".equals(userRadios)? 1 : 0;
        user.setSex(sex);
        user.setImg(img);
        user.setUsername(username);
        boolean b = userService.updateUser(user);
        if (b){
            request.getSession().setAttribute("user",user);
        }
        return "user/user-change";
    }

    //(修改用户密码页)点击链接用get方法跳转到user/user-password页面
    @RequestMapping(value = "user-change-password",method = RequestMethod.GET)
    public String goUserChangePassword(){
        return "user/user-password";
    }

    //(修改用户密码页)点击提交用post方法提交数据到数据库并跳转到user/user-password页面
    @RequestMapping(value = "user-change-password",method = RequestMethod.POST)
    public String userChangePassword(@Autowired(required = true) String password,
                             HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        user.setPassword(password);
        boolean b = userService.updateUser(user);
        if (b){
            request.setAttribute("login","密码修改成功,请重新登录!");
            request.getSession().setAttribute("user",null);
            return "login";
        }
        request.setAttribute("message","密码修改失败!");
        return "user/user-password";
    }

    //获取用户最佳回答数量,跳转到达人申请的页面(get)
    @RequestMapping(value = "user_talent_apply",method = RequestMethod.GET)
    public String goTalentApply(HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        int i = userService.selectUserBestAnswerCount(user.getId());
        request.setAttribute("bestAnswerCount",i);
        return "user/user-apply";
    }

    //用户的所有问题获取Ajax异步请求
    @RequestMapping(value = "manager_get_all_user" , method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getAllUser( int page_current ,int page_size){
        Map<String,Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setPage_count(userService.selectAllUserCount());
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current-1)*page_size);
        List<User> users = userService.selectAllUser(pageVo);
        map.put("users",users);
        map.put("pageVo",pageVo);
        String json = JSON.toJSONString(map);
        return json;
    }

    //manager添加一个用户
    @RequestMapping(value = "manager_add_one_user",method = RequestMethod.POST)
    public String managerAddOneUser(User user){
        user.setPower(1);
        boolean b = userService.userRegistration(user);
        return "redirect:manager_to_user";
    }

    //manager删除一个用户
    @RequestMapping(value = "manager_delect_one_user" , method = RequestMethod.GET )
    @ResponseBody
    public boolean managerDelectOneUser(String user_id,HttpServletRequest request){
        boolean b = userService.delectOneUser(Integer.parseInt(user_id));
        request.getSession().setAttribute("user",null);
        return b;
    }

    //用户的所有问题获取Ajax异步请求
    @RequestMapping(value = "manager_get_one_user" , method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String managerGetOneUser(String user_id){
        User users = userService.selectOneUserById(Integer.parseInt(user_id));
        String json = JSON.toJSONString(users);
        return json;
    }

    //manager修改用户信息
    @RequestMapping(value = "manager_update_user",method = RequestMethod.POST)
    public String managerUpdateUser(User user,String email,String power ,String img,String userRadios,HttpServletRequest request){
        int sex = "男".equals(userRadios)? 1 : 0;
        user.setSex(sex);
        user.setEmail(email);
        user.setPower(Integer.parseInt(power));
        user.setImg(img);
        System.out.println(user);
        boolean b = userService.updateUser(user);
        return "redirect:manager_to_user";
    }

    //manager搜索查询用户信息
    @RequestMapping(value = "manager_select_user" , method = RequestMethod.GET ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String managerSelectUser(String search,int page_current ,int page_size){
        Map<String,Object> map = new HashMap<String, Object>();
        PageVo pageVo = new PageVo();
        pageVo.setSearch(search);
        pageVo.setPage_count(userService.selectMainUserCount(search));
        pageVo.setPage_size(page_size);
        pageVo.setPage_current(page_current);
        pageVo.setPage_start((page_current-1)*page_size);
        List<User> users = userService.selectMainUser(pageVo);
        map.put("users",users);
        map.put("pageVo",pageVo);
        String json = JSON.toJSONString(map);
        return json;
    }
}
