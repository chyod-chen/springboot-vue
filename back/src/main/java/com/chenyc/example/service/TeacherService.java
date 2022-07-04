package com.chenyc.example.service;

import com.alibaba.fastjson.JSONObject;
import com.chenyc.example.dao.TeacherDao;
import com.chenyc.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author: chenyc
 * @date: 2022/7/5
 */
@Service
public class TeacherService {

    @Autowired
    private TeacherDao dao;

    /**
     * 新增文章
     */
    @Transactional(rollbackFor = Exception.class)
    public JSONObject addTeacher(JSONObject jsonObject) {
        dao.addTeacher(jsonObject);
        return CommonUtil.successJson();
    }

    /**
     * 文章列表
     */
    public JSONObject listTeacher(JSONObject jsonObject) {
        CommonUtil.fillPageParam(jsonObject);
        int count = dao.countTeacher(jsonObject);
        List<JSONObject> list = dao.listTeacher(jsonObject);
        return CommonUtil.successPage(jsonObject, list, count);
    }

    /**
     * 更新文章
     */
    @Transactional(rollbackFor = Exception.class)
    public JSONObject updateTeacher(JSONObject jsonObject) {
        dao.updateTeacher(jsonObject);
        return CommonUtil.successJson();
    }
}
