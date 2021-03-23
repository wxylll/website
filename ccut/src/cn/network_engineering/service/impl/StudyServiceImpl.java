package cn.network_engineering.service.impl;

import cn.network_engineering.mapper.StudyMapper;
import cn.network_engineering.po.Article;
import cn.network_engineering.service.StudyService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class StudyServiceImpl implements StudyService {

    @Autowired
    private StudyMapper studyMapper;

    @Override
    public void add(Article article) throws Exception {
        studyMapper.add(article);
    }

    @Override
    public void update(Article article) throws Exception {
        studyMapper.update(article);
    }

    @Override
    public void remove(int aid) throws Exception {
        studyMapper.remove(aid);
    }

    @Override
    public Article getArticle(int id) throws Exception {
        return studyMapper.getArticle(id);
    }

    @Override
    public List<Article> getDisplay(int limit) throws Exception {
        return studyMapper.getDisplay(limit);
    }

    @Override
    public List<Article> getAll() throws Exception {
        return studyMapper.getAll();
    }

    @Override
    public List<Article> search(String title) throws Exception {
        return studyMapper.search(title);
    }

    @Override
    public void addAttachment(int aid, String attachment) throws Exception {
        studyMapper.addAttachment(aid, attachment);
    }

    @Override
    public void deleteAttachment(int aid, String attachment) throws Exception {
        studyMapper.deleteAttachment(aid, attachment);
    }

    @Override
    public void removeAllAttachment(int aid) throws Exception {
        studyMapper.removeAllAttachment(aid);
    }
}
