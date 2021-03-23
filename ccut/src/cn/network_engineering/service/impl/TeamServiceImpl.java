package cn.network_engineering.service.impl;

import cn.network_engineering.mapper.TeamMapper;
import cn.network_engineering.po.Staff;
import cn.network_engineering.service.TeamService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class TeamServiceImpl implements TeamService {

    @Autowired
    private TeamMapper teamMapper;

    @Override
    public void add(Staff teamMember) throws Exception {
        teamMapper.add(teamMember);
    }

    @Override
    public void update(Staff teamMember) throws Exception {
        teamMapper.update(teamMember);
    }

    @Override
    public void delete(int id) throws Exception {
        teamMapper.delete(id);
    }

    @Override
    public Staff getTeamMember(int id) throws Exception {
        return teamMapper.getTeamMember(id);
    }

    @Override
    public List<Staff> getAll() throws Exception {
        return teamMapper.getAll();
    }

}
