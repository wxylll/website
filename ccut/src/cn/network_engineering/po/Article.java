package cn.network_engineering.po;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 文章信息封装类
 */
public class Article {

    private int id; //id
    private String title; //标题
    private String content; //内容
    private Date releaseTime; //发行时间
    private List<String> attachments; //附件

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

    public List<String> getAttachments() {
        return attachments;
    }

    public void setAttachment(List<String> attachments) {
        this.attachments = attachments;
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
