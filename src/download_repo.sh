#!/bin/sh

echo repo = $repo
echo REPO_DIR = $REPO_DIR

echo -e "\e[92mCloning ${repo} to ${REPO_DIR}\e[0m"
mkdir -p $REPO_DIR
cd $REPO_DIR/..
git clone https://github.com/$repo
