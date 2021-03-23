package cn.network_engineering.service.impl;

import cn.network_engineering.mapper.NewsMapper;
import cn.network_engineering.po.Article;
import cn.network_engineering.po.Slide;
import cn.network_engineering.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class NewsServiceImpl implements NewsService {

    @Autowired
    private NewsMapper newsMapper;

    @Override
    public void add(Article article) throws Exception {
        newsMapper.add(article);
    }

    @Override
    public void update(Article article) throws Exception {
        newsMapper.update(article);
    }

    @Override
    public void remove(int aid) throws Exception {
        newsMapper.remove(aid);
    }

    @Override
    public void setSlide(int sid, int aid) throws Exception {
        if (newsMapper.isExist(sid)) {
            newsMapper.setSlide(sid, aid);
        } else {
            newsMapper.addSlide(sid, aid);
        }
    }

    @Override
    public Article getNews(int id) throws Exception {
        return newsMapper.getNews(id);
    }

    @Override
    public void removeSlide(int sid) throws Exception {
        newsMapper.removeSlide(sid);
    }

    @Override
    public List<Slide> getSlides() throws Exception {
        return newsMapper.getSlides();
    }

    @Override
    public List<Article> getDisplay(int limit) throws Exception {
        return newsMapper.getDisplay(limit);
    }

    @Override
    public List<Article> getAll() throws Exception {
        return newsMapper.getAll();
    }

    @Override
    public List<Article> search(String title) throws Exception {
        return newsMapper.search(title);
    }
}
