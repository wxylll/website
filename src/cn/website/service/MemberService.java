package cn.website.service;

import cn.website.po.Staff;

import java.util.List;

public interface MemberService {

    /**
     * 获取指定成员
     * @param id
     * @return
     * @throws Exception
     */
    public Staff getMember(int id) throws Exception;

    /**
     * 获取所有成员
     * @return
     * @throws Exception
     */
    public List<Staff> getAll() throws Exception;

    /**
     * 添加成员
     * @param member
     * @throws Exception
     */
    public void add(Staff member) throws Exception;

    /**
     * 更新成员信息
     * @param member
     * @throws Exception
     */
    public void update(Staff member) throws Exception;

    /**
     * 删除成员
     * @param id
     * @throws Exception
     */
    public void delete(int id) throws Exception;

}
