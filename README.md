# sandbox

Dockerfile for both local dev/test and CircleCI.

Workflow
========

The Docker image lives in a private repository called `rechargelabs/sandbox` on dockerhub. To get read/write permission, you will need an invite from someone in the team to access `rechargelabs`.

After that, run 
`export DOCKER_ID_USER="YOUR_DOCKER_ID"`
`docker login`
to grant docker client permission to push/pull images.


To push/pull docker images from private recharge repo.
In this folder, run

`docker build .`

You should get an image hash at the end of build, such as `5fd8dcb86dc4`. Then you can tag the image with 

`docker tag <IMAGE_HASH> rechargelabs/sandbox:v<GCLOUD_SEMVAR>-<BAZEL-SEMVAR>`

Here `<GCLOUD_SEMVAR>` and `<BAZEL-SEMVAR>` refer to the semantic versions of GCloud SDK (`GCLOUD_VERSION`) and Bazel (`BAZEL_VERSION`) used in the Dockerfile. 

After tagging, you can now push to docker via 
`docker push rechargelabs/sandbox:v<GCLOUD_SEMVAR>-<BAZEL-SEMVAR>`

Note that a base GCloud SDK image is not sufficient 
because it does not include other libraries. 
