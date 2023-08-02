#!/bin/bash

function createInitScrip {
    echo "Copiando init-script.sh y otorgando permisos de ejecución"
    
    SOURCE_FILE="/vagrant/resources/misc/init-script.sh"
    DEST_FILE="init-script.sh"

    cp "$SOURCE_FILE" "$DEST_FILE"
    chmod +x "$DEST_FILE"
}

# Call the functions 
createInitScrip
