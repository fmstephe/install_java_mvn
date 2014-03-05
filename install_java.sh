#!/bin/bash

set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cd ~
if [ -f "./jdk-7u51-linux-x64.tar.gz" ]; then
	echo "Deleting jdk-7u51-linux-x64.tar.gz"
	rm -f jdk-7u51-linux-x64.tar.gz
fi
if [ -d "./jdk1.7.0_51" ]; then
	echo "Deleting jdk1.7.0_51"
	rm -rf jdk1.7.0_51
fi
if [ -d "/usr/lib/java/jdk1.7.0_51" ]; then
	echo "Deleting /usr/lib/java/jdk1.7.0_51"
	rm -rf /usr/lib/java/jdk1.7.0_51
fi
wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
tar xvf jdk-7u51-linux-x64.tar.gz
rm -rf jdk-7u51-linux-x64.tar.gz
mkdir -p /usr/lib/java
mv jdk1.7.0_51 /usr/lib/java
sed -i '/JAVA_HOME/d' .profile
echo "export JAVA_HOME=/usr/lib/java/jdk1.7.0_51" >> .profile
source .profile
cd -
