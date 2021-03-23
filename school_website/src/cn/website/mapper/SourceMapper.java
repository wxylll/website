package cn.website.mapper;

import cn.website.po.Download;
import cn.website.po.Video;
import org.apache.tools.ant.taskdefs.EchoXML;
import org.aspectj.weaver.patterns.ExactTypePattern;

import java.util.List;

public interface SourceMapper {

    /**
     * 添加视频
     * @param video
     * @throws Exception
     */
    public void addVideo(Video video) throws Exception;

    /**
     * 添加下载资源
     * @param download
     * @throws Exception
     */
    public void addDownload(Download download) throws Exception;

    /**
     * 修改视频
     * @param video
     * @throws Exception
     */
    public void alterVideo(Video video) throws Exception;

    /**
     * 修改下载资源
     * @param download
     * @throws Exception
     */
    public void alterDownload(Download download) throws Exception;

    /**
     * 删除视频
     * @param id
     * @throws Exception
     */
    public void deleteVideo(int id) throws Exception;

    /**
     * 删除下载资源
     * @param id
     * @throws Exception
     */
    public void deleteDownload(int id) throws Exception;

    /**
     * 获取指定数目视频
     * @param limit
     * @return
     * @throws Exception
     */
    public List<Video> getVideoInLimit(int limit) throws Exception;

    /**
     * 获取指定数目下载资源
     * @param limit
     * @return
     * @throws Exception
     */
    public List<Download> getDownloadInLimit(int limit) throws Exception;

    /**
     * 获取所有视频
     * @return
     * @throws Exception
     */
    public List<Video> getAllVideo() throws Exception;

    /**
     * 获取指定视频
     * @param id
     * @return
     * @throws Exception
     */
    public Video getVideo(int id) throws Exception;

    /**
     * 获取所有下载资源
     * @return
     * @throws Exception
     */
    public List<Download> getAllDownload() throws Exception;

    /**
     * 获取指定下载资源
     * @param id
     * @return
     * @throws Exception
     */
    public Download getDownload(int id) throws Exception;

    /**
     * 根据标题搜索视频
     * @param title
     * @return
     * @throws Exception
     */
    public List<Video> searchVideo(String title) throws Exception;

    /**
     * 根据标题搜索下载文件
     * @param title
     * @return
     * @throws Exception
     */
    public List<Download> searchDownload(String title) throws Exception;

}
