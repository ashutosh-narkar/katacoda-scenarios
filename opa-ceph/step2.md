`kubectl apply -f opa.yaml`{{execute}}

The OPA spec contains a ConfigMap where an OPA policy has been defined. This policy will be used to authorize requests received by the `Ceph Object Gateway`. More details on this policy will be covered later in the tutorial.

Verify that the OPA pod is `Running`.
```
watch kubectl -n rook-ceph get pod -l app=opa
```{{execute T1}}

When the OPA pod show status `Running`, hit ```clear```{{execute interrupt}} to ctrl-c and clear the screen.