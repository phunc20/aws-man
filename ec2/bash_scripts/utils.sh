stopme() {
    if [ "$#" -ne 1 ]; then
        echo "stopme() requires one (sleep-like) arg, e.g."
        echo "  stopme 5h 30m"
        echo "Exit. Try again."
    else
        sleep $1 && aws ec2 stop-instances --instance-ids "i-00123456789abcdef"
    fi
}
