#!/usr/bin/env bash

TOMCAT-CONNECTORS='tomcat-connectors-1.2.49.src.tar.gz"

echo ""
echo "Installing Tomcat Connectors" 

tar-xzvf $TOMCAT-CONNECTORS
cd tomcat-connectors-1.2.49.src/native
./configure --with-apxs=/usr/bin/apxs
make && make install

