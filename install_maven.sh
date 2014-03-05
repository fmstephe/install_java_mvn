#!/bin/bash

set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo `pwd`

cd ~
if [ -f "apache-maven-3.2.1-bin.tar.gz" ]; then
	echo "Deleting apache-maven-3.2.1-bin.tar.gz"
	rm -f jdk-7u51-linux-x64.tar.gz
fi
if [ -d "apache-maven-3.2.1" ]; then
	echo "Deleting apache-maven-3.2.1"
	rm -rf apache-maven-3.2.1
fi
if [ -d "/usr/local/apache-maven/apache-maven-3.2.1" ]; then
	echo "Deleting /usr/local/apache-maven/apache-maven-3.2.1"
	rm -rf /usr/local/apache-maven/apache-maven-3.2.1
fi
wget "http://apache.mirror.anlx.net/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz"
tar xvf apache-maven-3.2.1-bin.tar.gz 
rm -f apache-maven-3.2.1-bin.tar.gz
mkdir -p /usr/local/apache-maven/
mv apache-maven-3.2.1 /usr/local/apache-maven/
sed -i '/M2_HOME/d' .profile
sed -i '/M2/d' .profile
sed -i '/MAVEN_OPTS/d' .profile
echo "export M2_HOME=/usr/local/apache-maven/apache-maven-3.2.1" >> .profile
echo "export M2=\$M2_HOME/bin" >> .profile
echo "export MAVEN_OPTS=\"-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m\"" >> .profile
echo "PATH=\$PATH:\$M2" >> .profile
source .profile
cd -
