#!/usr/bin/env bash

# Launch a system or custom service
run_service() {
    local service_name="$1"

    if systemctl is-active --quiet "$service_name"; then
        send_notification "info" "$service_name" "$service_name is already running" "$service_name is already running on your system"
        show_message "warning-message" "$service_name" "is already running"
        return
    fi

    sudo systemctl start "$service_name" &>/dev/null

    if systemctl is-active --quiet "$service_name"; then
        send_notification "info" "$service_name" "$service_name was launched" "$service_name was launched successfully"
        show_message "success-message" "$service_name" "was launched"
    else
        send_notification "info" "$service_name" "$service_name couldn't launch" "$service_name couldn't launch successfully"
        show_message "danger-message" "$service_name" "couldn't launch"
    fi
}

# Stop a system or custom service
stop_service() {
    local service_name="$1"

    if ! systemctl is-active --quiet "$service_name"; then
        send_notification "info" "$service_name" "$service_name is already stopped" "$service_name is already stopped on your system"
        show_message "warning-message" "$service_name" "is already stopped"
        return
    fi

    sudo systemctl stop "$service_name" &>/dev/null

    if ! systemctl is-active --quiet "$service_name"; then
        send_notification "info" "$service_name" "$service_name was stopped" "$service_name was stopped successfully"
        show_message "warning-message" "$service_name" "was stopped"
    else
        send_notification "info" "$service_name" "$service_name couldn't stop" "$service_name couldn't stop successfully"
        show_message "danger-message" "$service_name" "couldn't stop"
    fi
}
