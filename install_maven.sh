#!/bin/bash

set -e

cd ~
if [ -f "apache-maven-3.2.1-bin.tar.gz" ]; then
	echo "Deleting apache-maven-3.2.1-bin.tar.gz"
	rm -f jdk-7u51-linux-x64.tar.gz
fi
if [ -d "apache-maven-3.2.1" ]; then
	echo "Deleting apache-maven-3.2.1"
	rm -rf apache-maven-3.2.1
fi
if [ -d "./apache-maven/apache-maven-3.2.1" ]; then
	echo "Deleting ./apache-maven/apache-maven-3.2.1"
	rm -rf ./apache-maven/apache-maven-3.2.1
fi
wget "http://apache.mirror.anlx.net/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz"
tar xvf apache-maven-3.2.1-bin.tar.gz 
rm -f apache-maven-3.2.1-bin.tar.gz
mkdir -p ./apache-maven/
mv apache-maven-3.2.1 ./apache-maven/
sed -i '/M2_HOME/d' .profile
sed -i '/M2/d' .profile
sed -i '/MAVEN_OPTS/d' .profile
echo "export M2_HOME=$HOME/apache-maven/apache-maven-3.2.1" >> .profile
echo "export M2=\$M2_HOME/bin" >> .profile
echo "export MAVEN_OPTS=\"-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m\"" >> .profile
echo "PATH=\$PATH:\$M2" >> .profile
source .profile
cd -
