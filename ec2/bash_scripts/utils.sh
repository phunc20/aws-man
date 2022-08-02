t2s() {
    sed 's/d/*24*3600 +/g; s/h/*3600 +/g; s/m/*60 +/g; s/s/\+/g; s/+[ ]*$//g' <<< "$@" | bc
}


stopme() {
    if [ "$#" -eq 0 ]; then
        echo "stopme() requires one (sleep-like) arg, e.g."
        echo "  stopme 5h 30m"
        echo "Exit. Try again."
    else
        instance_id=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)

        ## 1. naively sleep
        #sleep $@ && aws ec2 stop-instances --instance-ids $instance_id

        # 2. use `pv` to display ETA
        if  ! command -v pv > /dev/null; then
            echo "Command 'pv' not found"
            echo "sudo apt-get install -y pv"
            sudo apt-get install -y pv > /dev/null
        fi
        n_seconds=$(t2s $@)
        yes | pv -SL1 -F "Stop instance $instance_id in %e" -s $n_seconds > /dev/null && aws ec2 stop-instances --instance-ids $instance_id
    fi
}
