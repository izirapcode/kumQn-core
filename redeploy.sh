#!/bin/bash

# Step 1: Clean and package the Maven project
mvn clean package

# Step 2: Secure copy the JAR file to the target machine
scp -i $HOME/.ssh/meczmaker-ssh.pem target/kumQn-core-1.0-SNAPSHOT.jar ec2-user@3.73.214.201:~

# Step 3: Connect to the target machine and execute the following commands
ssh -i $HOME/.ssh/meczmaker-ssh.pem ec2-user@3.73.214.201 << 'EOF'
# Find and kill the process running the JAR file
pid=$(pgrep -f '/usr/bin/java -jar /home/ec2-user/kumQn-core-1.0-SNAPSHOT.jar')
if [ -n "$pid" ]; then
  kill $pid
fi

# Start the Spring Boot application using systemd
sudo systemctl start springboot
EOF