# Two datacenters of Cassandra in Kubernetes 

## For each datacenter we will require 2 services, first one for managing internal Cassandra load balancer and other for exposing external IP

```
kubectl get nodes
```
```
kubectl label nodes aks-cassnode-25220521-vmss000000 dc=DC1
```
```
kubectl label nodes aks-cassnode-25220521-vmss000001 dc=DC2
```
```
kubectl apply -f persistentVolumeClaimDisk.yaml
```
```
kubectl get pvc
```
```
kubectl apply -f cassandra-service.yaml
```
```
kubectl apply -f cassandra-service-ext.yaml
```
```
kubectl apply -f cassandra-statefulset-spain.yaml
```
```
kubectl apply -f cassandra-statefulset-russia.yaml
```
```
kubectl get pods -o wide
```
```
kubectl get svc
```
```
kubectl exec -it cassandra-cluster-spain-0 -- nodetool status
```
![Alt text](/Users/zhongtianlin/Desktop/Picture1.png)
