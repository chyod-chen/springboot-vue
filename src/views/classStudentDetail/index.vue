<template>
  <div class="app-container">
    <div>
      <el-button type="primary" icon="edit" @click="showEditClassStudent"  v-permission="'schoolClass:update'">添加班级学生</el-button>
      <el-button type="primary" @click="goBack()">返回</el-button>
    </div>
    <div><div class="my-label">班级名称:</div><div class="my-content">{{ className }}</div></div>
    <div><div class="my-label">年级:</div><div class="my-content">{{ grade }}</div></div>
    <div><div class="my-label">班级描述:</div><div class="my-content">{{ description }}</div></div>
    <el-row style="margin-top:15px;">
      <el-table :data="list" v-loading="listLoading"  border fit max-height="600px"
                highlight-current-row>
        <el-table-column align="center" label="序号" width="80">
          <template slot-scope="scope">
            <span v-text="getIndex(scope.$index)"> </span>
          </template>
        </el-table-column>
        <el-table-column align="center" prop="studentName" label="姓名" min-width="100"></el-table-column>
        <el-table-column align="center" prop="sex" label="性别" min-width="80"></el-table-column>
        <el-table-column align="center" prop="idNumber" label="身份证号" min-width="170"/>
        <el-table-column align="center" prop="phone" label="联系电话" min-width="170"/>
        <el-table-column align="center" prop="createTime" label="创建时间" min-width="160"/>
        <el-table-column align="center" prop="updateTime" label="最近修改时间" min-width="170"/>
        <el-table-column align="center" label="管理" min-width="120" >
          <template slot-scope="scope">
            <el-button type="danger" icon="delete" @click="doDelete(scope.$index)"  v-permission="'schoolClass:removeStudent'">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="listQuery.pageNum"
        :page-size="listQuery.pageRow"
        :total="totalCount"
        :page-sizes="[10, 20, 50, 100]"
        layout="total, sizes, prev, pager, next, jumper">
      </el-pagination>
    </el-row>
     <el-dialog width="90%" :title="`添加班级学生(${className})`" :visible.sync="editClassStudentFlag">
      <MaintainClassStudent ref="maintainStudent" :classId="classId" :className="className" @afterAddStudent="afterAddStudent"></MaintainClassStudent>
     </el-dialog>
  </div>
</template>
<script>
import MaintainClassStudent from './components/MaintainClassStudent.vue'
  export default {
     components: {
      MaintainClassStudent
    },
    data() {
      return {
        returnPath: '/system/schoolClass',
        className: '',
        classId: null,
        grade: '',
        description: '',
        totalCount: 0, //分页组件--数据总条数
        list: [],//表格的数据
        listLoading: false,//数据加载等待动画
        listQuery: {
          pageNum: 1,//页码
          pageRow: 50,//每页条数
          name: ''
        },
        dialogStatus: 'create',
        dialogFormVisible: false,
        editClassStudentFlag: false,
        textMap: {
          update: '编辑',
          create: '创建学生信息'
        },
        tempTeacher: {
          id: "",
          name: "",
          sex: "",
          phone: "",
          birth: "",
          major: "",
          firstDegree: "",
          deleteStatus: "1",
          title: ""
        }
      }
    },
    created() {
    },
    mounted() {
      this.returnPath = this.$route.query.returnPath
      this.classId = this.$route.query.classId
      this.className = this.$route.query.className
      this.grade = this.$route.query.grade
      this.description = this.$route.query.description
      if (this.classId) {
        this.getList()
      }
    },
    methods: {
      afterAddStudent() {
        this.editClassStudentFlag = false
        this.$nextTick(() => {
          this.getList()  
        })
      },
      showEditClassStudent() {
        this.editClassStudentFlag = true
        this.$nextTick(() => {
          this.$refs.maintainStudent.getList()  
        })
      },
      goBack() {
        this.$router.push({path: this.returnPath})
      },
      getList() {
        //查询列表
        if (!this.hasPerm('schoolClass:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/schoolClass/listStudent",
          method: "get",
          params: Object.assign(this.listQuery, { id: this.classId })
        }).then(data => {
          this.listLoading = false;
          this.list = data.list;
          this.totalCount = data.totalCount;
        })
      },
      handleSizeChange(val) {
        //改变每页数量
        this.listQuery.pageRow = val
        this.handleFilter();
      },
      handleCurrentChange(val) {
        //改变页码
        this.listQuery.pageNum = val
        this.getList();
      },
      handleFilter() {
        //改变了查询条件,从第一页开始查询
        this.listQuery.pageNum = 1
        this.getList()
      },
      getIndex($index) {
        //表格序号
        return (this.listQuery.pageNum - 1) * this.listQuery.pageRow + $index + 1
      },
      doDelete($index) {
        //显示修改对话框
        this.tempTeacher.id = this.list[$index].id;
        this.api({
          url: "/schoolClass/removeStudent",
          method: "post",
          data: this.tempTeacher
        }).then(() => {
          this.getList();
        })
      },
    }
  }
</script>
<style>
  .my-label {
    display: inline-block;
    text-align: right;
    font-size: 14px;
    font-weight: bold;
    color: rgb(121, 120, 120);
    width: 100px;
    margin: 10px 1em 0 0;
  }
  .my-content {
    display: inline-block;
    font-size: 14px;
    font-weight: bold;
    color: rgb(121, 120, 120);
  }
  .right {
    text-align: right;
  }
</style>
