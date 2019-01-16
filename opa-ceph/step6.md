Create two object store users `Alice` and `Bob`.

Now create the users.

`kubectl create -f object-user-alice.yaml`{{execute}}

`kubectl create -f object-user-bob.yaml`{{execute}}

When the object store user is created, the Rook operator will create the RGW user on the object store `my-store`, and store the user's Access Key and Secret Key in a Kubernetes secret in the namespace `rook-ceph`.