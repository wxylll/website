package cn.website.po;

/**
 * 轮播项数据
 */
public class Slide {

    String id; //轮播项id（用于标识对应的图片）
    Article article; //轮播项对应文章

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }
}
