#!/bin/bash

echo keyspace:$1 dockercontainer:$2
TABLE_WITH_TIME=$(sudo docker exec $2 bash -c "ls var/lib/cassandra/data/$1")
for table in $TABLE_WITH_TIME; do
	table=$(echo $table|sed 's/-.*//')
	sudo docker cp Incremental.tar*.gz $2:/
	sudo docker exec $2 bash -c "tar -xzf Incremental.tar.gz"
	sudo docker exec $2 bash -c "cp $1/$table*/backups/* var/lib/cassandra/data/$1/$table*/"
	sudo docker exec $2 bash -c "chown -R cassandra:cassandra /var/lib/cassandra/*"
	sudo docker exec $2 bash -c "nodetool refresh $1 $table"
done
echo "Finish the Incremental Restore process!"