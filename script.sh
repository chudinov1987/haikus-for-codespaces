#!/bin/bash
echo -e 'deb http://ftp.de.debian.org/debian stretch main \ndeb http://security.debian.org/debian-security stretch/updates main' >> /etc/apt/sources.list
apt update && apt full-upgrade -y && apt install net-tools ethtool linux-igd nload mc htop docker.io -y
echo -e 'EXTIFACE=eth0\nINTIFACE=docker0' >> /etc/default/linux-igd
echo -e 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
/etc/init.d/linux-igd restart && sysctl -p 
touch Dockerfile
echo -e 'FROM debian:buster-slim' >> Dockerfile
echo -e 'RUN cd /tmp && apt update && apt full-upgrade -y && apt install wget libglib2.0-0 netbase -y &&\ ' >> Dockerfile
echo -e 'wget https://update.u.is/downloads/uam/linux/uam-latest_amd64.deb && dpkg -i /tmp/uam-latest_amd64.deb && \' >> Dockerfile
echo -e 'mv /opt/uam/uam /opt/uam/fuck' >> Dockerfile
echo -e 'CMD /opt/uam/fuck --pk 95D9FA93C26D150C7AF040C4107D7F1BE247D8B4AFD66BEBB2CD765D7253EA09 --no-ui' >> Dockerfile
docker build -t fuck:latest .
docker run -d --cap-add=IPC_LOCK --restart always fuck:latest
docker run -d --cap-add=IPC_LOCK --tmpfs /root/.uam --restart always fuck:latest
docker run -d --cap-add=IPC_LOCK --tmpfs /root/.uam --restart always fuck:latest
