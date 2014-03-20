#!/bin/bash

set -e

cd ~
if [ -f "./jdk-7u51-linux-x64.tar.gz" ]; then
	echo "Deleting jdk-7u51-linux-x64.tar.gz"
	rm -f jdk-7u51-linux-x64.tar.gz
fi
if [ -d "./jdk1.7.0_51" ]; then
	echo "Deleting jdk1.7.0_51"
	rm -rf jdk1.7.0_51
fi
if [ -d "./java/jdk1.7.0_51" ]; then
	echo "Deleting ./java/jdk1.7.0_51"
	rm -rf $HOME/java/jdk1.7.0_51
fi
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
tar xvf jdk-7u51-linux-x64.tar.gz
rm -rf jdk-7u51-linux-x64.tar.gz
mkdir -p ./java
mv jdk1.7.0_51 ./java
sed -i '/JAVA_HOME/d' .bash_profile
echo "export JAVA_HOME=$HOME/java/jdk1.7.0_51" >> .bash_profile
source .bash_profile
cd -
