![OPA Logo](/styra/scenarios/opa-ceph/assets/opa.png)

In this scenario, you will learn how to enforce custom policies with OPA over the S3 API to the Ceph Storage Cluster which applications use to put and get data.

## Ceph

Ceph is a highly scalable distributed storage solution that uniquely delivers object, block, and file storage in one unified system. You can enforce fine-grained authorization over Ceph's Object Storage using OPA. Ceph's Object Storage essentially consists of a [Ceph Storage Cluster](http://docs.ceph.com/docs/nautilus/rados/#) and a [Ceph Object Gateway](http://docs.ceph.com/docs/nautilus/radosgw/).

The `Ceph Object Gateway` is an object storage interface built on top of [librados](http://docs.ceph.com/docs/nautilus/rados/api/librados-intro/) to provide applications with a RESTful gateway to Ceph Storage Clusters.

OPA is integrated with the `Ceph Object Gateway daemon (RGW)`, which is an HTTP server that interacts with a `Ceph Storage Cluster` and provides interfaces compatible with `OpenStack Swift` and `Amazon S3`.

When the `Ceph Object Gateway` gets a request, it checks with OPA whether the request should be allowed or not. OPA makes a decision (`allow` or `deny`) based on the policies and data it has access to and sends the decision back to the `Ceph Object Gateway` for enforcement.

This tutorial uses [Rook](https://rook.io/) to run Ceph inside a Kubernetes cluster.

## OPA

OPA is a lightweight general-purpose policy engine that can be co-located with your service. You can integrate OPA as a sidecar, host-level daemon, or library.

Services offload policy decisions to OPA by executing queries. OPA evaluates policies and data to produce query results (which are sent back to the client). Policies are written in a high-level declarative language and can be loaded into OPA via the filesystem or well-defined APIs.

More details can be found at https://www.openpolicyagent.org/.

![OPA](https://www.openpolicyagent.org/docs/images/benefits.svg "OPA")