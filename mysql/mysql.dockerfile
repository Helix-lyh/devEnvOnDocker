FROM mysql:8.0.17

MAINTAINER Tester_Helix<lymysql@163.com>

# 指定工作目录
WORKDIR /usr/devEnvOnDocker/mysql

# 指定挂载路径
VOLUME ["/usr/devEnvOnDocker/mysql", "/usr/devEnvOnDocker/mysql/data"]

#将所需文件放到容器中
COPY setup.sh ./
COPY privileges.sql ./

#设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

#设置免密登录
#ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

#设置容器启动时执行的命令
CMD ["sh", "./setup.sh"]
