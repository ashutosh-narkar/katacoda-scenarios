The `Ceph Object Gateway` needs to be configured to use OPA for authorization decisions. The following configuration options are available for the OPA integration with the gateway:

```bash
rgw use opa authz = {use opa server to authorize client requests}
rgw opa url = {opa server url:opa server port}
rgw opa token = {opa bearer token}
rgw opa verify ssl = {verify opa server ssl certificate}
```

More information on the OPA - Ceph Object Gateway integration can be found in the Ceph [docs](http://docs.ceph.com/docs/nautilus/radosgw/opa/).

When the Rook Operator creates a cluster, a placeholder ConfigMap is created that can be used to override Ceph's configuration settings.

Update the ConfigMap to include the OPA-related options.

`kubectl -n rook-ceph edit configmap rook-config-override`{{execute}}

Modify the settings and save. Each line you add should be indented from the `config` property as such:

```bash
apiVersion: v1
kind: ConfigMap
metadata:
  name: rook-config-override
  namespace: rook-ceph
data:
  config: |
    [client.radosgw.gateway]
    rgw use opa authz = true
    rgw opa url = opa.rook-ceph:8181/v1/data/ceph/authz/allow
```
