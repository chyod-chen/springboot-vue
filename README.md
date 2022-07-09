# springboot-vue
基于springboot+mybatis+vue+shiro构建的一套管理系统

本项目只是本人用来做毕设随手开发的. 很多配置都是默认,适用于新手想要了解springboot,vue,mybatis,shiro.

## 运行环境: JDK1.8, Mysql5.7, node.js(v14.17.1)
各细项版本说明: springboot 2.x, vue 2.6, elementUi 2.15(当前最新,配置里面加了^)

#如何运行该项目:
后端java项目在back包, 前端vue项目在font-vue包; 数据库基础DDL以及示例数据在db.sql文件中; 
## 最简单的运行:
后端:
1. 打开自己的mysql, 创建example数据库, 然后全选执行db.sql; 
2. 找到application-local.yml/application-prod.yml 修改datasource, 修改完毕后端就可以启动了,默认端口是8080,要是改了前端记得同步修改

前端: 
1. 我一般用vscode开前端项目, 如果你没有改端口, 在node.js安装好之后;
npm install
npm run dev

前端端口是9520, 前端启动会自动访问登录页.

## 权限说明:
sys_permission里面配置了各种菜单权限,按钮权限;
sys_role 配置角色
sys_role_permission 配置角色权限关系;
sys_user_role 配置用户角色关联;
