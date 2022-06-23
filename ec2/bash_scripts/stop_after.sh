#!/bin/bash

exam_period="1m"
echo "Check every $exam_period"
program="python"
while true; do
    still_running=$(pgrep $program)
    if [ -z "$still_running" ]; then
        echo "$program TERMINATED. We will send signal to stop instance"
        aws ec2 stop-instances --instance-ids "i-00123456789abcdef"
        break
    else
        echo "$program STILL RUNNING. (pid = $still_running)"
    fi 
    sleep "$exam_period"
done
