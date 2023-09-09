#!/bin/bash
# $1 = my-repo-name
# $2  = user-git
# $3  = token-git
# $4  = file-check
# example sh sync_docs.sh my-repo-name

cd /home/ubuntu/repos/$1
git pull
rsync -rltgoDzvO /home/ubuntu/repos/$1/sophya-docs/ /home/ubuntu/docs/$1/
