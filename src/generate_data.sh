#!/bin/sh

echo repo = $repo
echo REPO_DIR = $REPO_DIR
echo REPO_DATA_DIR = $REPO_DATA_DIR

mkdir -p $REPO_DATA_DIR
cd $REPO_DATA_DIR
echo -e "\e[92mDownloading ${repo} description\e[0m"
wget -q https://api.github.com/repos/$repo -O $REPO_DATA_DIR/description.json
echo -e "\e[92mGenerating ${repo} log\e[0m"
cd $REPO_DIR
git config diff.renameLimit 999999
git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat > $REPO_DATA_DIR/evo.log
cd -
