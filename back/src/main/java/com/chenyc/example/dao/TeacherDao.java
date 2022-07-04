package com.chenyc.example.dao;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

/**
 * @author: chenyc
 * @description: 教师信息Dao层
 * @date: 2022/7/5
 */
public interface TeacherDao {
    /**
     * 新增
     */
    int addTeacher(JSONObject jsonObject);

    /**
     * 统计总数
     */
    int countTeacher(JSONObject jsonObject);

    /**
     * 列表
     */
    List<JSONObject> listTeacher(JSONObject jsonObject);

    /**
     * 更新
     */
    int updateTeacher(JSONObject jsonObject);
}
