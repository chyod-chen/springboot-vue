package com.chenyc.example.dao;

import com.alibaba.fastjson.JSONObject;
import com.chenyc.example.dto.session.SessionUserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.Set;

/**
 * @author: chenyc
 * @description: 登录相关dao
 * @date: 2022/7/5
 */
public interface LoginDao {
    /**
     * 根据用户名和密码查询对应的用户
     */
    JSONObject checkUser(@Param("username") String username, @Param("password") String password);

    SessionUserInfo getUserInfo(String username);

    Set<String> getAllMenu();

    Set<String> getAllPermissionCode();
}
