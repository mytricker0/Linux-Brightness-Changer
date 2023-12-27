#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


INSTALL_DIR="/usr/bin"
SCRIPT_NAME="lum.sh"
SCRIPT_URL="https://raw.githubusercontent.com/mytricker0/Linux-Brightness-Changer/main/luminosity.sh" 

echo "Downloading $SCRIPT_NAME from $SCRIPT_URL..."
curl -s -o "$SCRIPT_NAME" "$SCRIPT_URL"

if [ -f "$SCRIPT_NAME" ]; then
    chmod +x "$SCRIPT_NAME"
    mv "$SCRIPT_NAME" "$INSTALL_DIR"

    if [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
        echo "${GREEN}Installation completed. You can run the script using 'lum.sh' command.${NC}}"
    else
        echo "${RED}Installation failed: Unable to move the script to $INSTALL_DIR.${NC}"
    fi
else
    echo "${RED}Download failed: The script could not be downloaded from $SCRIPT_URL.${NC}"
fi
