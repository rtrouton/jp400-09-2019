#!/bin/bash

##No credentials Mysql
#mysql --defaults-file=/tmp/my.cnf -hjamf.pro.server.here database_name_here -BsN -e "SHOW TABLES"

computerIDs=$( mysql --defaults-file=/tmp/my.cnf -hjamf.pro.server.here database_name_here -BsN -e "SELECT computer_id FROM computers_denormalized" )

for computerID in $computerIDs;do
	computerName=$( mysql --defaults-file=/tmp/my.cnf -hjamf.pro.server.here database_name_here -BsN -e "SELECT computer_name FROM computers_denormalized WHERE computer_id = '$computerID'")
	echo "Your computer name is: $computerName"
	echo "Your computer ID is: $computerID"
done