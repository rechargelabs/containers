# Containers

Dockerfiles for reproducing CircleCI and local dev container.

To cut a new build, update the Dockerfile to reflect bazel/Gcloud versions, and run

`docker build .`

Once you have the image built, tag it using

`docker tag <image_hash> rechargelabs/sandbox:<gcloud_version>-<bazel_version>`

Make sure you test the container by running `bazel build|test`.

Once container is validated, run

`docker push rechargelabs/sandbox:<gcloud_version>-<bazel_version>`

to publish the image to our *PUBLIC* repo in Dockerhub.

!!NO CREDENTIALS!!
==================

Note that there is no credentials inside the container. It is by design.

If you are using the container for local dev and you need to invoke GCloud inside the container, you are probably doing something wrong, because `gcloud` tool can run on Mac host anyway, and CI testing does not require real GCloud credentials.

CircleCI manages all other credentials (such as S3) outside the container.