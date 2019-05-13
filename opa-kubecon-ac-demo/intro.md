![OPA Logo](/styra/scenarios/opa-kubecon-ac-demo/assets/opa.png)

In this scenario, you will learn how to enforce custom policies on Kubernetes objects using OPA.

## Demo

The demo will show how to **prevent users from creating Kubernetes Ingress objects** that violate the following organization policy:

- Two ingresses in different namespaces must not have the same hostname.

## OPA

OPA is a lightweight general-purpose policy engine that can be co-located with your service. You can integrate OPA as a sidecar, host-level daemon, or library.

Services offload policy decisions to OPA by executing queries. OPA evaluates policies and data to produce query results (which are sent back to the client). Policies are written in a high-level declarative language and can be loaded into OPA via the filesystem or well-defined APIs.

More details can be found at https://www.openpolicyagent.org/.
