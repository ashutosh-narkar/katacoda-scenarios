For the cluster to survive reboots, make sure you set the `dataDirHostPath` property that is valid for your hosts. For minikube, `dataDirHostPath` is set to `/data/rook`.

Create the cluster:
`kubectl create -f cluster.yaml`{{execute}}

Verify that `rook-ceph-mgr-a`, `rook-ceph-mon-a`, `rook-ceph-mon-b`, `rook-ceph-mon-c` and `rook-ceph-osd-0` pods are `Running`.
```
watch kubectl -n rook-ceph get pod
```{{execute T1}}

When all pods show status `Running`, hit ```clear```{{execute interrupt}} to ctrl-c and clear the screen.
