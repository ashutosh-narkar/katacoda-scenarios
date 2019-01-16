Deploy the Rook system components, which include the `Rook agent` and `Rook operator` pods.

`kubectl create -f operator.yaml`{{execute}}

Verify that `rook-ceph-operator`, `rook-ceph-agent`, and `rook-discover` pods are `Running`.
```
watch kubectl -n rook-ceph-system get pod
```{{execute T1}}

When all pods show status `Running`, hit ```clear```{{execute interrupt}} to ctrl-c and clear the screen.
