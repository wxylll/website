package cn.network_engineering.service.impl;

import cn.network_engineering.mapper.AdminMapper;
import cn.network_engineering.service.AdminService;
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
