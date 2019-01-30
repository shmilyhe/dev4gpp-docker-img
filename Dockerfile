FROM centos:7
MAINTAINER eric <shmilyhe@163.com>
RUN yum update -y && \
yum install -y centos-release-scl-rh && \
yum install -y centos-release-scl && \
yum-config-manager --enable rhel-server-rhscl-7-rpms && \
yum install -y devtoolset-7 && \
scl enable devtoolset-7 bash && \
yum install -y git && \
yum install -y cmake && \
echo "source /opt/rh/devtoolset-7/enable" >/root/init.sh && \
chmod 755 /root/init.sh && \
yum install -y wget && wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz && \
tar -zxvf yasm-1.3.0.tar.gz && \
cd yasm-1.3.0 && \
./configure && \
make && \
make install &&\
yum clean all 
