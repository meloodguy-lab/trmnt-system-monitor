#!/bin/bash
HOSTNAME=$(hostname)
UPTIME=$(uptime -p)
OS_NAME=$(grep -oP '(?<=^PRETTY_NAME=).+' /etc/os-release |tr -d '"')
CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1 | xargs)
LOCAL_IP=$(hostname -I |awk '{print $1}')
TEMP=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null | awk '{printf "%.1f°C", $1/1000}')
[ -z "$TEMP" ] && TEMP="N/A"
RAM=$(free -m | awk 'NR==2{printf "%s/%sMB", $3,$2 }')
DISK=$(df -h / | awk 'NR==2 {print $5}')

echo "=== System Monitor: $HOSTNAME ==="
echo "OS: $OS_NAME"
echo "Status: Online"
echo "Uptime: $UPTIME"
echo "CPU Load: $CPU_LOAD"
echo "Local Ip: $LOCAL_IP"
echo "Temperature: $TEMP"
echo "RAM Usage: $RAM"
echo "Disk Usage: $DISK"

JSON_PLAYLOAD=$(cat <<EOF
{
"merge_variables": {
"hostname": "$HOSTNAME",
"OS": "$OS_NAME",
"Uptime": "$UPTIME",
"CPU Load": "$CPU_LOAD",
"Loacal Ip": "$LOCAL_IP",
"Temperature": "$TEMP",
"RAM Usage": "$RAM",
"Disk Usage": "$DISK"
 }
}
EOF
)

echo ""
echo "Select operation mode:"
echo "1) Display data in terminal only"
echo "2) Send data to TRMNL screen"
read -p "Enter your choice (1 or 2): " CHOICE

if [ "$CHOICE" == "2" ]; then
    read -p "Enter your TRMNL Webhook URL: " WEBHOOK_URL
    curl -s -X POST "$WEBHOOK_URL" -H "Content-Type: application/json" -d "$JSON_PAYLOAD"
    echo ""
    echo "Data sent successfully"
fi