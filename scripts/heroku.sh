#!/bin/bash

message=$(git log -1 --pretty=%B)

cd dist
rm -rf .git
git init
yes | git remote add heroku "git@heroku.com:$APP.git" > /dev/null 2>&1
git push origin --delete heroku > /dev/null 2>&1
git checkout -b heroku
git add --all
git commit -m "$message"
yes | git push heroku heroku:master > /dev/null 2>&1
cd ..