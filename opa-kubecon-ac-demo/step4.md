With OPA you can implement admission control rules that validate Kubernetes resources during create, update, and delete operations and enforce policies on-the-fly without recompiling any of the services that offload policy decisions to it.

Deploy OPA as an Admission Controller:

`opa-ac.sh`{{execute}}

The policy defined below will reject Ingress objects in different namespaces from sharing the same hostname:

<pre class="file" data-filename="ingress-conflicts.rego" data-target="replace">package kubernetes.admission

import data.kubernetes.ingresses

# Policy 1: Ingress hostnames must be unique across Namespaces.
deny[msg] {
    input.request.kind.kind = "Ingress"                # Resource kind
    input.request.operation = "CREATE"                 # Resource Operation
    host = input.request.object.spec.rules[_].host     # Host making the request
    ingress = ingresses[other_ns][other_ingress]       # Iterate over ingresses
    other_ns != input.request.namespace
    ingress.spec.rules[_].host == host                 # Check if same host in the ingress rule
    msg := sprintf("invalid ingress host %q (conflicts with %v/%v)", [host, other_ns, other_ingress])
}

# Policy 2: "host" field not present in the Ingress rule.This means the Ingress rule applies for all inbound traffic.
# So the existence of an Ingress rule in any other namspace would result in a conflict.
deny[msg] {
    input.request.kind.kind = "Ingress"
    input.request.operation = "CREATE"
    x := input.request.object.spec.rules[_]
    not x.host
    ingress = ingresses[other_ns][other_ingress]
    other_ns != input.request.namespace
    count(ingress.spec.rules) > 0
    msg := sprintf("invalid ingress host (conflicts with %v/%v)", [other_ns, other_ingress])
}
</pre>

Load the policy into OPA:

`kubectl create configmap -n opa ingress-conflicts --from-file=ingress-conflicts.rego`{{execute}}

The OPA sidecar annotates ConfigMaps containing policies to indicate if they were installed successfully. Verify the ConfigMap was installed successfully.

`kubectl get configmap -n opa ingress-conflicts -o yaml`{{execute}}