import Vue from 'vue'
import Router from 'vue-router'
// in development env not use Lazy Loading,because Lazy Loading too many pages will cause webpack hot update too slow.so only in production use Lazy Loading
/* layout */
import Layout from '../views/layout/Layout'

const _import = require('./_import_' + process.env.NODE_ENV)
Vue.use(Router)
export const constantRouterMap = [
  {path: '/login', component: _import('login/index'), hidden: true},
  {path: '/404', component: _import('404'), hidden: true},
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    name: '首页',
    hidden: true,
    children: [{
      path: 'dashboard', component: _import('dashboard/index')
    }]
  }
]
export default new Router({
  // mode: 'history', //后端支持可开
  scrollBehavior: () => ({y: 0}),
  routes: constantRouterMap
})
export const asyncRouterMap = [
  {
    path: '/system',
    component: Layout,
    redirect: '/system/model',
    name: '功能模块',
    meta: {title: '功能模块', icon: 'tree'},
    children: [
      {
        path: 'student',
        name: '学生信息',
        component: () => import('@/views/student'),
        meta: {title: '学生信息', icon: 'example'},
        menu: 'student'
      },
      {
        path: 'teacher',
        name: '教师信息',
        component: () => import('@/views/teacher'),
        meta: {title: '教师信息', icon: 'example'},
        menu: 'teacher'
      },
      {
        path: 'schoolClass',
        name: '班级信息',
        component: () => import('@/views/schoolClass'),
        meta: {title: '班级信息', icon: 'example'},
        menu: 'schoolClass'
      },
      {
        path: 'classStudentDetail',
        name: '班级学生信息',
        hidden: true,
        component: () => import('@/views/classStudentDetail'),
        meta: {title: '班级学生信息', icon: 'example'},
        menu: 'classStudentDetail'
      },
      {
        path: 'classTeacherDetail',
        name: '班级教师信息',
        hidden: true,
        component: () => import('@/views/classTeacherDetail'),
        meta: {title: '班级教师信息', icon: 'example'},
        menu: 'classTeacherDetail'
      }
    ]
  },
  {
    path: '/user',
    component: Layout,
    redirect: '/user/',
    name: '',
    meta: {title: '用户权限', icon: 'table'},
    children: [
      {
        path: '', name: '用户列表', component: _import('user/user'), meta: {title: '用户列表', icon: 'user'}, menu: 'user'
      },
      {
        path: 'role',
        name: '权限管理',
        component: _import('user/role'),
        meta: {title: '权限管理', icon: 'password'},
        menu: 'role'
      },
    ]
  },
  {path: '*', redirect: '/404', hidden: true}
]
