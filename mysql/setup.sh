#!/bin/bash
# set -e

#查看mysql服务的状态，方便调试，这条语句可以删除
echo `service mysql status`
echo '启动mysql....'

#启动mysql
service mysql start
sleep 10

# 重新设置mysql密码
echo `service mysql status`
echo '开始创建用户及授权....'
mysql < privileges.sql
sleep 5

echo `service mysql status`
echo `mysql容器启动完毕,且用户创建和授权完成~`
tail -f /dev/null