package cn.website.service;

import cn.website.po.Article;

import java.util.List;

public interface StudyService {

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
     * 获取指定文章
     * @param id
     * @return
     * @throws Exception
     */
    public Article getArticle(int id) throws Exception;

    /**
     * 获取缩略展示的文章
     * @param limit
     * @return
     * @throws Exception
     */
    public List<Article> getDisplay(int limit) throws Exception;

    /**
     * 获取所有文章
     * @return
     * @throws Exception
     */
    public List<Article> getAll() throws Exception;

    /**
     * 根据标题模糊匹配文章
     * @param title
     * @return
     * @throws Exception
     */
    public List<Article > search(String title) throws Exception;

    /**
     * 添加附件
     * @param aid
     * @param attachment
     * @throws Exception
     */
    public void addAttachment(int aid, String attachment) throws Exception;

    /**
     * 删除附件
     * @param aid
     * @param attachment
     * @throws Exception
     */
    public void deleteAttachment(int aid, String attachment) throws Exception;

    /**
     * 删除指定文章的所有附件
     * @param aid
     * @throws Exception
     */
    public void removeAllAttachment(int aid) throws Exception;

}
