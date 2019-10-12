#!/bin/bash
# set -e
# mysql8.0 需要在启动前初始化 同时提取root用户账号
initFlag=0
echo '执行mysql启动过程'
echo '判断是否需要初始化Mysql...'
if [ -f "./do_not_init" ]; then
    echo "找到 do_not_init 不执行初始化!"
else
    echo '未找到 do_not_init!'
    echo '初始化Mysql...'
    # 初始化 mysql 并写 do_not_init 文件防止再次初始化 以及设置 initFlag
    mysqld  --initialize
    touch do_not_init
    initFlag=1
    echo '从初始化日志中提取初始密码...'
    logFiles=`find  .  -type f -regex  ".*\.\(err\)"`
    for file in $logFiles
    do
        # cut -f 11 -d " " 写法强依赖日志格式 如有错误需调整 
        tempPwd=`cat $file | grep 'A temporary password is generated for' | cut -f 11 -d " "`
        if [ $tempPwd ];then
            echo "getTempPwd 匹配到 " $tempPwd 
        fi
    done
    if [ $tempPwd = "" ];then
        echo "未匹配到tempPwd"
    fi
fi

echo '启动mysql....'
service mysql start
sleep 10
if [ initFlag=1 ];then
    echo '检测到 initFlag=1 开始创建用户及授权....'
    mysql < privileges.sql
    sleep 5
fi
echo `mysql容器启动完毕!`
tail -f /dev/null
