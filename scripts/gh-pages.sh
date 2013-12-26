#!/bin/bash

if $REPO
then
	REPO=$(git config --get remote.origin.url)
fi
message=$(git log -1 --pretty=%B)

cd dist
rm -rf .git
git init
git remote add origin $REPO
git push origin --delete gh-pages
git checkout -b gh-pages
git add --all
git commit -m "$message"
git push origin gh-pages