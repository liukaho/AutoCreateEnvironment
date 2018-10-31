#!/bin/bash


Install_Docker() 
{
    if [ "${PM}" == "yum" ]; then
        echo "yum install docker"
        yum_install_docker
    elif [ "${PM}" == "unknow" ]; then
        echo "system unsupport"
        exit 1
    else 
        echo "apt-get install docker"
        apt_install_docker
    fi
}

Uninstall_Dokcer()
{
    if [ "${PM}" == "yum" ]; then
        echo "yum uninstall docker"
        yum_uninstall_docker
    elif [ "${PM}" == "unknow" ]; then
        echo "system unsupport"
        exit 1
    else 
        echo "apt-get uninstall docker"
        apt_uninstall_docker
    fi
}

yum_install_docker() 
{
    #remove older version docker
    yum_uninstall_docker
    
    # install required pageages
    yum install -y yum-utils \
        device-mapper-persistent-data \
        lvm2
    
    #
    yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

    # install docker-ce
    yum install -y docker-ce

    # start docker service
    systemctl start docker
}


apt_install_docker() 
{
    #remove older version docker
    apt_uninstall_docker

    #install packages to allow apt to use a repository over https
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

    # add docker's official gpg key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

    # add repository
    add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

    #update apt packages
    apt-get update
    #install docker-ce
    apt-get install -y docker-ce
}

yum_uninstall_docker()
{
        yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine \
                  docker-ce
}


apt_uninstall_docker()
{
    apt-get remove -y docker docker-engine docker.io docker-ce
    apt autoremove -y
}