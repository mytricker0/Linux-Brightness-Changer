#!/bin/bash


RED='\033[0;31m'
MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

INSTALL_DIR="/usr/bin"
SCRIPT_NAME="lum"

revert_brightness() {
    echo -e "${RED}Operation cancelled. Reverting to default settings.${NC}"
    for screen in $screens; do
        xrandr --output $screen --brightness 1
    done
    exit 1
}

trap revert_brightness SIGINT

# Check for the 'remove' argument to uninstall the script
if [ "$1" = "remove" ]; then
    # Check for root privileges
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${RED}Please run this script with sudo to remove it: ${NC}sudo $0 $*"
        exit 1
    fi

    # Remove the script from /usr/bin
    if [ -f "${INSTALL_DIR}/${SCRIPT_NAME}" ]; then
        rm -f "${INSTALL_DIR}/${SCRIPT_NAME}"
        echo -e "${MAGENTA}The script ${SCRIPT_NAME} has been successfully removed ${NC}"
    else
        echo -e "${YELLOW}The script ${SCRIPT_NAME} was not found in ${INSTALL_DIR}.${NC}"
    fi
    exit 0
fi

# Check if a brightness level is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Please provide a brightness level (between 0.1-1)${NC}"
    exit 1
fi

# Get the list of connected screens
screens=$(xrandr -q | grep " connected" | awk '{print $1}')

# Iterate over each screen and set the brightness
for screen in $screens; do
    xrandr --output $screen --brightness $1
done

if (( $(echo "$1 < 0.1 || $1 > 1" | bc -l) )); then
    echo -e "${YELLOW}Warning:${NC} The brightness level is set to a value outside the recommended range (0.1 to 1)."
    echo -e "If this is intended, ${YELLOW}type 'yes' within 5 seconds.${NC}"

    # Start a 5-second countdown
    read -t 5 confirmation

    # Convert the input to lowercase
    confirmation=$(echo "$confirmation" | awk '{print tolower($0)}')

    case "$confirmation" in
    y|yes)
        # Valid confirmation, do nothing
        ;;
    *)
        revert_brightness
        ;;
    esac
fi