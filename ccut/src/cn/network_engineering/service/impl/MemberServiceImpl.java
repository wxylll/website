package cn.network_engineering.service.impl;

import cn.network_engineering.mapper.MemberMapper;
import cn.network_engineering.po.Staff;
import cn.network_engineering.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Override
    public Staff getMember(int id) throws Exception {
        return memberMapper.getMember(id);
    }

    @Override
    public List<Staff> getAll() throws Exception {
        return memberMapper.getAll();
    }

    @Override
    public void add(Staff member) throws Exception {
        memberMapper.add(member);
    }

    @Override
    public void update(Staff member) throws Exception {
        memberMapper.update(member);
    }

    @Override
    public void delete(int id) throws Exception {
        memberMapper.delete(id);
    }

}
