- stop instances: say, your instance's id is `i-1234567890abcdef0`, then send the following signal to AWS
  ```bash
  aws ec2 stop-instances --instance-ids i-1234567890abcdef0
  ```
  In case, you met an error saying
  ```
  An error occurred (InvalidInstanceID.NotFound) when calling the StopInstances operation: The instance ID 'i-0591ad597e7519f27' does not exist
  ```
  Then verify your `~/.aws/config` file to see if the region of your instance and the region saved in this file
  are consistent; in case not, just modify `~/.aws/config` to make them consistent.
  To name a few region ids:
  ```
  ap-northeast-1
  us-east-1
  eu-central-1
  ```
- create an image from an EC2 instance. For example,
  ```bash
  aws ec2 create-image \
      --instance-id i-1234567890abcdef0 \
      --name "My server" \
      --description "An AMI for my server"
  ```
