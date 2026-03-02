#!/usr/bin/env bash

# Launch a application from his path
run_app() {
    local app_path="$1"
    local app_name="$2"
    shift 2

    if pgrep -f "$app_path" &>/dev/null; then
        send_notification "info" "$app_name" "$app_name is already running" "$app_name is already running on your system"
        show_message "warning-message" "$app_name" "is already running"
        return
    fi

    setsid "$app_path" "$@" &>/dev/null

    if [ $? -eq 0 ]; then
        send_notification "info" "$app_name" "$app_name was launched" "$app_name was launched successfully"
        show_message "success-message" "$app_name" "was launched"
    else
        send_notification "info" "$app_name" "$app_name couldn't launch" "$app_name couldn't launch successfully"
        show_message "danger-message" "$app_name" "couldn't launch"
    fi
}
