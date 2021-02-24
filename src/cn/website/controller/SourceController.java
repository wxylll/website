package cn.website.controller;

import cn.itcast.commons.CommonUtils;
import cn.website.po.Article;
import cn.website.po.Download;
import cn.website.po.Staff;
import cn.website.po.Video;
import cn.website.service.SourceService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class SourceController {

    @Autowired
    private SourceService sourceService;

    //进入视频资源管理
    @RequestMapping("/adminVideoManage")
    public String adminVideoManage(Model model) {
        try {
            model.addAttribute("videos", sourceService.getAllVideo());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_video";
    }

    //进入下载专区管理
    @RequestMapping("/adminDownloadManage")
    public String adminDownloadManage(Model model) {
        try {
            model.addAttribute("downloads", sourceService.getAllDownload());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_download";
    }

    //添加视频
    @ResponseBody
    @RequestMapping("/adminVideoAdd")
    public String adminVideoAdd(String title, String releaseTime, MultipartFile file, HttpServletRequest request) throws ParseException {
        Video video = new Video();
        video.setTitle(title);
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        video.setReleaseTime(dateFormat.parse(releaseTime));

        String path = request.getSession().getServletContext().getRealPath("/")
                + "/upload/video/";
        String oldName = file.getOriginalFilename();
        String newName = new Date().getTime() + oldName.substring(oldName.indexOf("."));
        try {
            FileUtils.copyInputStreamToFile(file.getInputStream(), new File(path + newName)); //保存视频
            video.setVideo(newName);
            sourceService.addVideo(video);
        } catch (Exception e) {
            FileUtils.deleteQuietly(new File(path + newName)); //删除视频
            e.printStackTrace();
            return "failed";
        }
        return "success";
    }

    //添加下载文件
    @ResponseBody
    @RequestMapping("/adminDownloadAdd")
    public String adminDownloadAdd(String title, String releaseTime, MultipartFile file, HttpServletRequest request) throws ParseException {
        Download download = new Download();
        download.setTitle(title);
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        download.setReleaseTime(dateFormat.parse(releaseTime));

        String ID = CommonUtils.uuid();
        String path = request.getSession().getServletContext().getRealPath("/")
                + "/upload/attachment/";
        String oldName = file.getOriginalFilename();
        String newName = ID.substring(0,2) + "/" + ID + oldName.substring(oldName.indexOf("."));
        try {
            File dir = new File(path + ID.substring(0,2) + "/");
            if (!dir.exists()) dir.mkdir();
            FileUtils.copyInputStreamToFile(file.getInputStream(), new File(path + newName)); //保存下载文件
            download.setFile(newName);
            sourceService.addDownload(download);
        } catch (Exception e) {
            FileUtils.deleteQuietly(new File(path + newName)); //删除下载文件
            e.printStackTrace();
            return "failed";
        }
        return "success";
    }

    //删除视频
    @ResponseBody
    @RequestMapping("/adminVideoDelete")
    public void adminVideoDelete(int id, HttpServletRequest request) {
        String path = request.getSession().getServletContext().getRealPath("/")
                + "/upload/video/";
        try {
            Video video = sourceService.getVideo(id);
            FileUtils.deleteQuietly(new File(path + video.getVideo())); //删除视频
            sourceService.deleteVideo(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //删除下载文件
    @ResponseBody
    @RequestMapping("/adminDownloadDelete")
    public void adminDownloadDelete(int id, HttpServletRequest request) {
        String path = request.getSession().getServletContext().getRealPath("/")
                + "/upload/attachment/";
        try {
            Download download = sourceService.getDownload(id);
            FileUtils.deleteQuietly(new File(path + download.getFile())); //删除文件
            sourceService.deleteDownload(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //获取视频
    @RequestMapping("/getVideo")
    public String getVideo(int id, Model model) {
        try {
            model.addAttribute("video", sourceService.getVideo(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "items/video";
    }

    //搜索视频
    @ResponseBody
    @RequestMapping(value = "/adminVideoSearch",produces = "text/plain;charset=utf-8")
    public String adminVideoSearch(String title) {
        List<Video> videos = null;
        try {
            videos = sourceService.searchVideo(title);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return videos.toString();
    }

    //搜索下载资源
    @ResponseBody
    @RequestMapping(value = "/adminDownloadSearch",produces = "text/plain;charset=utf-8")
    public String adminDownloadSearch(String title) {
        List<Download> downloads = null;
        try {
            downloads = sourceService.searchDownload(title);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return downloads.toString();
    }

}
