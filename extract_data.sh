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

echo -e "\e[92mCloning ${repo}\e[0m"
mkdir -p /tmp/repos/$repo
mkdir -p $DATA_DIR
cd /tmp/repos/$repo/..
git clone https://github.com/$repo
cd ../$repo
echo -e "\e[92mGenerating ${repo} log\e[0m"
git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat > $DATA_DIR/evo.log && cd $DIR

types=( \
  "abs-churn" \
  "age" \
  "author-churn" \
  "authors" \
  "communication" \
  "coupling" \
  "entity-churn" \
  "entity-effort" \
  "entity-ownership" \
  "fragmentation" \
  "identity" \
  "main-dev" \
  "main-dev-by-revs" \
  "messages" \
  "refactoring-main-dev" \
  "revisions" \
  "soc" \
  "summary" \
)

for type in "${types[@]}"; do
  echo -e "\e[92mCalculating ${type} metric\e[0m"
  $DIR/bin/code-maat -l $DATA_DIR/evo.log -c git -a $type > $DATA_DIR/$type.csv
done;
