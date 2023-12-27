#!/bin/bash

RED='\033[0;31m'
MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

INSTALL_DIR="/usr/bin"
SCRIPT_NAME="lum"
SCRIPT_URL="https://raw.githubusercontent.com/mytricker0/Linux-Brightness-Changer/main/luminosity.sh"

# Check for root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}Please run this script with sudo:${NC}"
    exit 1
fi

curl -s -o "$SCRIPT_NAME" "$SCRIPT_URL"

if [ -f "$SCRIPT_NAME" ]; then
    chmod +x "$SCRIPT_NAME"
    mv "$SCRIPT_NAME" "$INSTALL_DIR"

    if [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
        echo -e "${MAGENTA}Installation completed. You can run the script using 'lum' command.${NC}"
    else
        echo -e "${RED}Installation failed: Unable to move the script to $INSTALL_DIR.${NC}"
        rm -f "$SCRIPT_NAME"
    fi
else
    echo -e "${RED}Download failed: The script could not be downloaded from $SCRIPT_URL.${NC}"
fi
