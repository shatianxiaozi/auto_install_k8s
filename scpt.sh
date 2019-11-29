#!/bin/bash
i=$1
  ansible $i -m shell -a "mkdir -p /etc/kubernetes/pki/etcd; mkdir -p ~/.kube/"
  ansible $i -m copy -a 'src=/etc/kubernetes/pki/ca.crt dest=/etc/kubernetes/pki/ca.crt'
  ansible $i -m copy -a 'src=/etc/kubernetes/pki/ca.key dest=/etc/kubernetes/pki/ca.key'
  ansible $i -m copy -a 'src=/etc/kubernetes/pki/sa.key dest=/etc/kubernetes/pki/sa.key'
  ansible $i -m copy -a 'src=/etc/kubernetes/pki/sa.pub dest=/etc/kubernetes/pki/sa.pub'
  ansible $i -m copy -a 'src=/etc/kubernetes/pki/front-proxy-ca.crt dest=/etc/kubernetes/pki/front-proxy-ca.crt'
  ansible $i -m copy -a 'src=/etc/kubernetes/pki/front-proxy-ca.key dest=/etc/kubernetes/pki/front-proxy-ca.key'
  ansible $i -m copy -a 'src=/etc/kubernetes/pki/etcd/ca.crt dest=/etc/kubernetes/pki/etcd/ca.crt'
  ansible $i -m copy -a 'src=/etc/kubernetes/pki/etcd/ca.key dest=/etc/kubernetes/pki/etcd/ca.key'
  ansible $i -m copy -a 'src=/etc/kubernetes/admin.conf dest=/etc/kubernetes/admin.conf'
