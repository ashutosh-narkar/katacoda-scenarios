To recap, the policy we are going to test will **restrict a user from accessing a bucket whose location does not match the user's location.**.

Check that `Alice` cannot access the contents of the bucket `supersecretbucket`.

`python s3test.py Alice download_data supersecretbucket`{{execute}}

Since `Alice` is located in `UK` and and the bucket `supersecretbucket` in the `USA`, she would be denied access.

Check that `Bob` can access the contents of the bucket `supersecretbucket`.

`python s3test.py Bob download_data supersecretbucket`{{execute}}

Since `Bob` and the bucket `supersecretbucket` are both located in the `USA`, `Bob` is granted access to the contents in the bucket.