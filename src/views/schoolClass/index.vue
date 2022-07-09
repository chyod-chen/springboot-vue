<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form>
        <el-form-item>
          <el-button type="primary" icon="plus" @click="showCreate" v-permission="'schoolClass:add'">添加
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
      <el-table-column align="center" prop="name" label="班级名称" min-width="160"></el-table-column>
      <el-table-column align="center" prop="grade" label="年级/届" min-width="100"/>
      <el-table-column align="center" prop="description" label="班级描述" min-width="300" show-overflow-tooltip></el-table-column>
      <el-table-column align="center" prop="createTime" label="创建时间"  width="160"/>
      <el-table-column align="center" prop="updateTime" label="最近修改时间" width="160"/>
      <el-table-column align="center" label="管理" min-width="420" >
        <template slot-scope="scope">
          <el-button type="primary" icon="edit" @click="showEditClassTeacher(scope.row)"  v-permission="'schoolClass:update'">班级教师详情</el-button>
          <el-button type="primary" icon="edit" @click="showEditClassStudent(scope.row)"  v-permission="'schoolClass:list'">班级学生详情</el-button>
          <el-button type="primary" icon="edit" @click="showUpdate(scope.$index)"  v-permission="'schoolClass:update'">修改</el-button>
          
          <el-button type="danger" icon="delete" @click="doDelete(scope.$index)"  v-permission="'schoolClass:update'">删除</el-button>
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
      <el-form class="small-space" :model="tempSchoolClass" label-position="left" label-width="100px"
               style='width: 500px; margin-left:50px;'>
        <el-form-item label="班级名称">
          <el-input type="text" show-word-limit v-model="tempSchoolClass.name"  maxlength="100">
          </el-input>
        </el-form-item>
        <el-form-item label="年级/届">
          <el-input type="text" show-word-limit v-model="tempSchoolClass.grade"  maxlength="100">
          </el-input>
        </el-form-item>
        <el-form-item label="班级描述">
          <el-input type="textarea"  :rows="8" v-model="tempSchoolClass.description" maxlength="255"  show-word-limit>
          </el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus==='create'" type="success" @click="createSchoolClass">创 建</el-button>
        <el-button type="primary" v-else @click="updateSchoolClass">修 改</el-button>
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
        editClassTeacherFlag: false,
        selectedClassName: '',
        selectedClassId: null,
        textMap: {
          update: '编辑',
          create: '创建班级信息'
        },
        tempSchoolClass: {
          id: "",
          name: "",
          description: "",
          grade: "",
          deleteStatus: "1"
        }
      }
    },
    watch: {
      selectedClassId(v) {
        if (v) {
          this.$nextTick(() => {
            this.$refs.classTeachers.getList()
            this.$refs.classStudents.getList()
          })
        }
      }
    },
    created() {
      this.getList();
    },
    methods: {
      getList() {
        //查询列表
        if (!this.hasPerm('schoolClass:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/schoolClass/list",
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
        this.tempSchoolClass.id = "";
        this.tempSchoolClass.name = "";
        this.tempSchoolClass.description = "";
        this.tempSchoolClass.grade = "";
        this.tempSchoolClass.delete_status = "1";
        this.dialogStatus = "create"
        this.dialogFormVisible = true
      },
      showUpdate($index) {
        //显示修改对话框
        this.tempSchoolClass.id = this.list[$index].id;
        this.tempSchoolClass.name = this.list[$index].name;
        this.tempSchoolClass.description = this.list[$index].description;
        this.tempSchoolClass.grade = this.list[$index].grade;
        this.tempSchoolClass.deleteStatus = "1";
        this.dialogStatus = "update"
        this.dialogFormVisible = true
      },
      showEditClassStudent(row) {
        //显示修改对话框
        //const classId = ;
        this.selectedClassName = row.name
         this.selectedClassId = row.id
        this.$router.push({ path: '/system/classStudentDetail', 
        query: { 
          classId: this.selectedClassId, 
          className: this.selectedClassName, 
          grade: row.grade,
          description: row.description,
          returnPath: this.$route.path 
        } })

      },
      showEditClassTeacher(row) {
         this.selectedClassName = row.name
         this.selectedClassId = row.id
         this.$router.push({ path: '/system/classTeacherDetail', 
         query: { 
          classId: this.selectedClassId, 
          className: this.selectedClassName, 
          grade: row.grade,
          description: row.description,
          returnPath: this.$route.path 
        } })
      },
      doDelete($index) {
        //显示修改对话框
        this.tempSchoolClass.id = this.list[$index].id;
        this.tempSchoolClass.name = this.list[$index].name;
        this.tempSchoolClass.description = this.list[$index].description;
        this.tempSchoolClass.grade = this.list[$index].grade;
        this.tempSchoolClass.deleteStatus =  "2";
        this.updateSchoolClass()
      },
      createSchoolClass() {
        //保存新班级信息
        this.api({
          url: "/schoolClass/add",
          method: "post",
          data: this.tempSchoolClass
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false
        })
      },
      updateSchoolClass() {
        //修改班级信息
        this.api({
          url: "/schoolClass/update",
          method: "post",
          data: this.tempSchoolClass
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false
        })
      },
    }
  }
</script>
