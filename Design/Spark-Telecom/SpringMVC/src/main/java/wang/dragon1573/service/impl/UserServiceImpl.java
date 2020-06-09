package wang.dragon1573.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import wang.dragon1573.mapping.UserMapper;
import wang.dragon1573.model.*;
import wang.dragon1573.service.UserService;

/**
 * 用户数据集查询服务实现
 *
 * @author Dragon1573
 */
@Service("userService")
public class UserServiceImpl implements UserService {
    private UserMapper userMapper;

    @Override
    public List<ViewUserDetail> getDetail(
        final String areaName, final String channelName
    ) {
        return userMapper.getDetail(areaName, channelName);
    }

    @Override
    public List<User> getProUser(final int id) {
        return userMapper.getProUser(id);
    }

    @Override
    public User getUser(final int id) {
        return userMapper.getUser(id);
    }

    @Override
    public List<User> getUsers() {
        return userMapper.getUsers();
    }

    @Override
    public List<ViewAreaChannel> getViewAreaChannel(final String dim) {
        return userMapper.getViewAreaChannel(dim);
    }

    @Override
    public List<ViewAreaChannel> getViewAreaChannelAll() {
        return userMapper.getViewAreaChannelAll();
    }

    @Override
    public List<String> getViewAreaChannelDim() {
        return userMapper.getViewAreaChannelDim();
    }

    @Override
    public List<ViewAreaRequestType> getViewAreaRequestType(final String dim) {
        return userMapper.getViewAreaRequestType(dim);
    }

    @Override
    public List<ViewAreaRequestType> getViewAreaRequestTypeAll() {
        return userMapper.getViewAreaRequestTypeAll();
    }

    @Override
    public List<String> getViewAreaRequestTypeDim() {
        return userMapper.getViewAreaRequestTypeDim();
    }

    @Override
    public List<ViewChannelNo> getViewChannelNo() {
        return userMapper.getViewChannelNo();
    }

    @Override
    public int insertUser(final User user) {
        return userMapper.insertUser(user);
    }

    @Autowired
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }
}
