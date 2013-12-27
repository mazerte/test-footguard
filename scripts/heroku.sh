#!/bin/bash

# if [ -z "$TRAVIS" ]
# then
echo "Prepare heroku"
echo "Host heroku.com" >> ~/.ssh/config
echo "   StrictHostKeyChecking no" >> ~/.ssh/config
echo "   CheckHostIP no" >> ~/.ssh/config
echo "   UserKnownHostsFile=/dev/null" >> ~/.ssh/config
# fi

message=$(git log -1 --pretty=%B)

cd dist
rm -rf .git
git init
yes | git remote add heroku "git@heroku.com:$APP.git"
git checkout -b heroku
git add --all
git commit -m "$message"
yes | git push heroku heroku:master
cd ..