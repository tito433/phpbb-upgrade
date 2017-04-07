# phpbb-upgrade
I'm trying to upgrade a phpbb 3.0.5 to latest phpbb 3.2

[Restore corrupted files from phpBB-3.0.5]
adm/index.php
includes\acp\acp_users.php
language\en\acp\board.php

[add to phpbb3.2.0/install/app.php]
set_time_limit(3600);

[Usefull DB commands]
```
UPDATE users SET `user_type`=3, `group_id`=5 WHERE `username`='tito';

mysqldbcompare --server1=root@localhost db1164312_dremteam:phpbb32 --run-all-tests --skip-data-check --skip-row-count --skip-checksum-table --difftype=sql| clip
```

[select all new files during upgrade]
```
var rad=document.querySelectorAll('input[value="1"]');
rad.forEach(function(r){r.checked=true;});
```

[Upgrade task]
1. Upgrade to 3.0.14 using phpBB-3.0.5_to_3.0.14
2. use save\update_3.0.5_to_3.0.14.zip for replace all files.
3. Use fresh copy of phpbb3.0.14 files.
4. Cleanup forum using stk(toolkit_1_0_7)
4. Upgrade to 3.2.0 using phpBB-3.0.14_to_3.2.0