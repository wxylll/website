package cn.network_engineering.service;

/**
 * 后台管理员业务
 */
public interface AdminService {

    /**
     * 登录
     * @param account
     * @param password
     * @return
     * @throws Exception
     */
    public boolean login(String account, String password) throws Exception;

    /**
     * 修改账号信息
     * @param account
     * @param password
     * @throws Exception
     */
    public void modify(String account, String password) throws Exception;

}
