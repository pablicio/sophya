# #!/bin/bash
# `git fetch 2>/dev/null`;

# for i in `git diff --name-only main origin/main 2>/dev/null | egrep '\.(puml)$'`; do
#   # generated images from .puml file
#   echo $i;
#   # `java -jar plantuml.jar $i`;
# done
  
## generate current folder structure and save in json
`rm ../docs/map_folder.json 2>/dev/null`;
`python3 map_formatter.py 2>/dev/null >> ../docs/map_folder.json`;