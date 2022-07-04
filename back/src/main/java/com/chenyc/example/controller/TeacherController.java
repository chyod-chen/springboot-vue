package com.chenyc.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.chenyc.example.config.annotation.RequiresPermissions;
import com.chenyc.example.service.TeacherService;
import com.chenyc.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/***
* @Description: 教师信息
* @Author: chenyc
* @Date: 2022/7/5
*/
@RestController
@RequestMapping("/teacher")
public class TeacherController {

    @Autowired
    private TeacherService service;

    /**
     * 查询
     */
    @RequiresPermissions("teacher:list")
    @GetMapping("/list")
    public JSONObject list(HttpServletRequest request) {
        return service.listTeacher(CommonUtil.request2Json(request));
    }

    /**
     * 新增
     */
    @RequiresPermissions("teacher:add")
    @PostMapping("/add")
    public JSONObject add(@RequestBody JSONObject requestJson) {
        CommonUtil.hasAllRequired(requestJson, "name");
        return service.addTeacher(requestJson);
    }

    /**
     * 修改
     */
    @RequiresPermissions("teacher:update")
    @PostMapping("/update")
    public JSONObject update(@RequestBody JSONObject requestJson) {
        CommonUtil.hasAllRequired(requestJson, "id,name");
        return service.updateTeacher(requestJson);
    }
}
