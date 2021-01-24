#!/bin/bash

echo keyspace:$1 snapshots-name:$2 dockercontainer:$3
TABLE_WITH_TIME=$(sudo docker exec $3 bash -c "ls var/lib/cassandra/data/$1")
for table in $TABLE_WITH_TIME; do
	table=$(echo $table|sed 's/-.*//')
	sudo docker cp Snapshot.tar.gz $3:/
	sudo docker exec $3 bash -c "tar -xzf Snapshot.tar.gz"
	sudo docker exec $3 bash -c "cp $1/$table*/snapshots/$2/* var/lib/cassandra/data/$1/$table*/"
	sudo docker exec $3 bash -c "chown -R cassandra:cassandra /var/lib/cassandra/*"
	sudo docker exec $3 bash -c "nodetool refresh $1 $table"
done
echo "Finish the Snapshot Restore process!"