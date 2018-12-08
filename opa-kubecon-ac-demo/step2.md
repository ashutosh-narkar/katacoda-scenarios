Create a `dev` namespace and deploy Alice's version of the Demo App in it.

`kubectl create ns dev`{{execute}}

`kubectl apply -f demo_alice.yaml -n dev`{{execute}}

Wait for all the pods to transition to the `Running` state. Monitor the pod status using the below command:

`kubectl get pods -n dev -w`{{execute}}

After all the pods are running, refresh the browser. This time you should **NOT** see Bob !

Before continuing, stop the running command with <kbd>Ctrl</kbd>+<kbd>C</kbd>
