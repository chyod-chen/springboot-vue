<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form>
        <el-form-item>
          <el-button type="primary" icon="plus" @click="showCreate" v-permission="'teacher:add'">添加
          </el-button>
        </el-form-item>
      </el-form>
    </div>
    <el-table :data="list" v-loading="listLoading"  border fit max-height="600px"
              highlight-current-row>
      <el-table-column align="center" label="序号" width="80">
        <template slot-scope="scope">
          <span v-text="getIndex(scope.$index)"> </span>
        </template>
      </el-table-column>
      <el-table-column align="center" prop="name" label="姓名" min-width="100"></el-table-column>
      <el-table-column align="center" prop="sex" label="性别" min-width="80"></el-table-column>
      <el-table-column align="center" prop="birth" label="出生日期" min-width="170"/>
      <el-table-column align="center" prop="phone" label="联系电话" min-width="170"/>
      <el-table-column align="center" prop="firstDegree" label="第一学历" min-width="170"/>
      <el-table-column align="center" prop="major" label="专业" min-width="170"/>
      <el-table-column align="center" prop="title" label="职称" min-width="170"/>
      <el-table-column align="center" prop="createTime" label="创建时间" min-width="160"/>
      <el-table-column align="center" prop="updateTime" label="最近修改时间" min-width="170"/>
      <el-table-column align="center" label="管理" min-width="200" >
        <template slot-scope="scope">
          <el-button type="primary" icon="edit" @click="showUpdate(scope.$index)"  v-permission="'teacher:update'">修改</el-button>
          <el-button type="danger" icon="delete" @click="doDelete(scope.$index)"  v-permission="'teacher:update'">删除</el-button>
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
    <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
      <el-form class="small-space" :model="tempTeacher" label-position="left" label-width="100px"
               style='width: 500px; margin-left:50px;'>
        <el-form-item label="姓名">
          <el-input type="text" show-word-limit v-model="tempTeacher.name"  maxlength="100">
          </el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-input type="text" show-word-limit v-model="tempTeacher.sex"  maxlength="100">
          </el-input>
        </el-form-item>
        <el-form-item label="出生日期">
          <el-input type="text" show-word-limit v-model="tempTeacher.birth"  maxlength="100">
          </el-input>
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input type="text" show-word-limit v-model="tempTeacher.phone"  maxlength="100">
          </el-input>
        </el-form-item>
        <el-form-item label="第一学历">
          <el-input type="text" show-word-limit v-model="tempTeacher.firstDegree"  maxlength="100">
          </el-input>
        </el-form-item>
        <el-form-item label="专业">
          <el-input type="text" show-word-limit v-model="tempTeacher.major"  maxlength="100">
          </el-input>
        </el-form-item>
        <el-form-item label="职称">
          <el-input type="text" show-word-limit v-model="tempTeacher.title"  maxlength="100">
          </el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus==='create'" type="success" @click="createTeacher">创 建</el-button>
        <el-button type="primary" v-else @click="updateTeacher">修 改</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
  export default {
    data() {
      return {
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
        textMap: {
          update: '编辑',
          create: '创建教师信息'
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
      this.getList();
    },
    methods: {
      getList() {
        //查询列表
        if (!this.hasPerm('teacher:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/teacher/list",
          method: "get",
          params: this.listQuery
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
      showCreate() {
        //显示新增对话框
        this.tempTeacher.id = "";
        this.tempTeacher.name = "";
        this.tempTeacher.sex = "";
        this.tempTeacher.phone = "";
        this.tempTeacher.major = "";
        this.tempTeacher.firstDegree = "";
        this.tempTeacher.birth = "";
        this.tempTeacher.title = "";
        this.tempTeacher.deleteStatus =  "1";
        this.dialogStatus = "create"
        this.dialogFormVisible = true
      },
      showUpdate($index) {
        //显示修改对话框
        this.tempTeacher.id = this.list[$index].id;
        this.tempTeacher.name = this.list[$index].name;
        this.tempTeacher.sex = this.list[$index].sex;
        this.tempTeacher.idNumber = this.list[$index].idNumber;
        this.tempTeacher.phone = this.list[$index].phone;
        this.tempTeacher.deleteStatus =  "1";
        this.dialogStatus = "update"
        this.dialogFormVisible = true
      },
      doDelete($index) {
        //显示修改对话框
        this.tempTeacher.id = this.list[$index].id;
        this.tempTeacher.name = this.list[$index].name;
        this.tempTeacher.sex = this.list[$index].sex;
        this.tempTeacher.idNumber = this.list[$index].idNumber;
        this.tempTeacher.phone = this.list[$index].phone;
        this.tempTeacher.deleteStatus =  "2";
        this.updateTeacher()
      },
      createTeacher() {
        //保存新教师信息
        this.api({
          url: "/teacher/add",
          method: "post",
          data: this.tempTeacher
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false
        })
      },
      updateTeacher() {
        //修改教师信息
        this.api({
          url: "/teacher/update",
          method: "post",
          data: this.tempTeacher
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false
        })
      },
    }
  }
</script>
