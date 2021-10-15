#!/usr/bin/env bash

# Make sure you set secrets in Github repo
# DOCKER_USERNAME
# DOCKER_TOKEN

set -ex

# Define the base python image tag to use
py_image_tag="3.9-alpine"

image="abiydv/terragrunt"


if [[ ${CI} == 'true' ]]; then
  CURL="curl -sL -H \"Authorization: token ${API_TOKEN}\""
else
  CURL="curl -sL"
fi

terraform=$(${CURL} https://api.github.com/repos/hashicorp/terraform/releases/latest |jq -r .tag_name|sed 's/v//')

terragrunt=$(${CURL} https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest |jq -r .tag_name)

latest=${terraform}

sum=0
echo "Lastest release is: ${latest}"

tags=`curl -s https://hub.docker.com/v2/repositories/${image}/tags/ |jq -r .results[].name`

for tag in ${tags}
do
  if [ ${tag} == ${latest} ];then
    sum=$((sum+1))
  fi
done

# Example value: 2020-11-06T18:05:06Z
terragrunt_published_date=$(${CURL} https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | jq -r '.published_at')

# Example value: 2020-10-22T16:01:28.23617Z
image_published_date=$(${CURL} https://hub.docker.com/v2/repositories/${image}/tags/ | jq -r '.results[] | select(.name=="latest") | .tag_last_pushed')

# If Terragrunt has a newer published date, then we have to force a build
if [ $(date -d ${terragrunt_published_date} +%s) -gt $(date -d ${image_published_date} +%s) ]; then
  REBUILD="true"
fi

if [[ ( $sum -ne 1 ) || ( ${REBUILD} == "true" ) ]];then
  sed "s/PY_IMAGE_TAG/${py_image_tag}/" Dockerfile.template > Dockerfile
  docker build --build-arg TERRAGRUNT=${terragrunt} --build-arg TERRAFORM=${terraform} --no-cache -t ${image}:${latest} .
  docker tag ${image}:${latest} ${image}:latest
  docker login -u $DOCKER_USERNAME -p $DOCKER_TOKEN
  docker push ${image}:${latest}
  docker push ${image}:latest

fi
