package com.chenyc.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.chenyc.example.config.annotation.RequiresPermissions;
import com.chenyc.example.service.StudentService;
import com.chenyc.example.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/***
* @Description: 学生信息
* @Author: chenyc
* @Date: 2022/7/5
*/
@RestController
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;

    /**
     * 查询
     */
    @RequiresPermissions("student:list")
    @GetMapping("/list")
    public JSONObject list(HttpServletRequest request) {
        return studentService.listStudent(CommonUtil.request2Json(request));
    }

    /**
     * 新增
     */
    @RequiresPermissions("student:add")
    @PostMapping("/add")
    public JSONObject add(@RequestBody JSONObject requestJson) {
        CommonUtil.hasAllRequired(requestJson, "name");
        return studentService.addStudent(requestJson);
    }

    /**
     * 修改
     */
    @RequiresPermissions("student:update")
    @PostMapping("/update")
    public JSONObject update(@RequestBody JSONObject requestJson) {
        CommonUtil.hasAllRequired(requestJson, "id,name");
        return studentService.updateStudent(requestJson);
    }
}
