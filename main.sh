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

#删除主节点污点
#kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl taint nodes --all node.kubernetes.io/not-ready:NoSchedule-
#安装网络 calico
kubectl apply -f ./plugin/calico/calico.yaml
cp ./plugin/calico/calicoctl /usr/bin/
chmod +x /usr/bin/calicoctl
#查看网络状态
calicoctl node status
DATASTORE_TYPE=kubernetes KUBECONFIG=~/.kube/config calicoctl get nodes
DATASTORE_TYPE=kubernetes KUBECONFIG=~/.kube/config calicoctl get ipPool -o yaml

#安装dashboard
#kubectl apply -f dash.yaml
#kubectl apply -f acount.yaml 
kubectl apply -f ./plugin/dashboard/
#查看登录web的token
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') | grep token: > ./web_token.txt

#安装metrics-server
kubectl apply -f ./plugin/metrics-server/
#测试metrics-server
# kubectl proxy --port=8080
# curl http://localhost:8080/apis/metrics.k8s.io/v1beta1/nodes 
# kubectl  top nodes

#安装ingress
kubectl apply -f ./plugin/ingress/
