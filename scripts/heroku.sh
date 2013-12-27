#!/bin/bash

# if [ -z "$TRAVIS" ]
# then
echo "Prepare heroku"
echo "Host heroku.com" >> ~/.ssh/config
echo "   StrictHostKeyChecking no" >> ~/.ssh/config
echo "   CheckHostIP no" >> ~/.ssh/config
echo "   IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config
echo -n $id_rsa_{0..23} >> ~/.ssh/id_rsa_base64
base64 --decode --ignore-garbage ~/.ssh/id_rsa_base64 > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
eval `ssh-agent -s`
sudo apt-get expect
/usr/bin/expect <<EOD
spawn ssh-add ~/.ssh/id_rsa
expect "nter passphrase"
send $SSH_PASS"/r"
interact
EOD
# fi

message=$(git log -1 --pretty=%B)

cd dist
rm -rf .git
git init
yes | git remote add heroku "git@heroku.com:$APP.git"
git checkout -b heroku
git add --all
git commit -m "$message"
git push heroku heroku:master

cd ..