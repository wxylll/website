package cn.website.service.impl;

import cn.website.mapper.SourceMapper;
import cn.website.po.Download;
import cn.website.po.Video;
import cn.website.service.SourceService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class SourceServiceImpl implements SourceService {

    @Autowired
    private SourceMapper sourceMapper;

    @Override
    public void addVideo(Video video) throws Exception {
        sourceMapper.addVideo(video);
    }

    @Override
    public void addDownload(Download download) throws Exception {
        sourceMapper.addDownload(download);
    }

    @Override
    public void alterVideo(Video video) throws Exception {
        sourceMapper.alterVideo(video);
    }

    @Override
    public void alterDownload(Download download) throws Exception {
        sourceMapper.alterDownload(download);
    }

    @Override
    public void deleteVideo(int id) throws Exception {
        sourceMapper.deleteVideo(id);
    }

    @Override
    public void deleteDownload(int id) throws Exception {
        sourceMapper.deleteDownload(id);
    }

    @Override
    public List<Video> getVideoInLimit(int limit) throws Exception {
        return sourceMapper.getVideoInLimit(limit);
    }

    @Override
    public List<Download> getDownloadInLimit(int limit) throws Exception {
        return sourceMapper.getDownloadInLimit(limit);
    }

    @Override
    public List<Video> getAllVideo() throws Exception {
        return sourceMapper.getAllVideo();
    }

    @Override
    public Video getVideo(int id) throws Exception {
        return sourceMapper.getVideo(id);
    }

    @Override
    public List<Download> getAllDownload() throws Exception {
        return sourceMapper.getAllDownload();
    }

    @Override
    public Download getDownload(int id) throws Exception {
        return sourceMapper.getDownload(id);
    }

    @Override
    public List<Video> searchVideo(String title) throws Exception {
        return sourceMapper.searchVideo(title);
    }

    @Override
    public List<Download> searchDownload(String title) throws Exception {
        return sourceMapper.searchDownload(title);
    }
}
