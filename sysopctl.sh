#!/bin/bash

# Define version
VERSION="v0.1.0"

# Function to show help information
show_help() {
    cat <<EOF
Usage: sysopctl [command] [subcommand] [options]

Commands:
  service list                List running services
  service start <name>        Start a service
  service stop <name>         Stop a service
  system load                 View system load (CPU usage)
  disk usage                  Check disk usage
  process monitor             Monitor system processes
  logs analyze                Analyze system logs
  backup <path>               Backup files

Options:
  --version                   Show the version of sysopctl
  --help                      Show this help message

EOF
}

# Function to show version
show_version() {
    echo "sysopctl $VERSION"
}

# Function to list running services
list_services() {
    systemctl list-units --type=service --state=running
}

# Function to start a service
start_service() {
    if [ -z "$1" ]; then
        echo "Error: Service name is required."
        return 1
    fi
    sudo systemctl start "$1"
    echo "Service $1 started."
}

# Function to stop a service
stop_service() {
    if [ -z "$1" ]; then
        echo "Error: Service name is required."
        return 1
    fi
    sudo systemctl stop "$1"
    echo "Service $1 stopped."
}

# Function to view system load
view_system_load() {
    uptime
}

# Function to check disk usage
check_disk_usage() {
    df -h
}

# Function to monitor system processes
monitor_processes() {
    top -b -n 1
}

# Function to analyze logs
analyze_logs() {
    journalctl -p 3 -n 10 --no-pager
}

# Function to backup files
backup_files() {
    if [ -z "$1" ]; then
        echo "Error: Backup path is required."
        return 1
    fi
    rsync -av --progress "$1" /var/backup/
    echo "Backup of $1 completed."
}

# Main logic
case "$1" in
    --help)
        show_help
        ;;
    --version)
        show_version
        ;;
    service)
        case "$2" in
            list)
                list_services
                ;;
            start)
                start_service "$3"
                ;;
            stop)
                stop_service "$3"
                ;;
            *)
                echo "Error: Invalid service command."
                show_help
                ;;
        esac
        ;;
    system)
        case "$2" in
            load)
                view_system_load
                ;;
            *)
                echo "Error: Invalid system command."
                show_help
                ;;
        esac
        ;;
    disk)
        case "$2" in
            usage)
                check_disk_usage
                ;;
            *)
                echo "Error: Invalid disk command."
                show_help
                ;;
        esac
        ;;
    process)
        case "$2" in
            monitor)
                monitor_processes
                ;;
            *)
                echo "Error: Invalid process command."
                show_help
                ;;
        esac
        ;;
    logs)
        case "$2" in
            analyze)
                analyze_logs
                ;;
            *)
                echo "Error: Invalid logs command."
                show_help
                ;;
        esac
        ;;
    backup)
        backup_files "$2"
        ;;
    *)
        echo "Error: Invalid command."
        show_help
        ;;
esac
