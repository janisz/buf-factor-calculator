#!/bin/sh
display_usage() {
	echo "Ensure that git and code-maat are in PATH"
	echo -e "\nUsage:\n$0 [github repo handle <user/repo>] \n"
	}

# if less than two arguments supplied, display usage
if [  $# -le 0 ]
then
	display_usage
	exit 1
fi

# check whether user had supplied -h or --help . If yes display usage
if [[ ( $# == "--help") ||  $# == "-h" ]]
then
	display_usage
	exit 0
fi

repo=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATA_DIR=$DIR/data
REPO_DIR=/run/media/janisz/A276F14776F11CAB/mgr/repos/$repo

# echo -e "\e[92mCloning ${repo} to ${REPO_DIR}\e[0m"
# mkdir -p $REPO_DIR
# mkdir -p $DATA_DIR
cd $REPO_DIR/..
#git clone https://github.com/$repo
cd ../$repo

#echo -e "\e[92mDownloading ${repo} description\e[0m"
#wget https://api.github.com/repos/$repo -o description.json

echo -e "\e[92mGenerating ${repo} log\e[0m"
REPO_DATA_DIR=$DATA_DIR/repos/$repo
# mkdir -p $REPO_DATA_DIR
# mv $REPO_DIR/evo.log $REPO_DATA_DIR
# mv $REPO_DIR/description.json $REPO_DATA_DIR
# git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat > $REPO_DIR/evo.log && cd $DIR
#
types=(abs-churn  age  author-churn  authors  communication  coupling  entity-churn  entity-effort  entity-ownership  fragmentation  identity  main-dev  main-dev-by-revs  messages  refactoring-main-dev  revisions  soc  summary)

echo $repo > $REPO_DATA_DIR/repo.csv
#
for type in "${types[@]}"; do
  echo -e "\e[92m  Calculating ${type} metric\e[0m"
  $DIR/bin/code-maat -l $REPO_DATA_DIR/evo.log -c git -a $type -o $REPO_DATA_DIR/$type.csv
done;
