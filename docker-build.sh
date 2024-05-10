#!/bin/bash

apim_node01_image="node01-apim:1.1"
apim_node02_image="node02-apim:1.1"
mysql_image="server01-mysql:1.1"
network_name="apim-net"

echo "creating docker network $network_name..."
docker network create $network_name 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]
then
   echo $? 2>/dev/null 1>/dev/null
   echo "docker network $network_name already exist"
else
   echo "docker network $network_name created"
fi
echo "building docker image $apim_node01_image..."
docker build -t $apim_node01_image ./apim-node-01
if [ $? -ne 0 ]
then
   echo $? 2>/dev/null 1>/dev/null
   echo "$apim_node01_image build failed"
else
   echo "$apim_node01_image build completed"
fi

echo "building docker image $apim_node02_image..."
docker build -t $apim_node02_image ./apim-node-02
if [ $? -ne 0 ]
then
   echo $? 2>/dev/null 1>/dev/null
   echo "$apim_node02_image build failed"
else
   echo "$apim_node02_image build completed"
fi

echo "building docker image $mysql_image..."
docker build -t $mysql_image ./sqlserver
if [ $? -ne 0 ]
then
   echo $? 2>/dev/null 1>/dev/null
   echo "$mysql_image build failed"
else
   echo "$mysql_image build completed"
fi


