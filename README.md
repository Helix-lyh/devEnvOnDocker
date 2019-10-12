# devEnvOnDocker
基于Docker的程序开发环境部署项目, 包含数据库/缓存/消息队列/反向代理等常用中间件

### 使用方法:
1. 环境需求
- linux 需要 centOS 7.0+ Ubuntu 16.04+
- docker 推荐 18.09.3+
- docker-compose 1.24.1 + 

2. 环境准备
docker安装: 略
docker-compose (官网方式):
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
3. 拉取代码至目标服务器
```
sudo git clone https://github.com/Helix-lyh/devEnvOnDocker.git && sudo chmod -R 777 devEnvOnDocker
```

4. 启动各中间件
```
cd devEnvOnDocker && sudo docker-compose -f startAll.yml up -d
```

5. 各中间件 登录账号密码 及 mysql 配置(请自行修改startAll.yml实现定制!!!)
```
redis        redisPassword
mysql        root / superUserPassword  customUser / customUserPassword
postgresDB   root / superUserPassword
mongoDB      root / superUserPassword
rabbitMQ     customUser / customUserPassword
```
因 mysql 限制 需要手动进入容器后配置 相关命令如下:
```
# 进入容器(mysql_db 对应容器名称)
sudo docker exec -it mysql_db /bin/bash
# 以下在容器中执行
# 登录 mysql 
mysql -uroot -psuperUserPassword
# 查询当前用户(非必须执行语句)
select user,host,authentication_string from mysql.user;
# 指定 root 用户 的密码验证方式
ALTER user 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'superUserPassword';
# 指定 customUser 用户权限(此为root权限) 同时指定可以在任意host登录
grant all PRIVILEGES on *.* to customUser@'%' WITH GRANT OPTION;
# 指定 customUser 用户的密码永不过期
ALTER user 'customUser'@'%' IDENTIFIED BY 'customUserPassword' PASSWORD EXPIRE NEVER;
# 指定 customUser 用户 的密码验证方式为mysql_native_password (便于navicat等链接)
ALTER user 'customUser'@'%' IDENTIFIED WITH mysql_native_password BY 'customUserPassword';
# 刷新权限
FLUSH PRIVILEGES;
```
