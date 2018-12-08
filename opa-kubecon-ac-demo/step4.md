With OPA you can implement admission control rules that validate Kubernetes resources during create, update, and delete operations and enforce policies on-the-fly without recompiling any of the services that offload policy decisions to it.

Deploy OPA as an Admission Controller:

`opa-ac.sh`{{execute}}

Define a policy that will reject Ingress objects in different namespaces from sharing the same hostname and load the policy into OPA:

`kubectl create configmap -n opa ingress-conflicts --from-file=ingress-conflicts.rego`{{execute}}

The OPA sidecar annotates ConfigMaps containing policies to indicate if they were installed successfully. Verify the ConfigMap was installed successfully.

`kubectl get configmap -n opa ingress-conflicts -o yaml`{{execute}}