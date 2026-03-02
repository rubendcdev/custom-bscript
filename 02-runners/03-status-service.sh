#!/usr/bin/env bash

# Validate if a service is running
is_running() {
    local service_name="$1"
	systemctl is-active --quiet "$service_name" &>/dev/null
}

# Check a status service
status_service() {
	local service_name="$1"

	if is_running "$service_name"; then
		send_notification "info" "$service_name" "$service_name is running" "$service_name is running on your system"
		show_message "success-message" "$service_name" "is running on"
	else
		send_notification "info" "$service_name" "$service_name isn't running" "$service_name isn't running on your system"
		show_message "danger-message" "$service_name" "isn't running"
	fi
}
