# #!/bin/bash
# `git fetch 2>/dev/null`;

for i in `sudo /home/ubuntu/docs/diff.json`; do
  # generated images from .puml file
  `sudo java -jar plantuml.jar $i`;
done
  
## generate current folder structure and save in json
`sudo rm /home/ubuntu/docs/map_folder.json 2>/dev/null`;
`sudo python3 map_formatter.py 2>/dev/null >> /home/ubuntu/docs/map_folder.json`;