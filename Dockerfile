FROM ubuntu:20.10
RUN apt update && apt install -y locales net-tools && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# install java
ADD http://mirrors.linuxeye.com/jdk/jdk-7u80-linux-x64.tar.gz /usr/local/
RUN cd /usr/local && tar -zxvf jdk-7u80-linux-x64.tar.gz && ls -lna

ENV JAVA_HOME /usr/local/jdk1.7.0_80
ENV CLASSPATH ${JAVA_HOME}/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:${JAVA_HOME}/bin

#install mycat
ADD http://dl.mycat.org.cn/2.0/1.14-release/mycat2-1.14-release.tar.gz /usr/local
RUN cd /usr/local && tar -xvf mycat2-1.14-release.tar.gz && ls -lna

#download mycat-ef-proxy
#RUN mkdir -p /usr/local/proxy
#ADD https://github.com/LonghronShen/mycat-docker/releases/download/1.6/MyCat-Entity-Framework-Core-Proxy.1.0.0-alpha2-netcore100.tar.gz /usr/local/proxy
#RUN cd /usr/local/proxy && tar -zxvf MyCat-Entity-Framework-Core-Proxy.1.0.0-alpha2-netcore100.tar.gz && ls -lna && sed -i -e 's#C:\\\\mycat#/usr/local/mycat#g' config.json

VOLUME /usr/local/mycat/conf
VOLUME /usr/local/mycat/logs

EXPOSE 8066 9066

CMD ["/usr/local/mycat/bin/mycat", "console"]
