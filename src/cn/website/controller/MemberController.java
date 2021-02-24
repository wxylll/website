package cn.website.controller;

import cn.website.po.Staff;
import cn.website.service.MemberService;
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
public class MemberController {

    @Autowired
    private MemberService memberService;

    //跳转到班子成员
    @RequestMapping("/toMember")
    public String toMember(Model model) {
        try {
            model.addAttribute("title","支部介绍");
            model.addAttribute("members", memberService.getAll());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "zbjj/dyfc";
    }

    //进入成员管理
    @RequestMapping("/adminMemberManage")
    public String memberManage(Model model) {
        try {
            model.addAttribute("members", memberService.getAll());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_member";
    }

    //获取指定成员信息，转到修改界面
    @RequestMapping("/getMember")
    public String getMember(int id, Model model) {
        try {
            model.addAttribute("member", memberService.getMember(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_member_alter";
    }

    //添加成员
    @ResponseBody
    @RequestMapping("/adminMemberAdd")
    public String addMember(String name, String position, String note, MultipartFile photo, HttpServletRequest request) {
        Staff member = new Staff();
        member.setName(name);
        member.setPosition(position);
        member.setNote(note);

        String path = request.getSession().getServletContext().getRealPath("/")
                + "/upload/photos/";
        String oldName = photo.getOriginalFilename();
        String newName = new Date().getTime() + oldName.substring(oldName.indexOf("."));
        try {
            FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(path + newName)); //保存照片
            member.setPhoto(newName);
            memberService.add(member);
        } catch (Exception e) {
            FileUtils.deleteQuietly(new File(path + newName)); //删除照片
            e.printStackTrace();
            return "failed";
        }
        return "success";
    }

    //修改成员信息
    @ResponseBody
    @RequestMapping("/adminMemberAlter")
    public String alterMember(int id, String name, String position, String note) {
        try {
            Staff member = memberService.getMember(id);
            member.setId(id);
            member.setName(name);
            member.setPosition(position);
            member.setNote(note);
            memberService.update(member);
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
        return "success";
    }

    //修改成员照片
    @ResponseBody
    @RequestMapping("/adminMemberPhotoAlter")
    public String alterPhoto(int id, MultipartFile newPhoto, HttpServletRequest request) {
        try {
            Staff member = memberService.getMember(id);
            if (member == null) return "";
            String path = request.getSession().getServletContext().getRealPath("/")
                    + "/upload/photos/";
            String suffix = newPhoto.getOriginalFilename().substring(newPhoto.getOriginalFilename().indexOf("."));
            String newName = member.getPhoto().substring(0, member.getPhoto().indexOf(".")) + suffix;

            FileUtils.deleteQuietly(new File(path + member.getPhoto())); //删除旧照片
            FileUtils.copyInputStreamToFile(newPhoto.getInputStream(), new File(path + newName)); //保存新照片

            member.setPhoto(newName); //更新照片信息
            memberService.update(member);
            return "{\"code\":0,\"msg\":\"\",\"data\":\"\"}";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    //删除成员
    @ResponseBody
    @RequestMapping("/adminMemberDelete")
    public void deleteMember(int id, HttpServletRequest request) {
        try {
            String path = request.getSession().getServletContext().getRealPath("/") + "/upload/photos/";
            FileUtils.deleteQuietly(new File(path + memberService.getMember(id).getPhoto())); //删除照片
            memberService.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
