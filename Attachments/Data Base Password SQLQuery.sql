CREATE LOGIN post_user WITH PASSWORD = 'P@$$w0rdMSmcse';
CREATE USER post_user FOR LOGIN post_user;
ALTER ROLE db_owner ADD MEMBER post_user;
EXEC sp_change_users_login 'Auto_Fix', 'post_user';
ALTER SERVER ROLE sysadmin ADD MEMBER post_user;
GRANT CONTROL SERVER TO [post_user];