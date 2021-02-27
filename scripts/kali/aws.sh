#!/bin/sh -eux

# Add depends
sudo apt-get install nodejs npm -y
sudo apt-get install python3 python3-dev python3-pip -y
sudo apt-get install curl vim git -y

# Add terraform
cd /tmp
TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
unzip terraform_${TER_VER}_linux_amd64.zip
mv terraform /usr/local/bin
chmod +x /usr/local/bin/terraform

# Add AWS Cliv2
pip3 install awscli 
pip3 install awscliv2

# Add SAM
wget https://github.com/aws/aws-sam-cli/releases/download/v1.19.1/aws-sam-cli-linux-x86_64.zip
unzip aws-sam-cli-linux-x86_64.zip
sudo ./install

# Add aws-vault
wget https://github.com/99designs/aws-vault/releases/download/v6.2.0/aws-vault-linux-amd64
mv aws-vault-linux-amd64 /usr/local/bin/aws-vault
chmod +x /usr/local/bin/aws-vault

# Add VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update 
sudo apt install code -y

# Setup homedir
mkdir -p /home/vagrant/workspace 
cd !$
git clone https://github.com/andrewkrug/securing-the-cloud-supplemental.git

