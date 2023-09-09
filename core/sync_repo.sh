#!/bin/bash
# $1 = my-repo-name
# $2  = user-git
# $3  = token-git
# $4  = file-check
# example sh sync_repo.sh my-repo-name user-git token-git README.md

if [[ -f /home/ubuntu/repos/$1/$4 2>/dev/null ]]; then
  cd /home/ubuntu/repos/$1
  git fetch
  rm /home/ubuntu/docs/diff.json
  git diff --name-only main origin/main | egrep '\.(puml)$' >> /home/ubuntu/docs/diff.json
  chmod 744 /home/ubuntu/docs/diff.json
else
  git config user.name $2 2>/dev/null
  git config github.token $3 2>/dev/null
  git clone https://github.com/$2/$1.git /home/ubuntu/repos/$1 2>/dev/null
  rm /home/ubuntu/docs/diff.json 2>/dev/null
  find /home/ubuntu/repos/$1/sophya-docs -type f  -name "*.puml" -mmin -60 >> /home/ubuntu/docs/diff.json
  chmod 744 -R /home/ubuntu/repos/$1/
  chmod 744 /home/ubuntu/docs/diff.json
fi

