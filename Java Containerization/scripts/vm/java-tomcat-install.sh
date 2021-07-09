#!/bin/sh

JAVA_PACKAGE=$1
TOMCAT_PACKAGE=$2


echo "Intalling Java"
### Install Java ###
####################
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y $JAVA_PACKAGE
sudo apt-get -y update --fix-missing
sudo apt-get install -y $JAVA_PACKAGE
echo "Intalling Java complete"
echo ""
echo ""

echo "Intalling Tomcat"
### Install Tomcat 9 ###
########################
# Create a tomcat9 group 
sudo groupadd tomcat9 

# Create a new tomcat9 user 
sudo useradd -s /bin/false -g tomcat9 -d /opt/tomcat9 tomcat9 

# Download Apache Tomcat 
cd /tmp 
curl -O $TOMCAT_PACKAGE

# Install tomcat in /opt/tomcat9 directory 
sudo mkdir /opt/tomcat9 
sudo tar xzvf apache-tomcat-*tar.gz -C /opt/tomcat9 --strip-components=1 

# Update permissions for tomcat9 directory 
cd /opt/tomcat9 
sudo chgrp -R tomcat9 /opt/tomcat9 

# Give tomcat9 group read access 
sudo chmod -R g+r conf 
sudo chmod g+x conf 

# Make the tomcat user the owner of the Web apps, work, temp, and logs directories: 
sudo chown -R tomcat9 webapps/ work/ temp/ logs/ bin/
echo "Installing Tomcat complete"
echo ""
echo ""