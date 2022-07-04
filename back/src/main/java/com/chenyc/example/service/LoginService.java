package com.chenyc.example.service;

import com.alibaba.fastjson.JSONObject;
import com.chenyc.example.config.exception.CommonJsonException;
import com.chenyc.example.dao.LoginDao;
import com.chenyc.example.dto.session.SessionUserInfo;
import com.chenyc.example.util.CommonUtil;
import com.chenyc.example.util.constants.ErrorEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author: chenyc
 * @description: 登录service实现类
 * @date: 2022/7/5
 */
@Service
@Slf4j
public class LoginService {

    @Autowired
    private LoginDao loginDao;
    @Autowired
    private TokenService tokenService;

    /**
     * 登录表单提交
     */
    public JSONObject authLogin(JSONObject jsonObject) {
        String username = jsonObject.getString("username");
        String password = jsonObject.getString("password");
        JSONObject info = new JSONObject();
        JSONObject user = loginDao.checkUser(username, password);
        if (user == null) {
            throw new CommonJsonException(ErrorEnum.E_10010);
        }
        String token = tokenService.generateToken(username);
        info.put("token", token);
        return CommonUtil.successJson(info);
    }

    /**
     * 查询当前登录用户的权限等信息
     */
    public JSONObject getInfo() {
        //从session获取用户信息
        SessionUserInfo userInfo = tokenService.getUserInfo();
        log.info(userInfo.toString());
        return CommonUtil.successJson(userInfo);
    }

    /**
     * 退出登录
     */
    public JSONObject logout() {
        tokenService.invalidateToken();
        return CommonUtil.successJson();
    }
}
