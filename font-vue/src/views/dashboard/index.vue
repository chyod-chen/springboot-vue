<template>
  <div class="dashboard-container">
    <el-carousel :interval="3000" type="card" height="500px">
      <el-carousel-item>
        <img :src="student" alt="1">
      </el-carousel-item>
      <el-carousel-item>
        <img :src="teacher" alt="2">
      </el-carousel-item>
      <el-carousel-item>
        <img :src="classes" alt="3">
      </el-carousel-item>
    </el-carousel>
  </div>
</template>
<script>
import student from '@/assets/student.png'
import teacher from '@/assets/teacher.png'
import classes from '@/assets/classes.png'
  export default {
    name: 'dashboard',
    data() {
      return {
        student,teacher,classes
      }
    },
  }
</script>
<style>
  .dashboard-container {
    margin-top: 5%;
  }
  .el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 200px;
    margin: 0;
  }
  
  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }
  
  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
</style>