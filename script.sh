#!/usr/bin/env bash
while true
do
        echo "@#@#@#@#@#"
        echo "Main Menu"
        echo "@#@#@#@#@#"
        choices=( 'Install required software and libraries' 'exit' )
        select choice in "${choices[@]}"; do
                [[ -n $choice ]] || { echo "Invalid choice." >&2; continue; }
                case $choice in
                Install required software and libraries)
                        echo "Installing required software and libraries"
                        sudo apt-get install curl -y
                        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                        sudo apt-key fingerprint 0EBFCD88
                        sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
                        sudo apt-get update -y
                        sudo apt-get install docker-ce -y
                        sudo docker rm `(docker ps -q -f status=exited)`
                        sudo apt-get install openssh-server -y
                        sudo apt-get install vim -y
                        sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
                        sudo chmod +x /usr/local/bin/docker-compose
                        docker-compose --version
                        ;;
                exit)
                        echo "Exiting. "
                        exit 0
                        esac
                 break
        done
done
