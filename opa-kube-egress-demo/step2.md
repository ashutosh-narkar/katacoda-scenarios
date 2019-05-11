Create a `policy-demo` namespace and deploy the Demo App in it.

`kubectl create ns policy-demo`{{execute}}

`kubectl apply -f demo.yaml -n policy-demo`{{execute}}

Wait for all the pods to transition to the `Running` state. Monitor the pod status using the below command:

`watch kubectl -n policy-demo get pod`{{execute}}

After all the pods are running, open the browser by pressing the `Demo` tab.

Before continuing, hit ```clear```{{execute interrupt}} to ctrl-c and clear the screen.