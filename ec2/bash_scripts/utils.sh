t2s() {
    #sed 's/d/*24*3600 +/g; s/h/*3600 +/g; s/m/*60 +/g; s/s/\+/g; s/+[ ]*$//g' <<< "$@" | bc
}


stopme() {
    if [ "$#" -eq 0 ]; then
        echo "stopme() requires one (sleep-like) arg, e.g."
        echo "  stopme 5h 30m"
        echo "Exit. Try again."
    else
        ip="169.254.169.254"
        instance_id=$(wget -q -O - http://${ip}/latest/meta-data/instance-id)
        my_region=$(curl -s http://${ip}/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//')
        #my_region=$(curl http://${ip}/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')

        ## 1. naively sleep
        #sleep $@ && aws ec2 stop-instances --instance-ids $instance_id

        # 2. use `pv` to display ETA
        if  ! command -v pv > /dev/null; then
            echo "Command 'pv' not found"
            echo "sudo apt-get install -y pv"
            sudo apt-get install -y pv > /dev/null
        fi
        n_seconds=$(t2s $@)
        yes | pv -SL1 -F "Stop instance $instance_id in %e" -s $n_seconds > /dev/null && aws ec2 stop-instances --instance-ids $instance_id  --region $my_region
    fi
}


ec2getip() {
    aws ec2 describe-instances \
        --query "Reservations[*].Instances[*].PublicIpAddress" \
        --output=text \
        --instance-ids $@
}


ec2start() {
    aws ec2 start-instances --instance-ids $@
}


ec2stop() {
    aws ec2 stop-instances --instance-ids $@
}


ec2login() {
    if [ "$#" -ne 1 ]; then
        echo "Exactly one input (i.e. instance-id) is required."
        echo "Your input arg is wrong. Please try again"
        exit 1
    fi
    ec2start $1
    sleep 5s
    ip=$(ec2getip $1)
    ssh -i $HOME/.ssh/top_secret.cer "ubuntu@$ip"
}
