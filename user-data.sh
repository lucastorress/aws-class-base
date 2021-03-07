#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install ruby -y
apt-get install wget -y
cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
./install auto
service codedeploy-agent start

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

. /home/ubuntu/.nvm/nvm.sh \
. /home/ubuntu/.bashrc

nvm alias default v14.16.0
nvm install v14.16.0
nvm use v14.16.0
npm install pm2@latest -g

ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/bin/node" \
ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/local/bin/node" \
ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/bin/npm" \
ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/local/bin/npm" \
ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/pm2" "/usr/bin/pm2" \
ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/pm2" "/usr/local/bin/pm2"

env PATH=$PATH:/.nvm/versions/node/v14.16.0/bin /.nvm/versions/node/v14.16.0/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
env PATH=$PATH:/.nvm/versions/node/v14.16.0/bin pm2 startup systemd -u ubuntu --hp /home/ubuntu
pm2 save

npm install yarn -g