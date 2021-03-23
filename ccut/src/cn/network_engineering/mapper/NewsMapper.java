package cn.network_engineering.mapper;

import cn.network_engineering.po.Article;
import cn.network_engineering.po.Slide;

import java.util.List;

public interface NewsMapper {

    /**
     * 添加新闻
     * @param article
     * @throws Exception
     */
    public void add(Article article) throws Exception;

    /**
     * 更新新闻
     * @param article
     * @throws Exception
     */
    public void update(Article article) throws Exception;

    /**
     * 删除新闻
     * @param aid
     * @throws Exception
     */
    public void remove(int aid) throws Exception;

    /**
     * 添加轮播项
     * @param sid
     * @param aid
     * @throws Exception
     */
    public void addSlide(int sid, int aid) throws Exception;

    /**
     * 检测轮播项是否存在
     * @return
     * @throws Exception
     */
    public boolean isExist(int sid) throws Exception;

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
    public Article getNews(int id) throws Exception;

    /**
     * 获取缩略展示的新闻
     * @param limit
     * @return
     * @throws Exception
     */
    public List<Article> getDisplay(int limit) throws Exception;

    /**
     * 获取所有新闻
     * @return
     * @throws Exception
     */
    public List<Article> getAll() throws Exception;

    /**
     * 根据标题模糊匹配新闻
     * @param title
     * @return
     * @throws Exception
     */
    public List<Article > search(String title) throws Exception;

}
