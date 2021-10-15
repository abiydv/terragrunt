# Terragrunt, Terraform & Python

(Based off of the awesome work at https://github.com/alpine-docker/terragrunt)

## Included Tools
* Latest [Terraform](https://github.com/hashicorp/terraform/releases)
* Latest [Terragrunt](https://github.com/gruntwork-io/terragrunt)
* [Python 3.9](https://hub.docker.com/layers/python/library/python/3.9-alpine/images/sha256-b296be61d1f4f7ec889da18733c2ed17bcbc85386d5edce31626bbfd7fe95c56) (Alpine based)

## Tags
Image has 2 tags - version specific and latest. Terraform release tag is carried over as the image tag. 
Full list - https://hub.docker.com/r/abiydv/terragrunt/tags

## Updates
Version updates are automatic. GitHub actions workflow runs every Monday at 00:00 hrs. If there is a new Terragrunt version available, a new build is kicked off. This creates a new image with the latest terraform version as its tag. 

Past build logs are available under the Actions tab (upto the standard GitHub retention limit, of course).





