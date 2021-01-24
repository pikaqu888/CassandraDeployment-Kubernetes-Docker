#!/bin/bash

echo keyspace:$1
Docker_Containers=$(sudo docker ps --format "{{.Names}}")
# echo $Docker_Containers
for dockercontainer in $Docker_Containers; do
	# enable incremental backup
	sudo docker exec $dockercontainer bash -c "nodetool enablebackup"
	# make an incremental copy
	sudo docker exec $dockercontainer bash -c "nodetool flush $1"
	sudo docker exec $dockercontainer bash -c "tar -czf $dockercontainer.Incremental.tar.gz -C var/lib/cassandra/data/ $1"
	sudo docker cp $dockercontainer:/$dockercontainer.Incremental.tar.gz .
	sudo chmod +x $dockercontainer.Incremental.tar.gz
done
echo "Finish the Incremental Backup process!"