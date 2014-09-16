FROM tutum/tomcat:7.0
MAINTAINER muhammed mohideen < azarirshath@gmail.com>

RUN apt-get update && \
apt-get install -yq --no-install-recommends wget pwgen ca-certificates && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*
ENV TOMCAT_MAJOR_VERSION 7
ENV TOMCAT_MINOR_VERSION 7.0.55
ENV CATALINA_HOME /tomcat
# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
tar zxf apache-tomcat-*.tar.gz && \
rm apache-tomcat-*.tar.gz && \
mv apache-tomcat* tomcat
RUN apt-get update
RUN apt-get install -y x11vnc xvfb firefox
RUN wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/29.0/linux-x86_64/en-US/firefox-29.0.tar.bz2
RUN tar -xjvf firefox-29.0.tar.bz2
RUN mv firefox /opt/firefox29
RUN ln -sf /opt/firefox29/firefox /usr/bin/firefox

# installation of maven 
RUN apt-get update
RUN apt-get install -y maven 

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
EXPOSE 8080
RUN apt-get install unzip
RUN wget https://github.com/prokarma2014/CricketWeb/archive/master.zip
RUN unzip master.zip

RUN cp /CricketWeb-master/CricWebApp.war /tomcat/webapps

RUN mkdir /usr/mavenapp
RUN wget https://github.com/prokarma2014/CricketTest/archive/master.zip
RUN unzip master.zip.1 -d /usr/mavenapp
WORKDIR /usr/mavenapp/CricketTest-master/
RUN cp /run.sh  /usr/mavenapp/CricketTest-master/
RUN apt-get install -y mysql-server-5.6
