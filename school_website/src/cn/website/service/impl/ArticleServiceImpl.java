package cn.website.service.impl;

import cn.website.mapper.ArticleMapper;
import cn.website.po.Article;
import cn.website.po.Slide;
import cn.website.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Override
    public void add(Article article) throws Exception {
        articleMapper.add(article);
    }

    @Override
    public void update(Article article) throws Exception {
        articleMapper.update(article);
    }

    @Override
    public void remove(int aid) throws Exception {
        articleMapper.remove(aid);
    }

    @Override
    public void setSlide(int sid, int aid) throws Exception {
        if (articleMapper.isExist(sid)) {
            articleMapper.setSlide(sid, aid);
        } else {
            articleMapper.addSlide(sid, aid);
        }
    }

    @Override
    public Article getArticle(int id) throws Exception {
        return articleMapper.getNews(id);
    }

    @Override
    public List<Article> getDisplay(int cid, int limit) throws Exception {
        return articleMapper.getDisplay(cid, limit);
    }

    @Override
    public List<Article> getAll(int cid) throws Exception {
        return articleMapper.getAll(cid);
    }

    @Override
    public void removeSlide(int sid) throws Exception {
        articleMapper.removeSlide(sid);
    }

    @Override
    public List<Slide> getSlides() throws Exception {
        return articleMapper.getSlides();
    }

    @Override
    public List<Article> search(String title, int cid) throws Exception {
        return articleMapper.search(title, cid);
    }

    @Override
    public String getBrief() throws Exception {
        return articleMapper.getBrief();
    }

    @Override
    public void setBrief(String brief) throws Exception {
        articleMapper.deleteBrief();
        articleMapper.setBrief(brief);
    }
}
