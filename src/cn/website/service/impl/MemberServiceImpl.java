package cn.website.service.impl;

import cn.website.mapper.MemberMapper;
import cn.website.po.Staff;
import cn.website.service.MemberService;
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
