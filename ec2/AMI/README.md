



## Caveat
1. When you launch an EC2 instance from an AMI image, the new instance's volume size should **NOT** be inferior to that of the original AMI's volume size.
    - For example, if your AMI snapshot was taken with an original EC2 instance of size 50GB, then you could not launch an instance of 8GB based on that AMI snapshot.






