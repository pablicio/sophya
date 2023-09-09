# #!/bin/bash
# `git fetch 2>/dev/null`;

for i in `/home/ubuntu/docs/diff.json`; do
  # generated images from .puml file
  path_to_file=`cut -c 12- <<< $i`;
  `java -jar plantuml.jar /home/ubuntu/docs/$1/$path_to_file`;
done
  
## generate current folder structure and save in json
`rm /home/ubuntu/docs/map_folder.json 2>/dev/null`;
`python3 map_formatter.py 2>/dev/null >> /home/ubuntu/docs/map_folder.json`;