package cn.network_engineering.controller;

import cn.network_engineering.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;

    //后台登录
    @RequestMapping("/login")
    public String login(String account, String password, HttpServletRequest request, Model model){
        try {
            if (account != null && password != null && adminService.login(account,password)) {
                request.getSession().setAttribute("admin_user", account);
                return "backstage/main";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("msg","用户名或密码错误！");
        return "backstage/login";
    }

    //退出登录
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "backstage/login";
    }

    //修改账号信息
    @ResponseBody
    @RequestMapping(value = "/alterAdminAccount",produces = "text/plain;charset=utf-8")
    public String alterAccount(String oldAccount, String newAccount, String oldPassword, String newPassword, HttpServletRequest request) {
        try {
            if (oldAccount != null && oldPassword != null && adminService.login(oldAccount, oldPassword)) {
                adminService.modify(newAccount, newPassword);
                request.getSession().invalidate();
                return "success";
            } else {
                return "修改失败！原账号信息有误！";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "修改失败！未知错误！";
    }

}
