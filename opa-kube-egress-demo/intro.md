![OPA Logo](/styra/scenarios/opa-kube-egress-demo/assets/opa.png)

**WIP: DO NOT USE**

In this scenario, you will learn how to enforce custom egress policies on Kubernetes objects using OPA.

## OPA

OPA is a lightweight general-purpose policy engine that can be co-located with your service. You can integrate OPA as a sidecar, host-level daemon, or library.

Services offload policy decisions to OPA by executing queries. OPA evaluates policies and data to produce query results (which are sent back to the client). Policies are written in a high-level declarative language and can be loaded into OPA via the filesystem or well-defined APIs.

More details can be found at https://www.openpolicyagent.org/.