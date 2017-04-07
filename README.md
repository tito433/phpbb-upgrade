# phpbb-upgrade
I'm trying to upgrade a phpbb 3.0.5 to latest phpbb 3.2



[Restore default phpBB-3.0.5 fiels]
adm/index.php
includes\acp\acp_users.php
language\en\acp\board.php

set_time_limit(3600);

[Database chagnes]
UPDATE users SET `user_type`=3, `group_id`=5 WHERE `username`='tito';

mysqldbcompare --server1=root@localhost db1164312_dremteam:phpbb32 --run-all-tests --skip-data-check --skip-row-count --skip-checksum-table --difftype=sql| clip


[select all new files during upgrade]
var rad=document.querySelectorAll('input[value="1"]');
rad.forEach(function(r){r.checked=true;});

[Upgrade task]
1. Upgrade to 3.0.14 using phpBB-3.0.5_to_3.0.14\install
2. use save\update_3.0.5_to_3.0.14.zip for replace all files.
3. Use fresh copy of phpbb3.0.14 files.
4. copy phpBB-3.0.14_to_3.2.0\install to root
5. change style_name to style_path in styles table.
6. add column 'style_parent_id' to styles table.
7. execute install/update

ALTER TABLE `users` CHANGE `user_password` `user_password` VARCHAR(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '';
#UPDATE `modules` SET `module_basename`=CONCAT(module_class,'_',module_basename) WHERE module_basename like '%main%'