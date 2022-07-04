package com.chenyc.example.service;

import com.alibaba.fastjson.JSONObject;
import com.chenyc.example.dao.StudentDao;
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
public class StudentService {

    @Autowired
    private StudentDao studentDao;

    /**
     * 新增文章
     */
    @Transactional(rollbackFor = Exception.class)
    public JSONObject addStudent(JSONObject jsonObject) {
        studentDao.addStudent(jsonObject);
        return CommonUtil.successJson();
    }

    /**
     * 文章列表
     */
    public JSONObject listStudent(JSONObject jsonObject) {
        CommonUtil.fillPageParam(jsonObject);
        int count = studentDao.countStudent(jsonObject);
        List<JSONObject> list = studentDao.listStudent(jsonObject);
        return CommonUtil.successPage(jsonObject, list, count);
    }

    /**
     * 更新文章
     */
    @Transactional(rollbackFor = Exception.class)
    public JSONObject updateStudent(JSONObject jsonObject) {
        studentDao.updateStudent(jsonObject);
        return CommonUtil.successJson();
    }
}
