package cn.network_engineering.mapper;

import cn.network_engineering.po.Staff;

import java.util.List;

public interface TeamMapper {

    /**
     * 添加队伍成员
     * @param teamMember
     * @throws Exception
     */
    public void add(Staff teamMember) throws Exception;

    /**
     * 更新队员信息
     * @param teamMember
     * @throws Exception
     */
    public void update(Staff teamMember) throws Exception;

    /**
     * 删除队员
     * @param id
     * @throws Exception
     */
    public void delete(int id) throws Exception;

    /**
     * 获取指定队员信息
     * @param id
     * @return
     * @throws Exception
     */
    public Staff getTeamMember(int id) throws Exception;

    /**
     * 获取所有队员信息
     * @return
     * @throws Exception
     */
    public List<Staff> getAll() throws Exception;

}
