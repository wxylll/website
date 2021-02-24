package cn.website.controller;

import cn.website.po.Article;
import cn.website.service.ArticleService;
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
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    private ArticleService articleService;
    @Autowired
    private SourceService sourceService;

    //跳转到首页
    @RequestMapping("/toMain")
    public String toMain(Model model) {
        try {
            model.addAttribute("slides", articleService.getSlides()); //获取轮播内容
            model.addAttribute("news", articleService.getDisplay(1, 7)); //获取前7条动态
            model.addAttribute("informs", articleService.getDisplay(2, 4)); //获取前4条文件通知
            model.addAttribute("studies", articleService.getDisplay(3, 4)); //获取前4条学习资料
            model.addAttribute("videos", sourceService.getVideoInLimit(4)); //获取前4条视频
            model.addAttribute("downloads", sourceService.getDownloadInLimit(4)); //获取前4条下载资源
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "main";
    }

    //显示更多内容
    @RequestMapping("/showMore")
    public String showMore(Model model, int category, String title) {
        model.addAttribute("title", title);
        try {
            if (category <= 3)
                model.addAttribute("sources", articleService.getAll(category));
            else {
                if (category == 4)
                    model.addAttribute("sources", sourceService.getAllVideo());
                else
                    model.addAttribute("sources", sourceService.getAllDownload());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "display";
    }

    //进入支部介绍
    @RequestMapping("/toBrief")
    public String toBrief(Model model) {
        try {
            model.addAttribute("brief",articleService.getBrief());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "zbjj/zbjs";
    }

    //进入支部简介部分
    @RequestMapping("/toBranch")
    public String toBranch(Model model, String title) {
        model.addAttribute("title", title);
        return "zbjj/display";
    }

    //显示一篇文章
    @RequestMapping("/getArticle")
    public String getArticle(int id, Model model) {
        try {
            model.addAttribute("article", articleService.getArticle(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "items/article";
    }

    //进入支部动态管理
    @RequestMapping("/adminNewsManage")
    public String newsManage(Model model) {
        try {
            model.addAttribute("news", articleService.getAll(1));
            model.addAttribute("slides", articleService.getSlides());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_news";
    }

    //进入支部动态管理
    @RequestMapping("/adminDocumentManage")
    public String documentManage(Model model) {
        try {
            model.addAttribute("documents", articleService.getAll(2));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_document";
    }

    //进入学习资料
    @RequestMapping("/adminStudyManage")
    public String studyManage(Model model) {
        try {
            model.addAttribute("studies", articleService.getAll(3));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_study";
    }

    //进入支部介绍管理
    @RequestMapping("/adminBriefManage")
    public String adminBriefManage(Model model) {
        try {
            model.addAttribute("brief", articleService.getBrief());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_brief";
    }

    //修改支部介绍
    @RequestMapping("/adminSetBrief")
    public String adminSetBrief(String brief, Model model) {
        try {
            articleService.setBrief(brief);
            model.addAttribute("success", "success");
            model.addAttribute("brief", brief);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_brief";
    }

    //添加文章
    @ResponseBody
    @RequestMapping("/articleAdd")
    public void articleAdd(String title, String releaseTime, String content, int cid) {
        try {
            Article article = new Article();
            article.setTitle(title);
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            article.setReleaseTime(dateFormat.parse(releaseTime));
            article.setContent(content);
            article.setCid(cid); //设置所属分类
            articleService.add(article);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    //修改文章信息
    @ResponseBody
    @RequestMapping("/articleAlter")
    public void articleAlter(int id, String title, String releaseTime, String content) {
        try {
            Article article = new Article();
            article.setId(id);
            article.setTitle(title);
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            article.setReleaseTime(dateFormat.parse(releaseTime));
            article.setContent(content);
            articleService.update(article);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    //修改新闻前的加载
    @RequestMapping("/adminGetArticle")
    public String adminGetArticle(int id, Model model) {
        try {
            model.addAttribute("article", articleService.getArticle(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_article_alter";
    }

    //删除新闻
    @ResponseBody
    @RequestMapping("/adminArticleDelete")
    public String adminArticleDelete(int id) {
        try {
            articleService.remove(id);
            return "success";
        } catch (Exception e) {
            return "failed";
        }
    }

    //搜索文章
    @ResponseBody
    @RequestMapping(value = "/adminArticleSearch",produces = "text/plain;charset=utf-8")
    public String adminArticleSearch(String title, int cid) {
        List<Article> articles = null;
        try {
            articles = articleService.search(title, cid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return articles.toString();
    }

    //删除轮播内容
    @ResponseBody
    @RequestMapping("/adminSlideDelete")
    public void slideDelete(int id) {
        try {
            articleService.removeSlide(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //设置轮播内容
    @ResponseBody
    @RequestMapping(value = "/adminSetSlide",produces = "text/plain;charset=utf-8")
    public String setSlide(int sid, int aid) {
        try {
            if (articleService.getArticle(aid) == null){
                return "该文章不存在！";
            }
            articleService.setSlide(sid, aid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    //上传轮播图
    @ResponseBody
    @RequestMapping("/adminUploadSlide")
    public String uploadSlide(MultipartFile slide, String id, HttpServletRequest request) {
        String path = request.getSession().getServletContext().getRealPath("/") + "upload/slides/";
        String newName = "s" + id + ".jpg";

        File dir = new File(path);
        if (!dir.exists()) dir.mkdir();

        File saveTo = new File(path + newName);
        try {
            FileUtils.copyInputStreamToFile(slide.getInputStream(),saveTo);
        } catch (IOException e) {
            String result = "{\"code\":1,\"msg\":\"\",\"data\":\"\"}";
            e.printStackTrace();
            return result;
        }
        String result = "{\"code\":0,\"msg\":\"\",\"data\":\"\"}";
        return result;
    }

}
