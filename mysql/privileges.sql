use mysql;
select host, user from user;
-- 因为mysql版本是5.7，因此新建用户为如下命令：
create user testgroup identified by '123456shangshandalaohu';
-- 将所有数据库的权限授权给创建的testgroup用户，密码为123456shangshandalaohu：
-- grant all privileges on *.* to 'test'@'%'identified by '123456' with grant option
-- all代表接受所有操作，比如 select,insert,delete....; *.* 代表所有库下面的所有表;% 代表这个用户允许从任何地方登录；为了安全起见，这个%可以替换为你允许的ip地址；
grant all privileges on *.* to testgroup@'%' identified by '123456shangshandalaohu' with grant option;
-- 这一条命令一定要有：
flush privileges;