# TRMNL System Monitor

A lightweight Linux system monitoring plugin built for TRMNL e-ink displays as part of the Hack Club TRMNT event.

## Features
- Tracks real-time CPU Load, RAM Usage, Disk Space, and System Temperature.
- Displays device Hostname, OS version, Local IP, and Uptime.
- Interactive terminal mode to either view stats locally or push JSON payloads directly to a TRMNL Webhook URL.
- Custom HTML/SVG e-ink display layout (template.html) with built-in icons.

## Files
- monitor.sh: Bash script that collects system metrics and sends JSON data.
- template.html: Liquid/HTML layout designed for the TRMNL screen.

## How to Run
1. Run the script in your terminal:
  

   bash monitor.sh
   

2. Choose 1 to view system stats in the terminal, or 2 to send the data to your TRMNL Webhook URL.
