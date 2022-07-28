stopme() {
    if [ "$#" -eq 0 ]; then
        echo "stopme() requires one (sleep-like) arg, e.g."
        echo "  stopme 5h 30m"
        echo "Exit. Try again."
    else
        sleep $@ && aws ec2 stop-instances --instance-ids $(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)
    fi
}
