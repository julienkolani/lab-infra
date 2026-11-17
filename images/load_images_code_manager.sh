#!/bin/bash

image_file_path="./images/forge.txt"

for img in $(grep -v '^#' "$image_file_path" | grep -v '^$'); do
    tar=${img//[\/:]/_}
    docker save "$img" -o /tmp/$tar && ls -lh /tmp/$tar
    docker cp /tmp/$tar code-manager-control-plane:/$tar
    docker exec code-manager-control-plane ctr -n k8s.io images import /$tar
    rm /tmp/$tar && docker exec code-manager-control-plane rm /$tar
    echo "Done"
done