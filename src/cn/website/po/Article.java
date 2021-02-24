package cn.website.po;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 文章信息封装类
 */
public class Article {

    private int id; //id
    private String title; //标题
    private String content; //内容
    private Date releaseTime; //发行时间
    private int cid; //所属栏目
    private String category; //栏目名称

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(Date releaseTime) {
        this.releaseTime = releaseTime;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        //重载toString，自动完成json的转换
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return "{\"id\":\"" + id + "\"," +
                "\"title\":\"" + title + "\"," +
                "\"releaseTime\":\"" + format.format(releaseTime) + "\"}";
    }
}
