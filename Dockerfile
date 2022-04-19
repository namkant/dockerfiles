FROM centos
EXPOSE 8080
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.62/bin/apache-tomcat-9.0.62.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-9.0.62/* /opt/tomcat/.
WORKDIR /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y update
RUN yum -y install java-11-openjdk-devel
RUN java -version

WORKDIR /opt/tomcat/webapps
RUN curl -O -L https://github.com/AKSarav/SampleWebApp/raw/master/dist/SampleWebApp.war

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
