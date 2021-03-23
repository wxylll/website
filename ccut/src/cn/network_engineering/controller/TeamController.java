package cn.network_engineering.controller;

import cn.network_engineering.po.Staff;
import cn.network_engineering.service.TeamService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;

@Controller
public class TeamController {

    @Autowired
    private TeamService teamService;

    //跳转到党员队伍
    @RequestMapping("/toTeam")
    public String toTeam(Model model) {
        try {
            model.addAttribute("teamMembers", teamService.getAll());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "items/team";
    }

    //进入党员队伍管理
    @RequestMapping("/adminTeamManage")
    public String teamManage(Model model) {
        try {
            model.addAttribute("teamMembers", teamService.getAll());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_team";
    }

    //添加队伍成员
    @ResponseBody
    @RequestMapping("/adminTeamMemberAdd")
    public String addTeamMember(String name, MultipartFile photo, HttpServletRequest request) {
        Staff teamMember = new Staff();
        teamMember.setName(name);

        try {
            String path = request.getSession().getServletContext().getRealPath("/")
                    + "/upload/photos/";
            String oldName = photo.getOriginalFilename();
            String newName = new Date().getTime() + oldName.substring(oldName.indexOf("."));
            FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(path + newName)); //保存照片
            teamMember.setPhoto(newName);
            teamService.add(teamMember);
        } catch(Exception e) {
            e.printStackTrace();
            return "failed";
        }
        return "success";
    }

    //修改队伍成员信息
    @ResponseBody
    @RequestMapping("/adminTeamMemberAlter")
    public String alterTeamMember(int id, String name) {
        try {
            Staff teamMember = teamService.getTeamMember(id);
            teamMember.setId(id);
            teamMember.setName(name);
            teamService.update(teamMember);
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
        return "success";
    }

    //修改照片
    @ResponseBody
    @RequestMapping("/adminTeamMemberPhotoAlter")
    public String alterPhoto(int id, MultipartFile newPhoto, HttpServletRequest request) {
        try {
            Staff teamMember = teamService.getTeamMember(id);
            if (teamMember == null) return "";
            String path = request.getSession().getServletContext().getRealPath("/")
                    + "/upload/photos/";
            String suffix = newPhoto.getOriginalFilename().substring(newPhoto.getOriginalFilename().indexOf("."));
            String newName = teamMember.getPhoto().substring(0, teamMember.getPhoto().indexOf(".")) + suffix;

            FileUtils.deleteQuietly(new File(path + teamMember.getPhoto())); //删除旧照片
            FileUtils.copyInputStreamToFile(newPhoto.getInputStream(), new File(path + newName)); //保存新照片

            teamMember.setPhoto(newName); //更新照片信息
            teamService.update(teamMember);
            return "{\"code\":0,\"msg\":\"\",\"data\":\"\"}";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    //删除队伍成员
    @ResponseBody
    @RequestMapping("/adminTeamMemberDelete")
    public void deleteTeamMember(int id, HttpServletRequest request) {
        try {
            String path = request.getSession().getServletContext().getRealPath("/") + "/upload/photos/";
            FileUtils.deleteQuietly(new File(path + teamService.getTeamMember(id).getPhoto())); //删除照片
            teamService.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
