package com.chenyc.example.dao;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

/**
 * @author: chenyc
 * @description: 学生信息Dao层
 * @date: 2022/7/5
 */
public interface StudentDao {
    /**
     * 新增
     */
    int addStudent(JSONObject jsonObject);

    /**
     * 统计总数
     */
    int countStudent(JSONObject jsonObject);

    /**
     * 列表
     */
    List<JSONObject> listStudent(JSONObject jsonObject);

    /**
     * 更新
     */
    int updateStudent(JSONObject jsonObject);
}
