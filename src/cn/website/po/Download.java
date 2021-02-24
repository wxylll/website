package cn.website.po;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Download {

    private int id;
    private String title;
    private String file;
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

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
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
