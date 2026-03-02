#!/usr/bin/env bash

# Print terminal's message
show_message() {
    local type="$1"
    local title="$2"
    local message="$3"
    local color_var="${ADVICE_COLORS[$type]}"
    local title_color="${!color_var}"
    local body_color="${!ADVICE_COLORS[body-message]}"
    
    echo -e "${title_color}${title}${reset}: ${body_color}${message}${reset}"
}

# Throw a notification pop-up using the libnotify-bin library
send_notification() {
    local icon="$1"
    local name="$2"
    local title="$3"
    local message="$4"

    if ! command -v notify-send &>/dev/null; then
        show_message "danger-message" "notify-send" "is not installed"
        show_message "warning-message" "$title" "$message"
        return 1
    fi

    if ! notify-send -i "$icon" -a "$name" "$title" "$message"; then
        show_message "warning-message" "$title" "$message"
        return 1
    fi
}
