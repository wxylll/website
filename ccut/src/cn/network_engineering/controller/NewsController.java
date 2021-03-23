package cn.network_engineering.controller;

import cn.network_engineering.po.Article;
import cn.network_engineering.service.NewsService;
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
public class NewsController {

    @Autowired
    private NewsService newsService;

    //跳转到支部新闻
    @RequestMapping("/toNews")
    public String toNews(Model model) {
        try {
            model.addAttribute("slides", newsService.getSlides()); //获取轮播内容
            model.addAttribute("articles", newsService.getDisplay(10)); //获取前十条新闻
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "items/news";
    }

    //显示更多新闻
    @RequestMapping("/news_showMore")
    public String showMore(Model model) {
        model.addAttribute("title", "支部新闻");
        try {
            model.addAttribute("articles", newsService.getAll());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "items/more";
    }

    //显示一篇新闻
    @RequestMapping("/getNews")
    public String getNews(int id, Model model) {
        try {
            model.addAttribute("article", newsService.getNews(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "items/show_article";
    }

    //进入支部新闻管理
    @RequestMapping("/adminNewsManage")
    public String newsManage(Model model) {
        try {
            model.addAttribute("news", newsService.getAll());
            model.addAttribute("slides", newsService.getSlides());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_news";
    }

    //添加新闻
    @ResponseBody
    @RequestMapping("/newsAdd")
    public void newsAdd(String title, String releaseTime, String content) {
        try {
            Article article = new Article();
            article.setTitle(title);
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            article.setReleaseTime(dateFormat.parse(releaseTime));
            article.setContent(content);
            newsService.add(article);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    //修改新闻信息
    @ResponseBody
    @RequestMapping("/newsAlter")
    public void newsAlter(int id, String title, String releaseTime, String content) {
        try {
            Article article = new Article();
            article.setId(id);
            article.setTitle(title);
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            article.setReleaseTime(dateFormat.parse(releaseTime));
            article.setContent(content);
            newsService.update(article);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    //修改新闻前的加载
    @RequestMapping("/adminGetNews")
    public String adminGetNews(int id, Model model) {
        try {
            model.addAttribute("article", newsService.getNews(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_news_article_alter";
    }

    //删除新闻
    @ResponseBody
    @RequestMapping("/adminNewsDelete")
    public String adminNewsDelete(int id) {
        try {
            newsService.remove(id);
            return "success";
        } catch (Exception e) {
            return "failed";
        }
    }

    //搜索新闻
    @ResponseBody
    @RequestMapping(value = "/adminNewsSearch",produces = "text/plain;charset=utf-8")
    public String adminNewsSearch(String title) {
        List<Article> articles = null;
        try {
            articles = newsService.search(title);
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
            newsService.removeSlide(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //设置轮播内容
    @ResponseBody
    @RequestMapping(value = "/adminSetSlide",produces = "text/plain;charset=utf-8")
    public String setSlide(int sid, int aid) {
        try {
            if (newsService.getNews(aid) == null){
                return "该文章不存在！";
            }
            newsService.setSlide(sid, aid);
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
