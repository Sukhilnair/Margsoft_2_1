#!/usr/bin/env bash
while true
do
        echo "@#@#@#@#@#"
        echo "Main Menu"
        echo "@#@#@#@#@#"
        choices=( 'Install_required_software_and_libraries' 'Update_to_the_latest_dockers' 'Copy_necessary_files' 'Configure_ANPR_and_SINK' 'License_Activation' 'Exit' )
        select choice in "${choices[@]}"; do
                [[ -n $choice ]] || { echo "Invalid choice." >&2; continue; }
                case $choice in
                Install_required_software_and_libraries)
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
                Update_to_the_latest_dockers)
                        echo "Please provide the system username(Provided by Margsoft):"
                        read name
                        echo "###########################################"
                        echo "Placing docker compose in the path"
                        sudo cp docker-compose_latest.yml /home/$name/External_Storage/
                        echo "###########################################"
                        echo "Removing the dockers running currently"
                        sudo docker rm -f anpr sink anpr_ui
                        echo "###########################################"
                        echo "Login to Dockerhub..."
                        sudo docker logout
                        sudo docker login --username uvcustomer -p 'd6f9ccaf-208b-4cc5-a71a-a2e2fbaf5f9f'
                        echo "###########################################"
                        echo "Pulling dockers..."
                        sudo docker-compose -f /home/$name/External_Storage/docker-compose_latest.yml up -d
                        ;;
                Copy_necessary_files)
                        sudo mkdir /home/$name/External_Storage/uncanny/lpr_ui
                        sudo cp creds.js /home/$name/External_Storage/uncanny/lpr_ui/
                        sudo cp config_1.json /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json                        
                        sudo cp config_2.json /home/$name/External_Storage/uncanny/anpr/instance2/config/config.json
                        sudo cp anpr.json /home/$name/External_Storage/uncanny/anpr/
                        sudo cp client.js /home/$name/External_Storage/uncanny/sink/client/
                        sudo cp rc.local /etc/
                        sudo cp docker_check.sh /etc/
                        sudo cp rc-local.service /etc/systemd/system/
                        sudo chmod +x /etc/rc.local
                        sudo systemctl enable rc-local
                        sudo systemctl start rc-local
                        sudo docker restart anpr sink anpr_ui
                        ;;
                Configure_ANPR_and_SINK}
                        echo "Number of instance:"
                        read count
                        if [ $count -eq 2 ]
                        then
                                echo "Lane 1 ANPR Camera IP:"
                                read ip1
                                echo "Lane 1 ANPR Camera Username:"
                                read user1
                                echo "Lane 1 ANPR Camera Password:"
                                read pass1
                                echo "Lane 1 AUX Camera IP:"
                                read aux1                                
                                echo "Lane 1 AUX Camera Username:"
                                read auxuser1
                                echo "Lane 1 AUX Camera Password:"
                                read auxpass1
                                echo "Lane 2 ANPR Camera IP:"
                                read ip2
                                echo "Lane 2 ANPR Camera Username:"
                                read user2
                                echo "Lane 2 ANPR Camera Password:"
                                read pass2
                                echo "Lane 2 AUX Camera IP:"
                                read aux2
                                echo "Lane 2 AUX Camera Username:"
                                read auxuser2
                                echo "Lane 3 AUX Camera Password:"
                                read auxpass3
                                curl -X POST "http://localhost:5000/uvanpr/v2/cameras" -H 'Content-Type: application/json'  -d '{ "activated": true, "name": "Lane2", "external_id": 0 }'
                                sed -i "s/ip1/$ip1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                                sed -i "s/user1/$user1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                                sed -i "s/pass1/$pass1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                                sed -i "s/aux1/$aux1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json                                                              
                                sed -i "s/auxusers1/$auxuser1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                                sed -i "s/auxpasss1/$auxpass1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                                sed -i "s/ip2/$ip2/g" /home/$name/External_Storage/uncanny/anpr/instance2/config/config.json
                                sed -i "s/user2/$user2/g" /home/$name/External_Storage/uncanny/anpr/instance2/config/config.json
                                sed -i "s/pass2/$pass2/g" /home/$name/External_Storage/uncanny/anpr/instance2/config/config.json
                                sed -i "s/aux2/$aux2/g" /home/$name/External_Storage/uncanny/anpr/instance2/config/config.json                                
                                sed -i "s/auxusers2/$auxuser2/g" /home/$name/External_Storage/uncanny/anpr/instance2/config/config.json
                                sed -i "s/auxpasss2/$auxpass2/g" /home/$name/External_Storage/uncanny/anpr/instance2/config/config.json
                        else
                                echo "Lane 1 ANPR Camera IP:"
                                read ip1
                                echo "Lane 1 ANPR Camera Username:"
                                read user1
                                echo "Lane 1 ANPR Camera Password:"
                                read pass1
                                echo "Lane 1 AUX Camera IP:"
                                read aux1
                                echo "Lane 1 AUX Camera Username:"
                                read auxuser1
                                echo "Lane 1 AUX Camera Password:"
                                read auxpass1
                                sed -i "s/ip1/$ip1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                                sed -i "s/user1/$user1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                                sed -i "s/pass1/$pass1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                                sed -i "s/aux1/$aux1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                                sed -i "s/auxusers1/$auxuser1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json                                
                                sed -i "s/auxpasss1/$auxpass1/g" /home/$name/External_Storage/uncanny/anpr/instance1/config/config.json
                        fi
                        echo "###########################################"
                        if [ $count -eq 2 ]
                        then
                            echo "System IP:"
                            read sysip
                            sudo cp pm2_list_2.js /home/$name/External_Storage/uncanny/sink/pm2_app.js
                            sudo cp sink_1.json /home/$name/External_Storage/uncanny/sink/config/config_1.json
                            sudo cp sink_2.json /home/$name/External_Storage/uncanny/sink/config/config_2.json
                            sed -i "s/sysip/$sysip/g" ./client_1.json
                            sudo cp client_1.json /home/$name/External_Storage/uncanny/sink/client/
                            sudo cp client_1.json /home/$name/External_Storage/uncanny/sink/client/client_2.json
                        else
                            echo "System IP:"
                            read sysip
                            sudo cp pm2_list.js /home/$name/External_Storage/uncanny/sink/pm2_app.js
                            sudo cp sink_1.json /home/$name/External_Storage/uncanny/sink/config/config_1.json
                            sed -i "s/sysip/$sysip/g" ./client_1.json
                            sudo cp client_1.json /home/$name/External_Storage/uncanny/sink/client/
                        fi
                        sudo docker restart anpr sink anpr_ui
                        ;;
                License_Activation)
                        cd Release_license
                        sudo ln -s /usr/lib/x86_64-linux-gnu/libjsoncpp.so.25 /usr/lib/x86_64-linux-gnu/libjsoncpp.so.1
                        sudo wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb
                        sudo dpkg -i lib*
                        sudo sh run.sh
                        sudo docker restart anpr sink anpr_ui
                        cd ../
                        ;;
                exit)
                        echo "Exiting............. "
                        exit 0
                        esac
                 break
        done
done
