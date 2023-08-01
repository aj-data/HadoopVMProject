#!/bin/bash

function createInitScrip {
    SOURCE_FILE="/vagrant/resources/misc/init-script.sh"
    DEST_FILE="/home/hadoop/init-script.sh"

    cp "$SOURCE_FILE" "$DEST_FILE"
    chmod +x "$DEST_FILE"

    echo "init-script.sh copiado y con permisos de ejecución"
}

# Call the functions 
createInitScrip
