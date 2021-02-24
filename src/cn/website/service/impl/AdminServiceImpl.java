package cn.website.service.impl;

import cn.website.mapper.AdminMapper;
import cn.website.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;

public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public boolean login(String account, String password) throws Exception {
        return adminMapper.verify(account, password) > 0 ? true : false;
    }

    @Override
    public void modify(String account, String password) throws Exception {
        adminMapper.modify(account, password);
    }
}
