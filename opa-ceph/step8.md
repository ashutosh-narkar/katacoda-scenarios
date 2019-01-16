The below Python S3 access test script connects to the  `Ceph Object Store Gateway` to perform actions such as creating and deleting buckets. 

Install the `python-boto` package to run the test script.
`pip install boto`{{execute}}

<pre class="file" data-filename="s3test.py" data-target="replace">#!/usr/bin/env python

import sys
import boto.s3.connection
from boto.s3.key import Key
import os


def create_bucket(conn, bucket_name):
    try:
        bucket = conn.create_bucket(bucket_name)
    except Exception as e:
        print 'Unable to create bucket: Forbidden'


def delete_bucket(conn, bucket_name):
    try:
        bucket = conn.delete_bucket(bucket_name)
    except Exception as e:
        print 'Unable to delete bucket: Forbidden'


def list_bucket(conn):
    buckets = conn.get_all_buckets()
    if len(buckets) == 0:
        print 'No Buckets'
        return
    for bucket in buckets:
        print "{name} {created}".format(
            name=bucket.name,
            created=bucket.creation_date,
    )


def upload_data(conn, bucket_name, data):
    bucket = conn.get_bucket(bucket_name)
    k = Key(bucket)
    k.key = 'foobar'
    k.set_contents_from_string(data)


def download_data(conn, user, bucket_name):
    try:
        bucket = conn.get_bucket(bucket_name)
    except Exception as e:
        print 'Not allowed to access bucket "{}": User "{}" not in the same location as bucket "{}"'.format(bucket_name, user, bucket_name)
    else:
        k = Key(bucket)
        k.key = 'foobar'
        print k.get_contents_as_string()


if __name__ == '__main__':
    user = sys.argv[1]
    action = sys.argv[2]

    if len(sys.argv) == 4:
        bucket_name = sys.argv[3]

    if len(sys.argv) == 5:
        bucket_name = sys.argv[3]
        data = sys.argv[4]

    access_key_env_name = '{}_ACCESS_KEY'.format(user.upper())
    secret_key_env_name = '{}_SECRET_KEY'.format(user.upper())

    access_key = os.getenv(access_key_env_name)
    secret_key = os.getenv(secret_key_env_name)

    conn = boto.connect_s3(
            aws_access_key_id=access_key,
            aws_secret_access_key=secret_key,
            host=os.getenv("HOST"), port=int(os.getenv("PORT")),
            is_secure=False, calling_format=boto.s3.connection.OrdinaryCallingFormat(),
    )

    if action == 'create':
            create_bucket(conn, bucket_name)

    if action == 'list':
            list_bucket(conn)

    if action == 'delete':
            delete_bucket(conn, bucket_name)

    if action == 'upload_data':
        upload_data(conn, bucket_name, data)

    if action == 'download_data':
        download_data(conn, user, bucket_name)
</pre>

The script needs the following environment variables:

* `HOST` - Hostname of the machine running the RGW service in the cluster.
* `PORT` - External Port of the RGW service.
* `<USER>_ACCESS_KEY` - USER's `ACCESS_KEY`
* `<USER>_SECRET_KEY` - USER's `SECRET_KEY`

We previously created a service to provide external access to the RGW.

`kubectl -n rook-ceph describe service rook-ceph-rgw-my-store-external`{{execute}}

Internally the RGW service is running on a port indicated by the `Port` field. Externally it is running on a port indicated by the `NodePort` field.

Set the `HOST` and `PORT` environment variables:

`export HOST=$(minikube ip)`{{execute}}

`export PORT=$(kubectl -n rook-ceph get service rook-ceph-rgw-my-store-external -o jsonpath='{.spec.ports[?(@.name=="rgw")].nodePort}')`{{execute}}


Get Alice's and Bob's `ACCESS_KEY` and `SECRET_KEY` from the Kubernetes Secret and set the following environment variables:

`export ALICE_ACCESS_KEY=$(kubectl get secret rook-ceph-object-user-my-store-alice -n rook-ceph -o yaml | grep AccessKey | awk '{print $2}' | base64 --decode)`{{execute}}

`export ALICE_SECRET_KEY=$(kubectl get secret rook-ceph-object-user-my-store-alice -n rook-ceph -o yaml | grep SecretKey | awk '{print $2}' | base64 --decode)`{{execute}}

`export BOB_ACCESS_KEY=$(kubectl get secret rook-ceph-object-user-my-store-bob -n rook-ceph -o yaml | grep AccessKey | awk '{print $2}' | base64 --decode)`{{execute}}

`export BOB_SECRET_KEY=$(kubectl get secret rook-ceph-object-user-my-store-bob -n rook-ceph -o yaml | grep SecretKey | awk '{print $2}' | base64 --decode)`{{execute}}


Now let's create a bucket and add some data to it.

* First, `Bob` creates a bucket `supersecretbucket`

    `python s3test.py Bob create supersecretbucket`{{execute}}

* List the bucket just created

    `python s3test.py Bob list`{{execute}}

    The output will be something like:

    ```raw
    supersecretbucket 2019-01-14T21:18:03.872Z
    ```

* Add some data to the bucket `supersecretbucket`
  
    `python s3test.py Bob upload_data supersecretbucket "This is some secret data"`{{execute}}
