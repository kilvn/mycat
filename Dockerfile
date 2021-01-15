
# 创建镜像
FROM ubuntu:20.10
RUN apt-get update && apt-get install -y net-tools

# install java
ADD http://mirrors.linuxeye.com/jdk/jdk-7u80-linux-x64.tar.gz /usr/local/
RUN cd /usr/local && tar -zxvf jdk-7u80-linux-x64.tar.gz && ls -lna

ENV JAVA_HOME /usr/local/jdk1.7.0_80
ENV CLASSPATH ${JAVA_HOME}/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:${JAVA_HOME}/bin

# 将宿主机目录下的文件拷贝进镜像且ADD命令会自动处理URL和解压tar压缩包
# 将mycat解压到/usr/local目录中,得到 /usr/local/mycat
ADD http://dl.mycat.org.cn/2.0/1.14-release/mycat2-1.14-release.tar.gz /usr/local
RUN cd /usr/local && tar -xvf mycat2-1.14-release.tar.gz && ls -lna

#download mycat-ef-proxy
#RUN mkdir -p /usr/local/proxy
#ADD https://github.com/LonghronShen/mycat-docker/releases/download/1.6/MyCat-Entity-Framework-Core-Proxy.1.0.0-alpha2-netcore100.tar.gz /usr/local/proxy
#RUN cd /usr/local/proxy && tar -zxvf MyCat-Entity-Framework-Core-Proxy.1.0.0-alpha2-netcore100.tar.gz && ls -lna && sed -i -e 's#C:\\\\mycat#/usr/local/mycat#g' config.json

# 容器数据卷，用于数据保存和持久化工作
VOLUME /usr/local/mycat/conf
# 将mycat的配置文件的地址暴露出映射地址,启动时直接映射宿主机的文件夹
WORKDIR /usr/local/mycat
# 用来在构建镜像过程中设置环境变量
ENV MYCAT_HOME=/usr/local/mycat

# 暴露出MyCat的所需端口
EXPOSE 8066 9066

# 以前台进程的方式启动MyCat服务
CMD ["/usr/local/mycat/bin/mycat", "console", "&"]
