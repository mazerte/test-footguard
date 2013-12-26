#!/bin/bash

if [ -z "$REPO" ]
then
	REPO=$(git config --get remote.origin.url)
else
	git config --global user.email "mathieu.desve@me.com"
	git config --global user.name "Mathieu Desvé"
fi
message=$(git log -1 --pretty=%B)

cd dist
rm -rf .git
git init
git remote add origin $REPO > /dev/null 2>&1
git push origin --delete gh-pages > /dev/null 2>&1
git checkout -b gh-pages
git add --all
git commit -m "$message"
git push origin gh-pages > /dev/null 2>&1