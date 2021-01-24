#!/bin/bash

echo keyspace:$1 snapshotName:$2
Docker_Containers=$(sudo docker ps --format "{{.Names}}")
# echo $Docker_Containers
for dockercontainer in $Docker_Containers; do
	# make the snapshots with the appropriate keyspace in each container
	sudo docker exec $dockercontainer bash -c "nodetool snapshot --tag $2 -- $1"
	sudo docker exec $dockercontainer bash -c "tar -czf $dockercontainer.Snapshot.tar.gz -C var/lib/cassandra/data/ $1"
	sudo docker cp $dockercontainer:/$dockercontainer.Snapshot.tar.gz .
	sudo chmod +x $dockercontainer.Snapshot.tar.gz
done
echo "Finish the Snapshot Backup process!"