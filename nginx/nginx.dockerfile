FROM nginx:stable

MAINTAINER Tester_Helix<lymysql@163.com>

# 指定挂载路径
VOLUME ["/usr/devEnvOnDocker/nginx", ,"/usr/devEnvOnDocker/logs/", "/etc/nginx/conf.d"]

# 修改时区配置
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone

# 移除默认配置 增加定制配置
RUN rm /etc/nginx/conf.d/default.conf \
    && sed -i '16 s/^/client_max_body_size 1024m;\n/' /etc/nginx/nginx.conf