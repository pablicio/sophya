# #!/bin/bash

for i in `cat /home/ubuntu/docs/diff.json`; do
  # generated images from .puml file
  path_to_file=`echo $i | cut -c 12-`
  `java -jar plantuml.jar /home/ubuntu/docs/$1/$path_to_file 2>/dev/null`;
done
  
## generate current folder structure and save in json
`rm /home/ubuntu/docs/map_folder.json 2>/dev/null`;
`python3 map_formatter.py 2>/dev/null >> /home/ubuntu/docs/map_folder.json`;