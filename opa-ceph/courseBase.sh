ssh root@host01 "minikube start && eval $(minikube docker-env)"
ssh root@host01 "docker pull openpolicyagent/rook-operator:latest && ceph/daemon-base:latest-master"
