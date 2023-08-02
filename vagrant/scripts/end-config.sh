#!/bin/bash

function createInitScrip {
    SOURC"
    DEST_FILE="init-script.sh"

    cp "$SOURCE_FILE" "$DEST_FILE"
    chmod +x "$DEST_FILE"

    echo "init-script.sh copiado y con permisos de ejecución"
}

# Call the functions 
createInitScrip
