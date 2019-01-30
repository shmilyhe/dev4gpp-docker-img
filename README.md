# 环境准备
为了方便编译我们准备了一个编译的docker 环境
## Dockerfile
建立一个构建Docker 镜像的目录
```
mkdir dev4gpp
```
创建一个编译环境的Dockerfile 文件

文件的目录结构如下：
```
dev4gpp
   |--Dockerfile
```

Dockerfile内容如下：
```
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

```

## 构建Docker 镜像
运行如下命令构建镜像
```
docker build -t dev4gpp:centos7 .
```
运行完成后可以运行如下命令
```
[root@localhost dev4gpp]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
dev4gpp             centos7             016c91f03670        12 minutes ago      712MB
centos              7                   1e1148e4cc2c        7 weeks ago         202MB
```
可以看到 dev4gpp 和 centos 两个镜像


## 运行镜像
执行如下命令进入到
```
docker run --rm -it dev4gpp:centos7 /bin/bash
```
进入到镜像后需要运行如下代码激活g++ 才能开始编译ffmpeg

```
source /opt/rh/devtoolset-7/enable
```

## 编译代码
编译代码需要把本地目录映射到容器里
如：把源码下载到/root/dev_src 下
启动容器时加 -v 参数 把本机的/root/dev_src 映射到容器的/dev_src里面

```
docker run --rm -it -v /root/dev_src:/dev_src shmilyhe/dev4gpp:centos7 /bin/bash
```
进入容器后不要用root账号编译，要创建其它账号，如用vedio用户

```
# 创建vedio账号
useradd vedio
# 使用vedio账号
su vedio
#激活g++
source /opt/rh/devtoolset-7/enable
# 后面开始编译

```




