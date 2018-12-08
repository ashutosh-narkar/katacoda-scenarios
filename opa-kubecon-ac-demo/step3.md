The Demo app created an ingress rule for host `*` and path `/` in the `prod` namespace.

Alice's version of the demo app created an ingress rule for the same host host `*` and path `/bob` in the `dev` namespace.

The app logic redirects `/` to `/bob` and now it matches the ingress rule created in the `dev` namespace and hence the request is handled by Alice's version of the demo app.

This is pretty dangerous as Alice has effectively stolen an api endpoint from the Demo App running in `prod` and is now handling potentially sensitive production traffic.

You can imagine Alice creating an ingress rule for host `*` and path `/` in her namespace and thereby redirecting all the production traffic to her app.

![Joker](/styra/scenarios/opa-kubecon-ac-demo/assets/joker.jpg)
