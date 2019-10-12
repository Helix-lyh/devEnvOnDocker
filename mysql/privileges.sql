use mysql;
# 查询所有用户
select host, user from user;
# 创建 customUser 用户
create user customUser identified with mysql_native_password by 'customUserPassword';
-- 将所有数据库的权限授权给创建的 customUser 用户，密码为123456shangshandalaohu：
-- all代表接受所有操作，比如 select,insert,delete....; *.* 代表所有库下面的所有表 % 代表这个用户允许从任何地方登录
-- 为了安全起见，这个%可以替换为你允许的ip地址；
grant all privileges on *.* to customUser@'%' identified with mysql_native_password by 'customUserPassword' with grant option;
-- 这一条命令一定要有 刷新权限：
flush privileges;