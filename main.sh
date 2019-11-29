#!/bin/bash 

echo -e "\033[31m 0----- 阶段<关闭防火墙> \033[0m"
sh close_wall
sleep 10
echo -e "\033[31m 1----- 阶段<初始化系统> \033[0m"
sleep 5
sh init 
echo -e "\033[31m 2----- 阶段<安装etcd> \033[0m"
sleep 5
sh etcd
echo -e "\033[31m 3----- 阶段<kubernets安装> \033[0m"
sleep 5
sh kube
echo -e "\033[31m 4----- 阶段<其他主节点的安装> \033[0m"
sleep 5
sh node_install 
rm -rf kubeadm-master.yaml

echo -e '\033[36m ---------------------[kubernetesHA集群安装完成] \033[0m'
echo '集群节点信息如下'
kubectl  get no
