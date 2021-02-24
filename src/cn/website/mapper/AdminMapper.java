package cn.website.mapper;

public interface AdminMapper {

    /**
     * 账号验证
     * @param account
     * @param password
     * @return
     * @throws Exception
     */
    public int verify(String account, String password) throws Exception;

    /**
     * 修改账号
     * @throws Exception
     */
    public void modify(String account, String password) throws Exception;

}
