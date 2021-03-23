package cn.website.service;

import cn.website.po.Article;
import cn.website.po.Slide;

import java.util.List;

/**
 * 支部新闻模块业务处理
 */
public interface ArticleService {

    /**
     * 添加文章
     * @param article
     * @throws Exception
     */
    public void add(Article article) throws Exception;

    /**
     * 更新文章
     * @param article
     * @throws Exception
     */
    public void update(Article article) throws Exception;

    /**
     * 删除文章
     * @param aid
     * @throws Exception
     */
    public void remove(int aid) throws Exception;

    /**
     * 设置轮播项
     * @param sid
     * @param aid
     * @throws Exception
     */
    public void setSlide(int sid, int aid) throws Exception;

    /**
     * 删除轮播项
     * @param sid
     * @throws Exception
     */
    public void removeSlide(int sid) throws Exception;

    /**
     * 获取所有轮播项
     * @return
     * @throws Exception
     */
    public List<Slide> getSlides() throws Exception;

    /**
     * 获取指定新闻
     * @param id
     * @return
     * @throws Exception
     */
    public Article getArticle(int id) throws Exception;

    /**
     * 获取指定栏目下的指定数量的文章
     * @param cid
     * @param limit
     * @return
     * @throws Exception
     */
    public List<Article> getDisplay(int cid, int limit) throws Exception;

    /**
     * 获取指定栏目所有文章
     * @return
     * @throws Exception
     */
    public List<Article> getAll(int cid) throws Exception;

    /**
     * 根据标题模糊匹配文章
     * @param title
     * @return
     * @throws Exception
     */
    public List<Article > search(String title, int cid) throws Exception;

    /**
     * 获取支部简介绍
     * @return
     * @throws Exception
     */
    public String getBrief() throws Exception;

    /**
     * 设置支部介绍
     * @param brief
     * @throws Exception
     */
    public void setBrief(String brief) throws Exception;

}
