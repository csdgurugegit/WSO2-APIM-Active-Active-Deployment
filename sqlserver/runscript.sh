#!/bin/bash

mysql --defaults-extra-file=/home/cnf/root.cnf -e "USE apim_db" 2>/dev/null 1>/dev/null && mysql --defaults-extra-file=/home/cnf/root.cnf -e "USE shared_db" 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]
then
   echo $?
   echo "creating apim_db, shared_db databases and tables"
   mysql --defaults-extra-file=/home/cnf/root.cnf < '/home/dbscripts/req_run.sql'
   mysql --defaults-extra-file=/home/cnf/apimadmin.cnf < '/home/dbscripts/apim_db.sql'
   mysql --defaults-extra-file=/home/cnf/sharedadmin.cnf < '/home/dbscripts/shared_db.sql'
   echo "apim_db, shared_db databases and tables successfully created"
else
   echo "apim_db and shared_db databases and tables already exist"
fi
