FROM amazonlinux:2 as installer

ARG EXE_FILENAME

ADD https://awscli.amazonaws.com/${EXE_FILENAME} ${EXE_FILENAME}

RUN yum update -y \
    && yum install -y unzip \
    && unzip ${EXE_FILENAME} \
    && ./aws/install --bin-dir /aws-cli-bin/

FROM amazonlinux:2

RUN yum update -y \
    && yum install -y less groff wget unzip \
    && yum clean all

ARG TERRAGRUNT

ARG TERRAFORM

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM}/terraform_${TERRAFORM}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM}_linux_amd64.zip -d /usr/local/bin/ \
    && rm terraform_${TERRAFORM}_linux_amd64.zip

RUN chmod +x /usr/local/bin/terraform

ADD https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT}/terragrunt_linux_amd64 /usr/local/bin/terragrunt

RUN chmod +x /usr/local/bin/terragrunt

COPY --from=installer /usr/local/aws-cli/ /usr/local/aws-cli/

COPY --from=installer /aws-cli-bin/ /usr/local/bin/

WORKDIR /apps

ENTRYPOINT []
