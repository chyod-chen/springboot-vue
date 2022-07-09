<template>
  <div class="app-container">
    <el-button :disabled="!this.multipleSelection || this.multipleSelection.length === 0" type="primary" @click="addStudents">添加</el-button>
      <!-- <el-button @click="toggleSelection([tableData[1], tableData[2]])">切换第二、第三行的选中状态</el-button>
      <el-button @click="toggleSelection()">取消选择</el-button> -->
      <el-table ref="multipleTable1" :data="list" v-loading="listLoading" tooltip-effect="dark" border fit max-height="600px"
              highlight-current-row @selection-change="handleSelectionChange">
      <el-table-column
        type="selection"
        width="55">
      </el-table-column>
      <el-table-column align="center" label="序号" width="80">
        <template slot-scope="scope">
          <span v-text="getIndex(scope.$index)"> </span>
        </template>
      </el-table-column>
      <el-table-column align="center" prop="name" label="姓名" min-width="100"></el-table-column>
      <el-table-column align="center" prop="sex" label="性别" min-width="80"></el-table-column>
      <el-table-column align="center" prop="idNumber" label="身份证号" min-width="170"/>
      <el-table-column align="center" prop="phone" label="联系电话" min-width="170"/>
      <el-table-column align="center" prop="createTime" label="创建时间" min-width="160"/>
      <el-table-column align="center" prop="updateTime" label="最近修改时间" min-width="170"/>
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
  </div>
</template>
<script>
  export default {
    name: 'MaintainClassStudent',
    props: {
      classId: {
        type: Number,
        default: null
      },
      className: {
        type: String,
        default: ''
      }
    },
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
		multipleSelection: []
      }
    },
    created() {
    },
    mounted() {
      if (this.classId) {
        this.getList()
      }
    },
    methods: {
      addStudents() {
        this.api({
          url: "/schoolClass/addStudent",
          method: "post",
          data: {classId: this.classId, studentIds: this.multipleSelection.map(obj => {return obj.id}) }
        }).then(() => {
          this.getList();
          this.$emit('afterAddStudent')
        })
      },
      removeStudents() {

      },
	  toggleSelection(rows) {
        if (rows) {
          rows.forEach(row => {
            this.$refs.multipleTable1.toggleRowSelection(row);
          });
        } else {
          this.$refs.multipleTable1.clearSelection();
        }
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      getList() {
        //查询列表
        if (!this.hasPerm('student:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/student/listNoClassStudent",
          method: "get",
          params: Object.assign(this.listQuery, { classId: this.classId })
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
	  
    }
  }
</script>
