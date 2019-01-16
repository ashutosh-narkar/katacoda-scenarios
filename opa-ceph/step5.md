`kubectl create -f object.yaml`{{execute}}

When the object store is created, the RGW service with the S3 API will be started in the cluster. The Rook operator will create all the pools and other resources necessary to start the service.

Check that the RGW pod is `Running`.
```
watch kubectl -n rook-ceph get pod -l app=rook-ceph-rgw
```{{execute T1}}

When the RGW pod shows status `Running`, hit ```clear```{{execute interrupt}} to ctrl-c and clear the screen.

Rook sets up the object storage so pods will have access internal to the cluster. Create a new service for external access. We will need the external RGW service for exercising our OPA policy.

Create the external service.

`kubectl create -f rgw-external.yaml`{{execute}}

Check that both the `internal` and `external` RGW services are `Running`.

`kubectl -n rook-ceph get service rook-ceph-rgw-my-store rook-ceph-rgw-my-store-external`{{execute}}