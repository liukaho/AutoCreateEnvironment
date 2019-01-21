#!/bin/bash

. include/common.sh
. module/docker.sh
. module/docker-compose.sh

Get_Dist_Name
# install docker
Install_Docker
# install docker-compose
Install_Docker_Compose

