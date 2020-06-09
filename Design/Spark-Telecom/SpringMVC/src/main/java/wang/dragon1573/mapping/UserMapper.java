package wang.dragon1573.mapping;

import java.util.List;

import wang.dragon1573.model.*;

/**
 * 用户数据集映射接口
 *
 * @author Dragon1573
 */
public interface UserMapper {
    /**
     * 用户详细资料分析
     *
     * @param areaName
     *     用户地址
     * @param channelName
     *     渠道名称
     * @return 数据集
     */
    List<ViewUserDetail> getDetail(String areaName, String channelName);

    /**
     * 根据用户编号获取专业用户列表
     *
     * @param id
     *     用户编号
     * @return 专业用户列表
     */
    List<User> getProUser(int id);

    /**
     * 根据用户编号查找指定用户
     *
     * @param id
     *     用户编号
     * @return 用户信息
     */
    User getUser(int id);

    /**
     * 获取全体用户列表
     *
     * @return 用户列表
     */
    List<User> getUsers();

    /**
     * 单一用户用户渠道趋势分析
     *
     * @param dim
     *     维度
     * @return 数据集
     */
    List<ViewAreaChannel> getViewAreaChannel(String dim);

    /**
     * 全体用户渠道趋势分析
     *
     * @return 数据集
     */
    List<ViewAreaChannel> getViewAreaChannelAll();

    /**
     * 获取用户渠道趋势分析维度
     *
     * @return 数据集
     */
    List<String> getViewAreaChannelDim();

    /**
     * 用户请求方式对比分析
     *
     * @param dim
     *     特定维度
     * @return 数据集
     */
    List<ViewAreaRequestType> getViewAreaRequestType(String dim);

    /**
     * 所有用户请求方式对比分析
     *
     * @return 数据集
     */
    List<ViewAreaRequestType> getViewAreaRequestTypeAll();

    /**
     * 获取用户请求方式维度
     *
     * @return 数据集
     */
    List<String> getViewAreaRequestTypeDim();

    /**
     * 用户渠道饼图分析
     *
     * @return 数据集
     */
    List<ViewChannelNo> getViewChannelNo();

    /**
     * 插入用户数据
     *
     * @param user
     *     用户信息
     * @return 用户数量
     */
    int insertUser(User user);
}
