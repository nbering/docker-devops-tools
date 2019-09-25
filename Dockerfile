FROM debian:stretch

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        git \
        wget \
        curl \
        unzip \
        putty-tools \
        build-essential \
        python-minimal \
        python-setuptools \
        python-dev \
        ca-certificates \
        apt-transport-https && \
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ stretch main" | \
        tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install azure-cli && \
    easy_install pip && \
    pip install --upgrade pip && \
    pip install 'ansible>=2.7,<2.8' netaddr boto3 boto dnsimple pyOpenSSL awscli && \
    pip install git+https://github.com/ansible/molecule.git@2.19 && \
    cd $TMPDIR && \
    wget --quiet https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip && \
    unzip terraform_0.11.14_linux_amd64.zip && \
    mv ./terraform /usr/local/bin/ && \
    rm terraform_0.11.14_linux_amd64.zip && \
    wget --quiet https://releases.hashicorp.com/packer/1.3.2/packer_1.3.2_linux_amd64.zip && \
    unzip packer_1.3.2_linux_amd64.zip && \
    mv ./packer /usr/local/bin/ && \
    rm packer_1.3.2_linux_amd64.zip
