# Use lastest Ubuntu LTS
FROM ubuntu:16.04

# Install base packages
# Inspired by https://github.com/GoogleCloudPlatform/cloud-sdk-docker/blob/master/debian/Dockerfile
RUN apt-get update --quiet \
    && apt-get install --quiet --yes \
    apt-transport-https \
    curl \
    gcc \
    git \
    lsb-release \
    python-dev \
    python-setuptools

# Configure GCloud
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && echo "deb https://packages.cloud.google.com/apt ${CLOUD_SDK_REPO} main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update

# Install GCloud 160.0.0-0
RUN apt-get install --quiet --yes google-cloud-sdk=160.0.0-0 \
    && gcloud config set core/disable_usage_reporting true \
    && gcloud config set component_manager/disable_update_check true \
    && gcloud config set metrics/environment github_docker_image

# Install GClound Components 160.0.0-0
RUN apt-get install --quiet --yes \
    google-cloud-sdk-app-engine-go=160.0.0-0 \
    google-cloud-sdk-app-engine-python=160.0.0-0 \
    google-cloud-sdk-datastore-emulator=160.0.0-0

# Configure Bazel
RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" \
    | tee /etc/apt/sources.list.d/bazel.list \
    && curl https://bazel.build/bazel-release.pub.gpg | apt-key add - \
    && apt-get update --quiet

# Install Bazel
RUN apt-get install --quiet --yes bazel
