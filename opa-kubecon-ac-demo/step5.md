`kubectl delete -f demo_alice.yaml -n dev`{{execute}}

`kubectl apply -f demo_alice.yaml -n dev`{{execute}}

This time Alice should not be able to create an Ingress in another namespace with the same hostname as the one created earlier.

OPA will enforce the admission control policy and return an error like below:
```
"validating-webhook.openpolicyagent.org" denied the request: invalid ingress host (conflicts with prod/productpage-ingress)
```

Refresh the browser. You should now see Bob's picture and his details !

![Bob](/styra/scenarios/opa-kubecon-ac-demo/assets/bob.jpg)