FROM mongo:4.2.0-bionic

MAINTAINER Tester_Helix<lymysql@163.com>

WORKDIR /data/usr/mongodb/bin/
COPY mongodb.conf .

# 修改时区配置
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone

# 指定挂载路径
VOLUME ["/usr/devEnvOnDocker/mongoDB", "/etc/nginx/conf.d"]

# 暴露 27017 端口
EXPOSE 27017

# 执行命令
CMD ["mongod","-f", "mongodb.conf"]