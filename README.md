[![terragrunt-image](https://github.com/abiydv/terragrunt/actions/workflows/main.yaml/badge.svg?branch=master)](https://github.com/abiydv/terragrunt/actions/workflows/main.yaml)

# Terragrunt, Terraform & Python

(Based off of the awesome work at https://github.com/alpine-docker/terragrunt, Thank you guys!)

## Home
https://github.com/abiydv/terragrunt

## Included Tools
* Latest [Terraform](https://github.com/hashicorp/terraform/releases)
* Latest [Terragrunt](https://github.com/gruntwork-io/terragrunt)
* [Python 3.9](https://hub.docker.com/layers/python/library/python/3.9-alpine/images/sha256-b296be61d1f4f7ec889da18733c2ed17bcbc85386d5edce31626bbfd7fe95c56) (Alpine based)

## Motivation
The [Terraform AWS Lambda module](https://github.com/terraform-aws-modules/terraform-aws-lambda) needs `python` to be available to build the deployment packages. Most of the other lean terragrunt/terraform images don't provide python out of the box.

## Tags
`latest` tag will always have the latest Terraform and Terragrunt version. Terraform release tag is carried over as the image tag.

Full list - https://hub.docker.com/r/abiydv/terragrunt/tags

## Updates
Terraform and Terragrunt version updates are automatic. Python version, however, is pinned to `3.9-alpine` at the moment. `build.sh` needs an update to use a different `python` version.

GitHub actions workflow runs every Monday at 00:00 hrs. If there is a new Terragrunt version available, a new build is kicked off. This creates a new image with the latest Terraform version as its tag. 

Past build logs are available under the Actions tab (upto the standard GitHub retention limit, of course).

## Run
A simple example

```
docker --rm -v `pwd`:/apps abiydv/terragrunt:latest terragrunt run-all init
```

Notes - 
* You can also mount your `.ssh` directory to `/root/.ssh` in case you are using modules from any private repo.
* Not using the `-d` flag allows you to inspect the terragrunt output on the console. 
* `terragrunt run-all init` command above is just an example, it can be replaced by the usual terraform/terragrunt commands as required.
