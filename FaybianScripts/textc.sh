#!/bin/bash
# File_Rel_Path: 'FaybianScripts/utils/textc.sh'
# File_Type: '.sh'

COLOR_ESCAPE_END="\e[0m"

# Default color if input color is unknown
DEFAULT_COLOR_ESCAPE="\e[0m"

# Usage information
show_usage() {
    echo "Usage: $0 --color <color> --text <text>"
    echo "Options:"
    echo "  --color    Specify the color for the text. Supported values: [black, red, green, yellow, blue, magenta, cyan, white]."
    echo "  --text     Specify the text to be formatted."
    echo "  --help     Show this help message."
    exit 0
}

# Initialize variables
COLOR=""
TEXT=""

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --color)
            COLOR="$2"
            shift 2
            ;;
        --text)
            TEXT="$2"
            shift 2
            ;;
        --help)
            show_usage
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            ;;
    esac
done

# Show usage information if --text is not provided
if [[ -z "$TEXT" ]]; then
    echo "Error: --text is required."
    show_usage
fi

# Determine color escape code
case "$COLOR" in
    black)
        COLOR_ESCAPE="\e[30m"
        ;;
    red)
        COLOR_ESCAPE="\e[31m"
        ;;
    darkred)
        COLOR_ESCAPE="\e[1m\e[31m"
        ;;
    green)
        COLOR_ESCAPE="\e[32m"
        ;;
    yellow)
        COLOR_ESCAPE="\e[33m"
        ;;
    blue)
        COLOR_ESCAPE="\e[34m"
        ;;
    magenta)
        COLOR_ESCAPE="\e[35m"
        ;;
    cyan)
        COLOR_ESCAPE="\e[36m"
        ;;
    white)
        COLOR_ESCAPE="\e[37m"
        ;;
    brightyellow)
        COLOR_ESCAPE="\033[1;33m"
        ;;  # or \033[0;93m or \033[38;5;226m
    *)
        # If color is unknown or not specified, use default
        COLOR_ESCAPE="$DEFAULT_COLOR_ESCAPE"
        ;;
esac

# Return the text with the escape characters
echo -e "${COLOR_ESCAPE}${TEXT}${COLOR_ESCAPE_END}"
