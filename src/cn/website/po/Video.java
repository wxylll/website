package cn.website.po;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Video {

    private int id;
    private String title;
    private String video;
    private Date releaseTime;

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

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public Date getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(Date releaseTime) {
        this.releaseTime = releaseTime;
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
