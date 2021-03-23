package cn.network_engineering.controller;

import cn.itcast.commons.CommonUtils;
import cn.network_engineering.po.Article;
import cn.network_engineering.service.StudyService;
import com.sun.xml.internal.bind.v2.model.core.ID;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller
public class StudyController {

    @Autowired
    private StudyService studyService;
    @Autowired
    private DataSourceTransactionManager transactionManager;

    //跳转到学习园地
    @RequestMapping("/toStudy")
    public String toStudy(Model model) {
        try {
            model.addAttribute("articles", studyService.getDisplay(15)); //获取前十五条数据
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "items/study";
    }

    //显示更多文章
    @RequestMapping("/study_showMore")
    public String showMore(Model model) {
        try {
            model.addAttribute("title", "学习园地");
            model.addAttribute("articles", studyService.getAll());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "items/more";
    }

    //显示一篇文章
    @RequestMapping("/getArticle")
    public String getArticle(int id, Model model) {
        try {
            model.addAttribute("article", studyService.getArticle(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "items/show_article";
    }

    //进入学习园地管理
    @RequestMapping("/adminStudyManage")
    public String studyManage(Model model) {
        try {
            model.addAttribute("articles", studyService.getAll());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_study";
    }

    //添加文章
    @ResponseBody
    @RequestMapping("/studyAdd")
    public String studyAdd(String title, String releaseTime, String content, MultipartFile[] attachments, HttpServletRequest request) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition(); //获取事务定义
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW); //设置事务隔离级别，开启新事务
        TransactionStatus status = transactionManager.getTransaction(def); //获得事务状态

        Article article = new Article();
        List<String> temp = new ArrayList<>(); //保存附件信息，用于添加失败后删除附件
        String path = request.getSession().getServletContext().getRealPath("/") + "/upload/attachment/";

        try {
            article.setTitle(title);
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            article.setReleaseTime(dateFormat.parse(releaseTime));
            article.setContent(content);
            studyService.add(article);

            if (attachments.length > 0) { //是否有附件
                int aid = article.getId();
                for (MultipartFile attachment : attachments) {
                    String ID = CommonUtils.uuid();
                    String fullPath = path + ID.substring(0, 2) + "/";
                    String fileName = ID + attachment.getOriginalFilename();
                    //保存上传附件
                    File dir = new File(path);
                    if (!dir.exists()) dir.mkdir();
                    File saveTo = new File(fullPath + fileName);
                    FileUtils.copyInputStreamToFile(attachment.getInputStream(), saveTo);
                    studyService.addAttachment(aid, fileName);
                    temp.add(fullPath + fileName);
                }
            }
            transactionManager.commit(status); //提交
        } catch(Exception e) { //异常处理
            e.printStackTrace();
            transactionManager.rollback(status); //回滚
            try {
                for (String tempPath: temp)
                    FileUtils.deleteQuietly(new File(tempPath)); //删除无效附件
            } catch (Exception e1) {
                e1.printStackTrace();
            }
            return "failed";
        }
        return "success";
    }

    //修改文章前的加载
    @RequestMapping("/adminGetArticle")
    public String adminGetArticle(int id, Model model) {
        try {
            model.addAttribute("article", studyService.getArticle(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/items/_study_article_alter";
    }

    //修改文章信息
    @ResponseBody
    @RequestMapping("/studyAlter")
    public void studyAlter(int id, String title, String releaseTime, String content) {
        try {
            Article article = studyService.getArticle(id);
            article.setId(id);
            article.setTitle(title);
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            article.setReleaseTime(dateFormat.parse(releaseTime));
            article.setContent(content);

            studyService.update(article);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    //删除附件
    @ResponseBody
    @RequestMapping("/adminAttachmentDelete")
    public void attachmentDelete(int aid, String attachment, HttpServletRequest request) {
        String filePath = request.getSession().getServletContext().getRealPath("/")
                + "/upload/attachment/" + attachment.substring(0,2) + "/" + attachment;

        FileUtils.deleteQuietly(new File(filePath )); //删除附件
        try {
            studyService.deleteAttachment(aid, attachment);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //添加附件
    @ResponseBody
    @RequestMapping("/adminAttachmentAlter")
    public String attachmentAlter(int aid, MultipartFile attachment, HttpServletRequest request) {

        String ID = CommonUtils.uuid();
        String path = request.getSession().getServletContext().getRealPath("/")
                + "/upload/attachment/" + ID.substring(0,2) + "/";

        //保存新附件
        if (attachment != null && !attachment.isEmpty()) {
            String newFileName = ID + attachment.getOriginalFilename();
            File dir = new File(path);
            if (!dir.exists()) dir.mkdir();
            File saveTo = new File(path + newFileName);
            try {
                FileUtils.copyInputStreamToFile(attachment.getInputStream(), saveTo);
                studyService.addAttachment(aid, newFileName);
                return ID;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    //删除文章
    @ResponseBody
    @RequestMapping("/adminStudyDelete")
    public void adminStudyDelete(int id, HttpServletRequest request) {
        try {
            Article article = studyService.getArticle(id);
            for (String attachment : article.getAttachments()) {
                studyService.deleteAttachment(article.getId(), attachment);
            }
            new Thread() {
                @Override
                public void run() {
                    List<String> attachments = article.getAttachments();
                    String path = request.getSession().getServletContext().getRealPath("/")
                            + "/upload/attachment/";
                    for (String attachment : attachments) {
                         String filePath = attachment.substring(0,2) + "/" + attachment;
                        FileUtils.deleteQuietly(new File(path + filePath )); //删除附件
                    }
                }
            }.start();
            studyService.removeAllAttachment(article.getId()); //删除关联附件
            studyService.remove(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //搜索文章
    @ResponseBody
    @RequestMapping(value = "/adminArticleSearch",produces = "text/plain;charset=utf-8")
    public String adminArticleSearch(String title) {
        List<Article> articles = null;
        try {
            articles = studyService.search(title);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return articles.toString();
    }

}
